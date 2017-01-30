## Adaptive Information Processing

**Bert de Vries**, **Tjalling Tjalkens** and **Marco Cox**
Eindhoven University of Technology, Dept. of Electrical Engineering
Corr. to <bert.de.vries@tue.nl>

This site contains materials for course [5SSB0 (Adaptive Information Processing)](http://bertdv.github.io/teaching/AIP-5SSB0/) at [TU/e](http://tue.nl).


### Read-only versions

You can view the lecture notes through the links below:

- [0 - Introduction](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/00_introduction/Introduction.ipynb)
- [1 - Machine Learning Overview](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/01_machine_learning_overview/Machine-Learning-Overview.ipynb)
- [2 - Probability Theory Review](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/02_probability_review/Probability-Review.ipynb)
- [3 - Bayesian Machine Learning](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/03_Bayesian_machine_learning/Bayesian-Machine-Learning.ipynb)
- [4 - Working with Gaussians](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/04_working_with_Gaussians/Working-with-Gaussians.ipynb)
- [5 - Density Estimation](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/05_density_estimation/Density-Estimation.ipynb)
- [6 - Linear Regression](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/06_linear_regression/Linear-Regression.ipynb)
- [7 - Generative Classification](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/07_generative_classification/Generative-Classification.ipynb)
- [8 - Discriminative Classification](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/08_discriminative_classification/Discriminative-Classification.ipynb)
- [9 - Clustering with Gaussian Mixture Models](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/09_clustering_with_Gaussian_mixture_models/Clustering-with-Gaussian-Mixture-Models.ipynb)
- [10- The EM Algorithm](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/10_the_EM_algorithm/The-General-EM-Algorithm.ipynb)
- [11- Continuous Latent Variable Models - PCA and FA](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/11_continuous_latent_variable_models/Continuous-Latent-Variable-Models-PCA-and-FA.ipynb)
- [12- Factor Graphs and Message Passing Algorithms](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/12_factor_graphs/Factor-Graphs-and-Message-Passing-Algorithms.ipynb)
- [13- Dynamic Latent Variable Models](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/13_dynamic_latent_variable_models/Dynamic-Latent-Variable-Models.ipynb)
- [14- EM as a Message Passing Algorithm](http://nbviewer.ipython.org/github/bertdv/AIP-5SSB0/blob/master/lessons/14_EM_as_message_passing/EM-as-Message-Passing.ipynb)


### Opening the lecture notes locally

To open the lecture notes in [IJulia](https://github.com/JuliaLang/IJulia.jl), download the .ipynb files to your computer and start a [Jupyter](https://jupyter.org/) notebook by

```
$ jupyter notebook
```

You will now get a new page in your browser with a list of available notebooks. Alternatively, if you don't have Julia/Jupyter installed on your system, you can use [JuliaBox](https://www.juliabox.com/) to run the notebooks (see exact instructions below).

To run the interactive code examples in the lecture nodes, the following Julia packages are required: `Cubature`, `DataFrames`, `Distributions`, `Interact`, `PyPlot`, `Optim`. To install the required packages, execute:

```jl
map(Pkg.add, ["Cubature", "DataFrames", "Distributions", "Interact", "PyPlot", "Optim"])
```

### Running the lecture notes on JuliaBox.com

Follow these instructions to run the code examples from the lecture notes online through [JuliaBox](https://www.juliabox.com/).

1. **(Create account)**
   Go to https://www.juliabox.com/, create an account and log in.

2. **(Install required packages)**
   Go to the `Console` tab, and then start a Julia shell by typing `julia`.

   In the Julia shell, execute the following command to install all required packages:

   ```jl
   map(Pkg.add, ["Cubature", "DataFrames", "Distributions", "Interact", "PyPlot", "Optim"])
   ```

   Afterwards, type `exit()` to quit Julia.

3. **(Import lecture notes into JuliaBox)**
   Go to the `Sync` tab, and add the lecture notes git repository through the following actions:
 1. Paste `https://github.com/bertdv/AIP-5SSB0.git` in the `Git Clone URL` field
 2. Click with the mouse in the `branch` field. You should get `master` in the `branch` field and `AIP-5SSB0` in the `juliabox` field.
 3. Press the "+" button.

You can now open the lecture notes by going to the `Jupyter` tab (press the refresh button if the folder `AIP-5SSB0` does not show up). Navigate to a specific lesson and click the `.ipynb` file to open the notebook.

### Creating a PDF bundle of all lessons

This procedure will only be able to generate the PDF bundle for all lessons if
ForneyLab is available as it is used for the later chapters. This is not
publicly available software, so the functionality is limited for those who do
not have access to it.

Get ForneyLab.jl. Either clone it in the root of the project or modify the path
in the Dockerfile to point at your own installation. If you do not have access
to it, but do want to generate a PDF of the remaining lessons, just create an
empty `ForneyLab.jl` directory.

Install Docker from https://www.docker.com.

Finally from the root directory of the project issue

```sh
$ docker build -t aip-5ssb0-bundler .
$ docker run --rm \
             --volume ${PWD}/lessons:/aip-5ssb0-bundler/lessons \
             --volume ${PWD}/output:/aip-5sbb0-bundler/output \
             aip-5ssb0-bundler
```

to obtain a `bundle.pdf` file containing all lessons in the `output` directory.

#### License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Adaptive Information Processing (5SSB0)</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Bert de Vries, Tjalling Tjalkens and Marco Cox</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/bertdv/AIP-5SSB0" rel="dct:source">https://github.com/bertdv/AIP-5SSB0</a>.
