# Replication Proposal — GSE 552

## 1. Full Citation

Varian, Hal R. "Big Data: New Tricks for Econometrics." *Journal of Economic Perspectives* 28, no. 2 (2014): 3–28. https://doi.org/10.1257/jep.28.2.3

## 2. Data Source

Fernandez, C., Ley, E., & Steel, M. F. J. (2001). Replication data hosted by Varian (2014) on openICPSR:
https://www.openicpsr.org/openicpsr/project/113925/version/V1/view

## 3. Result to Replicate

I will replicate the LASSO column of Table 4 in Varian (2014, *Journal of Economic Perspectives*), which reports the ordinal rank of importance among variables selected by LASSO for predicting cross-country economic growth. Specifically, the target result is:

- Equipment investment: Rank 1
- Fraction Confucian: Rank 2
- Fraction Protestant: Rank 5
- Open economy: Rank 6
- Sub-Saharan dummy: Rank 7
- Fraction Muslim: Rank 8
- Degree of capitalism: Rank 9
- GDP level 1960: — (zeroed out)
- Life expectancy: — (zeroed out)
- Rule of law: — (zeroed out)

These rankings are produced by fitting LASSO with penalty parameter $\lambda = 0.1489$ (selected by cross-validation) to the Fernandez, Ley, and Steel (2001) dataset of 72 countries and 41 covariates.

## 4. Planned Toolchain

- Language: **R**
- Packages: `glmnet` (LASSO estimation), base R only otherwise
- No non-standard packages required

## 5. Why This Paper Interests Me

Varian (2014) is a landmark paper that introduced machine learning methods to
a broad economics audience, arguing that LASSO and related techniques offer
powerful tools for variable selection that are underutilized in empirical
economics. The paper is directly relevant to the causal ML methods covered in
GSE 552 — LASSO variable selection is the first step in pipelines like Double
LASSO (Belloni et al., 2014) and Double/Debiased ML (Chernozhukov et al.,
2018), making it a natural bridge between prediction and causal inference.

What I find most striking about this paper is the computational contrast at its
center. Sala-i-Martín (1997) famously ran over two million regressions —
exhaustively evaluating all manageable subsets of 41 growth covariates — to
construct his CDF(0) measure of variable importance. Varian shows that LASSO
arrives at a strikingly similar ranking of important predictors by solving a
single penalized regression. The top variables identified by both approaches
overlap substantially, yet LASSO requires a fraction of a second of compute
time rather than millions of model evaluations. This efficiency is not merely
convenient: it scales to settings where exhaustive search is computationally
infeasible, which is precisely the high-dimensional world that modern causal ML
inhabits. Replicating this result felt like watching the punchline of Varian's
paper land in real time.