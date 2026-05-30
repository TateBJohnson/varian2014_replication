.PHONY: all clean

all: paper/paper.pdf

# -----------------------------------------------------------------------------
# Step 1: Preprocessing
# Reads input/FLS-data.csv, runs integrity checks, writes temp/clean_data.csv
# -----------------------------------------------------------------------------
temp/clean_data.csv: input/FLS-data.csv code/preprocess.R
	Rscript code/preprocess.R

# -----------------------------------------------------------------------------
# Step 2: Analysis
# Reads temp/clean_data.csv, runs LASSO, writes all tables and figures
# -----------------------------------------------------------------------------
output/tables/main_result.tex output/tables/updated_top10.tex \
output/figures/cv_plot.png output/figures/error_plot.png: \
temp/clean_data.csv code/analysis.R
	Rscript code/analysis.R

# -----------------------------------------------------------------------------
# Step 3: Paper compilation
# Reads paper.tex + all output files, compiles PDF (run twice for references)
# -----------------------------------------------------------------------------
paper/paper.pdf: paper/paper.tex \
output/tables/main_result.tex output/tables/updated_top10.tex \
output/figures/cv_plot.png output/figures/error_plot.png
	cd paper && pdflatex paper.tex && pdflatex paper.tex

# -----------------------------------------------------------------------------
# Clean: removes all regenerable files (temp, outputs, paper PDF)
# -----------------------------------------------------------------------------
clean:
	rm -f temp/*.csv
	rm -f output/tables/*.tex
	rm -f output/figures/*.png
	rm -f paper/paper.pdf paper/paper.aux paper/paper.log \
	      paper/paper.out paper/paper.toc
