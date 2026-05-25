# =============================================================================
# preprocess.R
# Replication of Varian (2014) "Big Data: New Tricks for Econometrics"
# -----------------------------------------------------------------------------
# Reads raw data from input/, performs integrity checks, separates outcome
# and covariates, and writes analysis-ready data to temp/.
#
# Input:  input/FLS-data.csv
# Output: temp/clean_data.csv
# =============================================================================

# --- Load Data ----------------------------------------------------------------

dat <- read.csv("input/FLS-data.csv")

# --- Integrity Checks ---------------------------------------------------------

# Check expected dimensions
stopifnot(nrow(dat) == 72)
stopifnot(ncol(dat) == 42)

# Check no missing values
stopifnot(sum(is.na(dat)) == 0)

# Check outcome variable exists
stopifnot("y" %in% colnames(dat))

# --- Separate Outcome and Covariates ------------------------------------------

y <- dat[, 1]          # outcome: average GDP growth rate 1960-1985
X <- dat[, -1]         # 41 covariates

# --- Write to temp/ -----------------------------------------------------------

write.csv(dat, "temp/clean_data.csv", row.names = FALSE)

# --- Console Summary ----------------------------------------------------------

cat("\n")
cat("Data Summary\n")
cat("============\n")
cat("Source:            input/FLS-data.csv\n")
cat("N countries:      ", nrow(dat), "\n")
cat("N covariates:     ", ncol(X), "\n")
cat("Outcome variable:  y (average GDP growth rate 1960-1985)\n")
cat("Mean y:           ", round(mean(y), 4), "\n")
cat("Std y:            ", round(sd(y), 4), "\n")
cat("Min y:            ", round(min(y), 4), "\n")
cat("Max y:            ", round(max(y), 4), "\n")
cat("Missing values:   ", sum(is.na(dat)), "\n")
cat("Output written to: temp/clean_data.csv\n")
cat("\n")
