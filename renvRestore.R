# This is a simple R script to restore the project environment
# Use this if you don't have Quarto installed yet

# Function to check and install renv
setup_renv <- function() {
  if (!require("renv", quietly = TRUE)) {
    message("renv is not installed. Installing it now...")
    install.packages("renv", repos = "https://cloud.r-project.org")
  }
  library(renv)
  
  # Initialize renv if not already initialized
  if (!file.exists("renv/activate.R")) {
    message("\nInitializing renv for the first time...")
    renv::init(bare = TRUE)
  }

  message("✓ renv is ready!")
}

# Main execution
message("Setting up project environment...")

# 1. Setup renv
setup_renv()

# 2. Restore the project environment
message("\nRestoring project environment from renv.lock...")
renv::consent(provided = TRUE)
renv::restore()