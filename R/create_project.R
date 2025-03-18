#' Initializes files and directories for a new R project
#'
#' This function just creates a files and directories I use regularly in a
#' new R project.
#'
#' @param kind Indicate if the project is R (`r`) or Python (`py`) project.
#' @param path_to_templates The path to the location of the template, css, and
#'  other files. It is assumed that the file for the template is either called
#'  `template.R` or `template.py` within the folder.
#'
#' @returns base directories and R scripts for a new project.
#'
#' @examples
#' # create_r_project(
#' #   path_to_templates = '/my_path_to_templates'
#' # )
#'
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages file.edit
#' @export

create_project <- function(
    kind = 'r',
    path_to_templates = '/Users/phil/Documents/templates'
) {

  if(!requireNamespace('cli')) install.packages('cli')

  out_dir <- getwd()

  # create base directories
  dir.create('./data')
  dir.create('./data/raw')
  dir.create('./data/processed')
  dir.create('./output')
  cli::cli_alert_success(
    paste0(
      'Created directories: `data`, `data/raw`, `data/processed`, `output`.'
    )
  )

  if (kind == 'r') {
    # copy lines to .R file
    r_txt <- readLines(
      paste0(path_to_templates, '/template.R')
    )

    r_txt_env <- readLines(
      paste0(path_to_templates, '/environment.R')
    )

    r_txt_profile <- readLines(
      paste0(path_to_templates, '/.Rprofile')
    )

    # write data import
    writeLines(r_txt_env, con = '00-env-setting.R')

    writeLines(r_txt, con = '01-data-import.R')

    # write data manipulation
    writeLines(r_txt, con = '02-data-manipulation.R')

    # write analyses
    writeLines(r_txt, con = '03-analyses.R')

    # write visualization
    writeLines(r_txt, con = '04-visualization.R')

    # write visualization
    writeLines(r_txt_profile, con = '.Rprofile')

    cli::cli_alert_success(
      paste0(
        'Created files: 00-env-setting.R, 01-data-import.R, 02-data-manipulation.R, 03-analyses.R, ',
        '04-visualization.R', '.Rprofile'
      )
    )
  } else if (kind == 'py') {
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
  }

  # create quarto file
  create_report(
    filename = 'anal-report',
  )
}
