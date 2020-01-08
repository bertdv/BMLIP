## Bayesian Machine Learning and Information Processing

[Bert de Vries](http://bertdv.nl) and [Wouter Kouw](https://biaslab.github.io/member/wouter/)                     
Eindhoven University of Technology, Dept. of Electrical Engineering        
Corr. to <bert.de.vries@tue.nl>

This site contains materials for course [5SSD0 (Bayesian Machine Learning and Information Processing)](https://github.com/bertdv/BMLIP) at [TU/e](http://tue.nl).


### Teaching assistants
[Ismail Senoz](https://biaslab.github.io/member/ismail/) and [Magnus Koudahl](https://biaslab.github.io/member/magnus/)

### Read-only versions of the lecture notes

You can view the lecture notes through the links below:

#### <span style="color:ref">NOTE: ALL MATERIALS BELOW ARE CURRENTLY UNDER CONSTRUCTION</span>

#### Fundamentals

- [0 - Course Outline and Administrative Issues](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Course-Outline-and-Admin-Issues.ipynb)
- [1 - Machine Learning Overview](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Machine-Learning-Overview.ipynb)
- [2 - Probability Theory Review](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Probability-Theory-Review.ipynb)
- [3 - Bayesian Machine Learning](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Bayesian-Machine-Learning.ipynb)
- [4 - Continuous Data and the Gaussian Distribution](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/The-Gaussian-Distribution.ipynb)
- [5 - Discrete Data and the Multinomial Distribution](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/The-Multinomial-Distribution.ipynb)
- [6 - Regression](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Regression.ipynb)
- [7 - Generative Classification](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Generative-Classification.ipynb)
- [8 - Discriminative Classification](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Discriminative-Classification.ipynb)

#### Advanced Materials

- [9 - Latent Variable Models and Variational Bayes](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Latent-Variable-Models-and-VB.ipynb)
- [10- Factor Graphs](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Factor-Graphs.ipynb)
- [11- Dynamic Models](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Dynamic-Models.ipynb)
- [12- Intelligent Agents and Active Inference](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Intelligent-Agents-and-Active-Inference.ipynb)

#### Minicourse Probabilistic Programming

- [13- PP Introduction](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-intro.ipynb)    
- 14- Linear Regression & Classification    
  - [with Monte Carlo Sampling](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-1-sampling.ipynb)  
  - [with Variational Inference](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-1-variational.ipynb)
- 15- Gaussian Mixture Model    
  - [with Monte Carlo Sampling](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-2-sampling.ipynb)
  - [with Variational Inference](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-2-variational.ipynb)       
- 16- Hidden Markov Model    
  - [with Monte Carlo Sampling](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-3-sampling.ipynb)  
  - [with Variational Inference](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-3-variational.ipynb)       
- 17- Kalman Filtering     
  - [with Monte Carlo sampling](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-4-sampling.ipynb)
  - [with Variational Inference](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/probprog/Probabilistic-Programming-4-variational.ipynb)

#### Bonus lectures

- [18- What is Life?](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/What-is-Life.ipynb)


### Exercises 

In order to prepare for the exam, it is advised to review the following exercises

- [Exercises (without solutions)](http://nbviewer.ipython.org/github/bertdv/BMLIP/blob/master/lessons/notebooks/Exercises.ipynb)


### Opening the lecture notes locally

In order to open the lecture notes in [IJulia](https://github.com/JuliaLang/IJulia.jl), download the .ipynb files to your computer and start a [Jupyter](https://jupyter.org/) notebook by

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
