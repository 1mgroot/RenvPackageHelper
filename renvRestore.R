# This is a simple R script to restore the project environment
# Use this if you don't have Quarto installed yet

# Save the script's phase in a file
save_phase <- function(phase) {
  writeLines(as.character(phase), ".renv_restore_phase")
}

# Read the current phase
get_phase <- function() {
  if (file.exists(".renv_restore_phase")) {
    as.numeric(readLines(".renv_restore_phase"))
  } else {
    1
  }
}

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

# Function to check package status
check_package_status <- function() {
  status <- renv::status()
  if (!is.null(status)) {
    message("\nChecking package status...")
    print(status)
    # Check if any packages are not synchronized
    if (length(status$synchronized) > 0 && !all(status$synchronized)) {
      return(FALSE)
    }
  }
  return(TRUE)
}

# Function to restore packages
restore_packages <- function() {
  tryCatch({
    message("\nRestoring project environment from renv.lock...")
    if (!file.exists("renv.lock")) {
      stop("renv.lock file not found. Make sure you're in the correct project directory.")
    }
    
    # Save next phase before restoration (in case of restart)
    save_phase(2)
    
    # Try to restore packages
    renv::restore(prompt = FALSE)
    
    # Check package status
    if (!check_package_status()) {
      message("\nAttempting to fix package inconsistencies...")
      renv::repair()
      Sys.sleep(2)  # Give some time for the repair to complete
      if (!check_package_status()) {
        stop("Some packages are still in an inconsistent state.")
      }
    }
    
    message("✓ Project environment restored successfully!")
    return(TRUE)
  }, error = function(e) {
    message("\n❌ Error during package restoration: ", e$message)
    return(FALSE)
  })
}

# Main execution
current_phase <- get_phase()
message(sprintf("Starting restoration (Phase %d)...", current_phase))

if (current_phase == 1) {
  # Phase 1: Setup renv
  if (!setup_renv()) {
    message("\n❌ Failed to set up renv. Please check the error messages above.")
    quit(status = 1)
  }
  save_phase(2)
  message("\nPhase 1 complete. Restarting R...")
  quit(save = "no", status = 0)
}

if (current_phase == 2) {
  # Phase 2: Restore packages
  if (!restore_packages()) {
    message("\n❌ Failed to restore packages. Please check the error messages above.")
    message("\nTroubleshooting steps:")
    message("1. Check your internet connection")
    message("2. Verify you have write permissions in the project directory")
    message("3. Make sure you're using a compatible R version")
    message("4. Try these commands manually:")
    message("   renv::repair()")
    message("   renv::restore(prompt = FALSE)")
    message("5. If still having issues:")
    message("   - Remove renv/library directory")
    message("   - Remove .renv_restore_phase file")
    message("   - Run this script again")
    quit(status = 1)
  }
  
  # Clean up phase file
  if (file.exists(".renv_restore_phase")) {
    file.remove(".renv_restore_phase")
  }
}

message("\n✓ Setup completed successfully!")
message("You can now run the project's Quarto documents.")

# Final status check
message("\nFinal environment check:")
renv::status()