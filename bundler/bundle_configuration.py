import PyPDF2, atexit, io, os, re, shutil

from PyPDF2.generic import ArrayObject, NameObject, NumberObject
from lxml import html
from pathlib import Path
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4

build_directory = 'bundle'

ipynb_files = []

# Only include ipynb files which are not checkpoints
ipynb_matcher = re.compile("(?<!checkpoint.)ipynb$")

for (directory, _, files) in os.walk('lessons'):
    for filename in files:
        filepath = Path(directory, filename)
        filepath_str = str(filepath)
        if ipynb_matcher.search(filepath_str):
            ipynb_files.append(filepath_str)
        else:
            target_path = Path(build_directory, *filepath.parts[2:])
            target_directory = Path(*target_path.parts[:-1])
            if not target_directory.exists():
                target_directory.mkdir(parents = True)
            shutil.copy(str(filepath), str(target_path))

# The chapters are not necessarily returned in order by the filesystem. Since
# the files have their order embedded in their filename, sorting them here
# should be sufficient
ipynb_files.sort()

# Some cells can take quite a while to render (most notably the lesson on
# clustering with Gaussian Mixture Models), so the timeout has to be increased
# with respect to the default of 30 seconds
c.ExecutePreprocessor.timeout = 120
c.FilesWriter.build_directory = build_directory
c.NbConvertApp.notebooks = ipynb_files
c.Preprocessor.enabled = True

