# Simple script to restore project environment
# Phase tracking
get_phase <- function() {
  if (file.exists(".renv_restore_phase")) as.numeric(readLines(".renv_restore_phase")) else 1
}

# Main functions
setup_renv <- function() {
  tryCatch({
    if (!require("renv", quietly = TRUE)) {
      install.packages("renv", repos = "https://cloud.r-project.org")
      library(renv)
    }
    renv::consent(provided = TRUE)
    if (!file.exists("renv/activate.R")) renv::init(bare = TRUE)
    renv::activate()
    TRUE
  }, error = function(e) {
    message("❌ Error: ", e$message)
    FALSE
  })
}

restore_packages <- function() {
  tryCatch({
    if (!file.exists("renv.lock")) stop("renv.lock not found")
    renv::restore(prompt = FALSE)
    status <- renv::status()
    if (!is.null(status) && !all(status$synchronized)) {
      message("\nFixing package inconsistencies...")
      renv::repair()
      Sys.sleep(2)
      if (!all(renv::status()$synchronized)) {
        stop("Packages still inconsistent after repair")
      }
    }
    TRUE
  }, error = function(e) {
    message("❌ Error: ", e$message)
    FALSE
  })
}

# Main execution
phase <- get_phase()
message("Phase ", phase, " of 2")

if (phase == 1) {
  if (!setup_renv()) {
    message("\nTroubleshooting: Check R installation and internet connection")
    quit(status = 1)
  }
  writeLines("2", ".renv_restore_phase")
  quit(save = "no", status = 0)
}

if (phase == 2) {
  if (!restore_packages()) {
    message("\nTroubleshooting:")
    message("1. Run renv::repair()")
    message("2. Check write permissions")
    message("3. Remove renv/library and retry")
    quit(status = 1)
  }
  file.remove(".renv_restore_phase")
}

message("\n✓ Environment restored successfully!")
renv::status()