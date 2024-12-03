#' Initializes files and directories for a new Python project
#'
#' This function just creates a files and directories I use regularly in a
#' new Python project.
#'
#' @param path_to_templates The path to the location of the template, css, and
#'  other files.
#'
#' @returns base directories and Python scripts for a new project.
#'
#' @examples
#' # create_py_project(
#' #   path_to_templates = '/my_path_to_templates'
#' # )
#'
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages file.edit
#' @export

create_py_project <- function(
    path_to_templates = '/Users/phil/Documents/templates'
) {

  if(!requireNamespace('cli')) install.packages('cli')

  out_dir <- getwd()

  # create base directories
  dir.create('./data')
  dir.create('./data/raw')
  dir.create('./data/processed')
  dir.create('./output')
  dir.create('./utils')

  cli::cli_alert_success(
    paste0(
      'Created directories: `data`, `data/raw`, `data/processed`, `output`,',
      ' `utils`.'
    )
  )

  # copy lines to .R file
  r_txt <- readLines(
    paste0(path_to_templates, '/template.py')
  )

  # write data import
  writeLines(r_txt, con = '01-data-import.py')

  # write data manipulation
  writeLines(r_txt, con = '02-data-manipulation.py')

  # write analyses
  writeLines(r_txt, con = '03-analyses.py')

  # write visualization
  writeLines(r_txt, con = '04-visualization.py')

  cli::cli_alert_success(
    paste0(
      'Created files: 01-data-import.py, 02-data-manipulation.py, 03-analyses.py, ',
      '04-visualization.py'
    )
  )

  file.copy(
    from = paste0(path_to_templates, '/environment-report.py'),
    to = './utils/environment-report.py',
    overwrite = FALSE,
    copy.mode = TRUE,
    copy.date = FALSE
  )

  file.copy(
    from = paste0(path_to_templates, '/script-for-infos.py'),
    to = './utils/script-for-infos.py',
    overwrite = FALSE,
    copy.mode = TRUE,
    copy.date = FALSE
  )

  cli::cli_alert_success(
    paste0(
      'Created files for environment check in folder `utils`.'
    )
  )

  create_report(
    filename = 'anal-report',
  )

  cli::cli_alert_success(
    paste0(
      'Created qmd-report file.'
    )
  )
}
