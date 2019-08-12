## Bayesian Machine Learning and Information Processing

[Bert de Vries](http://bertdv.nl) and [Wouter Kouw](https://biaslab.github.io/member/wouter/)                     
Eindhoven University of Technology, Dept. of Electrical Engineering        
Corr. to <bert.de.vries@tue.nl>

This site contains materials for course [5SSD0 (Bayesian Machine Learning and Information Processing)](https://github.com/bertdv/BMLIP) at [TU/e](http://tue.nl).

### Teaching assistants
[Ismail Senoz](https://biaslab.github.io/member/ismail/) and [Magnus Koudahl](https://biaslab.github.io/member/magnus/)

### Read-only versions

You can view the lecture notes through the links below:


- [0 - Course Outline and Administrative Issues](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Course-Outline.ipynb)
- [1 - Machine Learning Overview](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Machine-Learning-Overview.ipynb)
- [2 - Probability Theory Review](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Probability-Review.ipynb)
- [3 - Bayesian Machine Learning](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Bayesian-Machine-Learning.ipynb)
- [4 - Working with Gaussians and Multinomials](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Working-with-Gaussians.ipynb)
- [5 - Simple Density Estimation](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Density-Estimation.ipynb)
- [6 - Regression](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Regression.ipynb)
- [7 - Classification](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Classification.ipynb)
- [9 - Latent Variable Models and Variational Bayes](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Latent-Variable-Models-and-VB.ipynb)
- [10- Probabilistic Programming](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Probabilistic-Programming.ipynb)
- [11- Dynamic Models](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Dynamic-Models.ipynb)
- [12- Intelligent Agents and Active Inference](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Intelligent-Agents-and-Active-Inference.ipynb)
- [13- Applications](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Applications.ipynb)
- [14- What is Life?](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/What-if-Life.ipynb)

### Opening the lecture notes locally

To open the lecture notes in [IJulia](https://github.com/JuliaLang/IJulia.jl), download the .ipynb files to your computer and start a [Jupyter](https://jupyter.org/) notebook by

```
$ jupyter notebook
```

You will now get a new page in your browser with a list of available notebooks. Alternatively, if you don't have Julia/Jupyter installed on your system, you can use [JuliaBox](https://www.juliabox.com/) to run the notebooks (see exact instructions below).

To run the interactive code examples in the lecture nodes, the following Julia packages are required: `Cubature`, `DataFrames`, `Distributions`, `Interact`, `PyPlot`, `Optim`. To install the required packages, execute:

```jl
map(Pkg.add, ["Cubature", "DataFrames", "CSV", "Distributions", "Interact", "PyPlot", "Optim", "SpecialFunctions"])
```

### Creating a PDF bundle of all lessons

Install Docker from https://www.docker.com.

Finally from the root directory of the project issue

```sh
$ docker build -t BMLIP-bundler .
$ docker run --rm \
             --volume ${PWD}/lessons:/BMLIP-bundler/lessons \
             --volume ${PWD}/output:/BMLIP-bundler/output \
             BMLIP-bundler
```

to obtain a `bundle.pdf` file containing all lessons in the `output` directory.

#### License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Bayesian Machine Learning and Information Processing</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Bert de Vries</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>
