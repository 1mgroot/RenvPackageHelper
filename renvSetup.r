# Phase 1: Initialize renv
init_renv <- function() {
  # Install renv if not already installed
  if (!require("renv")) {
    install.packages("renv")
  }
  
  # Load renv
  library(renv)
  
  # Check if renv is already initialized (look for renv.lock)
  if (!file.exists("renv.lock")) {
    # If no lockfile exists, initialize renv
    cat("Initializing new renv project...\n")
    renv::init(force = TRUE)
  } else {
    # If lockfile exists, just activate
    cat("Project already initialized. Activating renv...\n")
    renv::activate()
  }
}

# Phase 2: Install packages and snapshot
install_packages <- function() {
  # Install required packages
  packages <- c("tidyverse", "palmerpenguins")
  for (pkg in packages) {
    if (!require(pkg, character.only = TRUE)) {
      cat(sprintf("Installing %s...\n", pkg))
      renv::install(pkg)
    }
  }
  
  # Take a snapshot of the current project state
  renv::snapshot(force = TRUE)
  
  # Print message to confirm completion
  cat("\nProject environment has been set up and packages have been captured with renv.\n")
  cat("Other users can restore this environment using renv::restore()\n")
}

# Run Phase 1: Initialize renv
init_renv()

# Note to user: After R restarts, run:
cat("\nAfter R restarts, please run this command to complete setup:\n")
cat("source('renvSetup.r'); install_packages()\n") 

