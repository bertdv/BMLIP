var webpage = require('webpage');

var system = require('system');
var url = system.args[1];

var capture = function capture(page, pageUrl, callback) {
  page.open(pageUrl, function(status) {
    var interval, allDone;

    if(status !== 'success') {
      callback(new Error('Error rendering page'));
      return;
    }

    allDone = page.evaluate(function() {
      if(window.MathJax) {
        MathJax.Hub.Register.StartupHook('End', function() {
          window.allDone = 1;
        });
        return false;
      } else {
        return true;
      }
    });

    if(allDone) {
      callback();
      return;
    }

    interval = setInterval(function() {
      var allDone = page.evaluate(function() {
        return window.allDone;
      });

      if(allDone) {
        clearInterval(interval);
        callback();
      }
    }, 100);
  });
};

var page = webpage.create();

page.onError = function(msg, trace) {
  console.error(msg);
  trace.forEach(function(item) {
    console.error('  ', item.file, ':', item.line);
  });
};

page.paperSize = {
  footer: {
    contents: phantom.callback(function(pageNum, numPages) {
      if(pageNum > 1) {
        return '<span style="float: right; font-size: 75%">' + pageNum + '/' + numPages + '</span>';
      } else {
        return '';
      }
    }),
    height: '1.2cm',
  },
  format: 'A4'
};

capture(page, system.args[1], function(error) {
  if(error) {
    console.error(error);
    phantom.exit(1);
  } else {
    page.render('AIP-5SSB0.pdf', { format: 'pdf' });
    phantom.exit(0);
  }
});
