# The EM Algorithm as Message Passing

### Preliminaries

- Goals
  -
- Materials
  - Madatory
    - These lecture notes
  - Optional
    - [Dauwels et al. (2009)], pp. 1-5 (sections I,II and III)

###

## plan

- show the problem, AR model w unknown coefficients
- do proof for figure 1 (eqs 13-16)
- w/o proof, expand to table 1
- work out AR (Kalman) w adaptive parameters, section IV-2

Note since maximiztion in f_a with max-product, we need to do max-product in previous lecture

EM Dauwels (13)

$$
\hat{\theta}^{(k+1)} = \underbrace{\arg\max_\theta}_{\text{M-step}} \underbrace{\int_x f(x,\hat{\theta}^{(k)})\,\log f(x,\theta)\,\mathrm{d}x}_{\text{E-step}}
$$


- The quantity $\eta(\theta)$ may be interpreted as a log-domain summary of $f_b$. The message $\exp\left( \eta(\theta) \right)$ is the corresponding 'probability domain' message that is consistent with the semantics of messages as summaries of factors.

Literally Dauwels:
• EM may be used to estimate unknown parameters in a
factor graph model.
• EM may be used to break cycles in a factor graph.
• The EM messages are tractable expressions in some
cases where the sum-product and max-product message
computation rules yields intractable expressions.
• Tabulated EM messages for frequently occuring
nodes / factors allow the composition of nontrivial
EM algorithms without additional computations or
derivations.