def concat_and_clean():
    bundle_cells = []
    bundle_document = None
    notebook_root = None

    for source_path_str in ipynb_files:
        source_path = Path(source_path_str)
        bundle_path = Path(build_directory, source_path.stem + '.html')

        if bundle_path.exists():
            rendered_file = open(str(bundle_path), 'r', encoding='utf-8')
            html_source = html.fromstring(rendered_file.read())
            rendered_file.close()

            os.remove(str(bundle_path))

            cells = html_source.find_class('cell')

            # If no main document body is available yet, grab it from the first
            # page that is found. Use that as the basis for the entire bundle
            if bundle_document == None:
                bundle_document = html_source
                body_node = bundle_document.xpath('//body')[0]

                cover_file = open('./cover.html', 'r', encoding='utf-8')
                cover_source = html.fromstring(cover_file.read())
                cover_file.close()

                cover_styles = cover_source.xpath('//style')[0]
                bundle_head = bundle_document.xpath('//head')[0]
                bundle_head.insert(2, cover_styles)

                cover_page = cover_source.get_element_by_id('cover-page')
                body_node.insert(0, cover_page)

                # Include the custom styles once, which would have otherwise be
                # included by the final two cells in every rendered notebook
                bundle_file = open(str(Path('styles', 'aipstyle.html')), 'r')
                custom_style_elements = html.fragments_fromstring(bundle_file.read())
                bundle_file.close()

                for element in reversed(custom_style_elements):
                    body_node.insert(0, element)

                # Even though the final two cells will be ignored below they
                # have to be actually removed from the 'base' document to make
                # sure they don't show up at the top of the notebook
                notebook_root = html_source.get_element_by_id('notebook-container')
                notebook_root.remove(cells[-2])
                notebook_root.remove(cells[-1])

            # The final two cells of every rendered notebook are expected to
            # contain the code loading custom CSS, these are not necessary for
            # the bundled version and should therefore be removed
            chapter_node = html.fromstring('<section></section>')
            notebook_root.append(chapter_node)
            for cell in cells[0:-2]:
                chapter_node.append(cell)

    shutil.copy('./styles/bundle.css', str(Path(build_directory, 'custom.css')))

    if bundle_document != None:
        bundle_filename = str(Path(build_directory, 'bundle.html'))
        bundle_file = open(bundle_filename, 'w', encoding='utf-8')
        bundle_file.write(html.tostring(bundle_document).decode('utf-8'))
        bundle_file.close()

        os.system('phantomjs ./print_to_pdf.js bundle/bundle.html')

        # The generated PDF file contains incorrect URIs for the table of
        # contents and the backlinks to the items in it. What used to be
        # 'internal' URIs in the HTML document have become 'external' URIs in
        # the PDF document. These have to be rewritten using a two-pass
        # mechanism. First the location of each of the links (both in the table
        # of contents as in the actual document) are collected. These should,
        # mostly, come in pairs. In the first pass, the location of each of
        # these links is recorded and stored with respect to the link it should
        # be linked from. Then in the second pass, all links are updated to
        # point to the correct page and offset on that page based on the
        # information gathered in the first pass.
        source_pdf = PyPDF2.PdfFileReader('output/AIP-5SSB0.pdf')

        # Link dictionaries store links using their names as key with tuples
        # specifying their corresponding (page, ...) as values
        links = dict()

        # Collect pages and offsets for all internal links
        for page_number in range(0, source_pdf.getNumPages()):
            page = source_pdf.getPage(page_number)
            annotations = page['/Annots'].getObject()
            for annotation in annotations:
                object = annotation.getObject()
                link = object['/A']
                uri = link['/URI']
                if uri[0:7] == 'file://':
                    uri_parts = uri.split('#')
                    if len(uri_parts) > 1:
                        # This is an internal URI
                        if uri_parts[1][0:4] == 'toc-':
                            key = uri_parts[1][4:]
                            links[key] = (page_number, object['/Rect'][3])
                        else:
                            links['toc-' + uri_parts[1]] = (page_number, object['/Rect'][3])

        # Modify all links to point to the proper internal locations
        for page_number in range(0, source_pdf.getNumPages()):
            page = source_pdf.getPage(page_number)
            annotations = page['/Annots'].getObject()
            for annotation in annotations:
                object = annotation.getObject()
                link = object['/A']
                uri = link['/URI']
                if uri[0:7] == 'file://':
                    uri_parts = uri.split('#')
                    if len(uri_parts) > 1:
                        # Always remove the URI pointing to the non-existent
                        # external file
                        del link['/URI']

                        # Not all link targets actually exist in the document (such
                        # as those on the first page), these have to be ignored
                        if uri_parts[1] in links:
                            link_data = links[uri_parts[1]]
                            link.update({
                                NameObject('/D'): ArrayObject([NumberObject(link_data[0]), NameObject('/FitH'), NumberObject(link_data[1])]),
                                NameObject('/S'): NameObject('/GoTo')
                            })
                        else:
                            # Update the rectangle to effectively disable the link
                            object.update({
                                NameObject('/Rect'): ArrayObject([NumberObject(0), NumberObject(0), NumberObject(0), NumberObject(0)])
                            })

        target_pdf = PyPDF2.PdfFileWriter()
        target_pdf.appendPagesFromReader(source_pdf)

        # Manually add page numbers to the table of contents
        toc_stream = io.StringIO()
        toc_canvas = canvas.Canvas(toc_stream, pagesize = A4)
        current_page = 0

        # The first page is the cover page, and thus empty as far as the table of
        # contents is concerned
        def getPageNumber(toc_item):
            return links[toc_item][0]

        toc_links = [link for link in links if link[0:4] == 'toc-']
        for toc_link in sorted(toc_links, key = getPageNumber):
            link_data = links[toc_link]
            if link_data[0] > current_page:
                toc_canvas.showPage()
                current_page = links[toc_link][0]

            target_name = toc_link[4:]
            if target_name in links:
                target_data = links[target_name]
                toc_canvas.drawRightString(575, -10 + link_data[1], '%d' % (target_data[0] + 1))
        toc_canvas.save()

        toc_stream.seek(0)
        toc_pdf = PyPDF2.PdfFileReader(toc_stream)
        for page_number in range(1, toc_pdf.getNumPages()):
            target_page = target_pdf.getPage(page_number)
            target_page.mergePage(toc_pdf.getPage(page_number))

        target_file = open('output/AIP-5SSB0.pdf', 'wb')
        target_pdf.write(target_file)
        target_file.close()

    shutil.rmtree(build_directory)

atexit.register(concat_and_clean)
