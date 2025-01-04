# This is a simple R script to restore the project environment
# Use this if you don't have Quarto installed yet

# Function to check and install renv
setup_renv <- function() {
  tryCatch({
    if (!require("renv", quietly = TRUE)) {
      message("renv is not installed. Installing it now...")
      install.packages("renv", repos = "https://cloud.r-project.org")
      if (!require("renv", quietly = TRUE)) {
        stop("Failed to install renv package. Please check your internet connection and R installation.")
      }
    }
    library(renv)
    renv::consent(provided = TRUE)
    
    # Initialize renv if not already initialized
    if (!file.exists("renv/activate.R")) {
      message("\nInitializing renv for the first time...")
      renv::init(bare = TRUE)
    }
    renv::activate()
    message("✓ renv is ready!")
    return(TRUE)
  }, error = function(e) {
    message("\n❌ Error during renv setup: ", e$message)
    return(FALSE)
  })
}

# Function to restore packages
restore_packages <- function() {
  tryCatch({
    message("\nRestoring project environment from renv.lock...")
    if (!file.exists("renv.lock")) {
      stop("renv.lock file not found. Make sure you're in the correct project directory.")
    }
    renv::restore(prompt = FALSE)
    message("✓ Project environment restored successfully!")
    return(TRUE)
  }, error = function(e) {
    message("\n❌ Error during package restoration: ", e$message)
    return(FALSE)
  })
}

# Main execution
message("Setting up project environment...")

# 1. Setup renv
if (!setup_renv()) {
  message("\n❌ Failed to set up renv. Please check the error messages above.")
  quit(status = 1)
}

# 2. Restore project environment
if (!restore_packages()) {
  message("\n❌ Failed to restore packages. Please check the error messages above.")
  message("\nTroubleshooting steps:")
  message("1. Check your internet connection")
  message("2. Verify you have write permissions in the project directory")
  message("3. Make sure you're using a compatible R version")
  message("4. Try removing the renv/library directory and running this script again")
  quit(status = 1)
}

message("\n✓ Setup completed successfully!")
message("You can now run the project's Quarto documents.")