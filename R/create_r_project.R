#' Initializes files and directories for a new R project
#'
#' This function just creates a files and directories I use regularly in a
#' new R project.
#'
#' @param path_to_templates The path to the location of the template, css, and
#'  other files.
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

create_r_project <- function(
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

  # copy lines to .R file
  r_txt <- readLines(
    paste0(path_to_templates, '/template.R')
  )

  # write data import
  writeLines(r_txt, con = '01-data-import.R')

  # write data manipulation
  writeLines(r_txt, con = '02-data-manipulation.R')

  # write analyses
  writeLines(r_txt, con = '03-analyses.R')

  # write visualization
  writeLines(r_txt, con = '04-visualization.R')

  cli::cli_alert_success(
    paste0(
      'Created files: 01-data-import.R, 02-data-manipulation.R, 03-analyses.R, ',
      '04-visualization.R'
    )
  )

  create_report(
    filename = 'anal-report',
  )
}
