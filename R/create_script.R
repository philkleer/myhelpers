#' Creates R script template in working directory
#'
#' This function just creates a R script file based on the saved template as
#'  draft in the package folder.
#'
#' @param filename The name of the created file. You don't have to
#'  add \code{.R}.
#' @param kind indicate if you want to create R (`r`) or Python (`py`) file.
#' @param path The path were to store and build everything. Default is working
#'  directory
#' @param draftname The path to the draft file. Default name is \code{template.R}.
#' @param path_to_templates The path to the location of the template, css, and
#'  other files.
#'
#' @returns R script based on the template.
#'
#' @examples
#' # create_script(
#' #   filename = NULL,
#' #   kind = 'r',
#' #   path = './',
#' #   draftname = 'template',
#' #   path_to_templates = '/my_path_to_templates'
#' # )
#'
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages file.edit
#' @export

create_script <- function(
    filename = NULL,
    kind = 'r',
    path = './',
    draftname = 'template',
    path_to_templates = '/Users/phil/Documents/templates'
) {

  if(!requireNamespace('cli')) install.packages('cli')

  if (is.null(filename)) {
    stop('You must provide a valid filename')
  }

  out_dir <- getwd()

  if (kind == 'r') {
    ending = '.R'
  } else if (kind == 'py') {
    ending = '.py.'
  }

  new_file <- file.path(paste0(path, filename, ending))

  if (!file.exists(new_file)) {
    file.create(new_file)
    cli::cli_alert_success('Created `.R` file')

    # copy lines to .R file
    if (kind == 'r') {
      r_txt <- readLines(paste0(path_to_templates, '/template.R'))
    } else if (kind == 'py') {
      r_txt <- readLines(paste0(path_to_templates, '/template.py'))
    }

    # write to new file
    writeLines(r_txt, con = new_file)
    cli::cli_alert_success('File created')
  }

  # open the new file in the editor
  file.edit(paste0(filename, ending, collapse = ''))
}
