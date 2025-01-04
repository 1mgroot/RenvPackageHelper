# R Package Version Control Demo

This project demonstrates R package version control using `renv`. It includes example analyses and tools for managing package dependencies.

## Project Structure

- `renvRestore.R`: Script for restoring project environment
- `currentPackage.qmd`: Document showing current package dependencies
- `testDocument.qmd`: Example analysis using managed packages
- `setup.qmd`: Project setup document
- `renv.lock`: Package version lockfile

## Getting Started

### Prerequisites

- R (version 4.0 or higher)
- RStudio (recommended) or VS Code with R extensions
- Quarto (optional, for rendering .qmd files)

### Setup Instructions

1. Clone this repository
2. Open R in the project directory
3. Run the restoration script twice (the script runs in two phases):

   First run:
   ```R
   source("renvRestore.R")
   ```
   This will:
   - Install renv if needed
   - Initialize the project environment
   - R session will restart automatically

   After R restarts, run again:
   ```R
   source("renvRestore.R")
   ```
   This will:
   - Restore all required packages
   - Verify package installation
   - Show final status

   Note: The two-phase process is necessary because renv requires a clean R session after initialization.

### Project Documents

After setup, you can explore:

1. **Test Document** (`testDocument.qmd`)
   - Example analysis using tidyverse and palmerpenguins
   - Demonstrates basic data manipulation and visualization

2. **Package Information** (`currentPackage.qmd`)
   - Shows R environment details
   - Lists direct and indirect dependencies
   - Provides session information

## Package Management

This project uses `renv` for package management:

- Dependencies are tracked in `renv.lock`
- Project has an isolated package library
- All users get the same package versions

### Common Tasks

- View current dependencies:
  ```R
  renv::dependencies()
  ```
- Update lockfile after adding packages:
  ```R
  renv::snapshot()
  ```
- Restore project state:
  ```R
  renv::restore()
  ```

## Troubleshooting

If you encounter issues:

1. Check R version compatibility
2. Ensure write permissions in the project directory
3. Try removing renv/library and running restore again
4. Check the error messages in the restoration script output
5. If the script seems stuck after first run:
   - Close and reopen R
   - Run the script again

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 