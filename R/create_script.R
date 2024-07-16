#' Creates R script template in working directory
#'
#' This function just creates a R script file based on the saved template as
#'  draft in the package folder.
#'
#' @param filename The name of the created file. You don't have to
#'  add \code{.R}.
#' @param draftname The path to the draft file. If not indicated, the package
#'  included draft file will be used.
#' @param ext_name The name of extension to get the files from. Default
#'  'myhelpers'.
#'
#' @returns R script based on the template.
#'
#' @examples
#' # create_script(
#' #   filename = NULL,
#' #   draftname = '_extensions/myhelpers/template.R',
#' #   ext_name = 'myhelpers'
#' # )
#'
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages file.edit
#' @export

create_script <- function(
    filename = NULL,
    draftname = '_extensions/myhelpers/template.R',
    ext_name = 'myhelpers'
) {

  if(!requireNamespace('cli')) install.packages('cli')

  if (is.null(filename)) {
    stop('You must provide a valid filename')
  }

  out_dir <- getwd()

  # check for available extensions
  stopifnot('Extension not in package' = ext_name %in% c('myhelpers'))

  new_file <- file.path(paste0(filename, '.R'))
  if (!file.exists(new_file)) {
    file.create(new_file)
    cli::cli_alert_success('Created `.R` file')

    # copy lines to .R file
    r_txt <- readLines(
      system.file(
        '/extdata/_extensions/myhelpers/template.R',
        package = 'myhelpers',
        mustWork = TRUE
      )
    )

    # write to new file
    writeLines(r_txt, con = new_file)
    cli::cli_alert_success('`.R` contents copied')
  }

  # open the new file in the editor
  file.edit(paste0(filename, '.R', collapse = ''))
}
