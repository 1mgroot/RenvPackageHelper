# This is a simple R script to restore the project environment
# Use this if you don't have Quarto installed yet

# Function to check and install renv
setup_renv <- function() {
  if (!require("renv", quietly = TRUE)) {
    message("renv is not installed. Installing it now...")
    install.packages("renv", repos = "https://cloud.r-project.org")
  }
  library(renv)
  message("✓ renv is ready!")
}

# Function to check if a package is installed
check_package <- function(pkg_name) {
  if (require(pkg_name, character.only = TRUE, quietly = TRUE)) {
    message(sprintf("✓ %s is installed and loaded", pkg_name))
  } else {
    message(sprintf("✗ %s is NOT installed properly", pkg_name))
  }
}

# Main execution
message("Setting up project environment...")

# 1. Setup renv
setup_renv()

# 2. Restore the project environment
message("\nRestoring project environment from renv.lock...")
renv::restore()

# 3. Verify key packages
message("\nVerifying package installation:")
check_package("tidyverse")
check_package("palmerpenguins")

# 4. Print next steps
message("\nNext Steps:")
message("1. Install Quarto from https://quarto.org/docs/get-started/")
message("2. After installing Quarto, you can run the project's .qmd files")
message("3. If you encounter any issues, check that:")
message("   - R is up to date")
message("   - You have write permissions in the project directory")
message("   - Look for any error messages above") 