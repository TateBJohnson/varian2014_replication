# Replication of Varian (2014) — LASSO Column of Table 4

This repository replicates the LASSO column of Table 4 from Varian (2014),
"Big Data: New Tricks for Econometrics," *Journal of Economic Perspectives*
28(2): 3–28. The specific result is the ordinal ranking of variables selected
by LASSO for predicting cross-country economic growth using the Fernandez, Ley,
and Steel (2001) dataset (72 countries, 41 covariates, 1960–1985). We exactly
reproduce Varian's published rankings at his original penalty parameter
λ = 0.1489, and document how results change under the current version of
`glmnet` (4.1.10).

## Citation

Varian, Hal R. "Big Data: New Tricks for Econometrics."
*Journal of Economic Perspectives* 28, no. 2 (2014): 3–28.
https://doi.org/10.1257/jep.28.2.3

## Data

The raw data file (`input/FLS-data.csv`) is committed directly to this
repository. It is the Fernandez, Ley, and Steel (2001) cross-country growth
dataset, originally compiled by Sala-i-Martín (1997) and distributed with
Varian's replication archive on openICPSR (project 113925). No download step
is required — cloning the repository gives you everything you need.

See `input/data_dictionary.md` for a description of all 42 variables.

## Prerequisites

| Tool     | Version tested     |
|----------|--------------------|
| R        | 4.5.1 (2025-06-13) |
| glmnet   | 4.1.10             |
| TeX Live | 2025 (pdflatex)    |

Install the R dependency:

```r
install.packages("glmnet")
```

## Reproducing the Paper

```bash
git clone https://github.com/TateBJohnson/varian2014_replication.git
cd varian2014_replication
make
```

The final paper will be at `paper/paper.pdf`.

To start from a completely clean state:

```bash
make clean
make
```

Alternatively, use the convenience wrapper:

```bash
bash run_all.sh
```

## Pipeline

```
input/FLS-data.csv
      │
      ▼
code/preprocess.R  →  temp/clean_data.csv
                              │
                              ▼
                      code/analysis.R  →  output/tables/main_result.tex
                                          output/tables/updated_top10.tex
                                          output/figures/cv_plot.png
                                          output/figures/error_plot.png
                                                    │
                                                    ▼
                                          paper/paper.tex  →  paper/paper.pdf
```

## Results

**Varian (2014) reports (λ = 0.1489):**

| Predictor            | Rank |
|----------------------|------|
| Equipment investment | 1    |
| Fraction Confucian   | 2    |
| Fraction Protestant  | 5    |
| Open economy         | 6    |
| Sub-Saharan dummy    | 7    |
| Fraction Muslim      | 8    |
| Degree of capitalism | 9    |
| GDP level 1960       | —    |
| Life expectancy      | —    |
| Rule of law          | —    |

**We obtain (λ = 0.1489, hard-coded from Varian's original code):** Exact match
on all ten entries.

**Updated glmnet 4.1.10** selects λ = 0.0405 via 10-fold cross-validation,
producing a less sparse model with 27 non-zero coefficients. The top two
predictors (equipment investment, fraction Confucian) are stable across both
versions.

## Repository Structure

```
varian2014_replication/
├── input/
│   ├── FLS-data.csv          # Raw data — never modified by code
│   └── data_dictionary.md    # Description of all 42 variables
├── code/
│   ├── preprocess.R          # Loads and validates raw data → temp/
│   ├── analysis.R            # LASSO estimation → output/
│   └── varian_original/      # Varian's original R scripts (reference only)
├── output/
│   ├── figures/              # cv_plot.png, error_plot.png
│   └── tables/               # main_result.tex, updated_top10.tex
├── temp/                     # Intermediate files (gitignored)
├── paper/
│   ├── paper.tex             # LaTeX source
│   └── paper.pdf             # Compiled output
├── Makefile
├── run_all.sh
├── proposal.md
└── README.md
```

## License

Replication code is released for academic use. The underlying data are from
Fernandez, Ley, and Steel (2001) via Varian's openICPSR archive (project
113925).
