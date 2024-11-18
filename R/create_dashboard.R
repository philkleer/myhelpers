#' Create a quarto dashboard
#'
#' Creates personal quarto template for a dashboard in working directory.
#'
#' @param filename The name of the created file. You don't have
#'  to add \code{.qmd}.
#' @param draftname The path to the draft file. If not indicated, the package
#'  included draft file will be used.
#' @param ext_name The name of extension to get the files from.
#'  Default 'myhelpers'.
#' 
#' @returns \code{qmd}-file for a \code{dashboard} based on the template.
#'
#' @examples
#' # create_dashboard(
#' #   filename = NULL,
#' #   draftname = '_extensions/myhelpers/draft-report.qmd',
#' #   ext_name = 'myhelpers'
#' # )
#'
#' @importFrom cli cli_alert_success cli_progress_step cli_alert_info
#'  cli_alert_danger
#' @importFrom utils install.packages
#'
#' @export
create_dashboard <- function(
  filename = NULL,
  draftname = '_extensions/myhelpers/draft-dashboard.qmd',
  ext_name = 'myhelpers'
) {

if(!requireNamespace('cli')) install.packages('cli')

if (is.null(filename)) {
  stop('You must provide a valid filename')
}

out_dir <- getwd()

# check for available extensions
stopifnot('Extension not in package' = ext_name %in% c('myhelpers'))

# check for existing _extensions directory
if(!file.exists('_extensions')) dir.create('_extensions')
cli::cli_alert_success('Created `_extensions` folder')

# Create folder for recursive copying into ahead of time
if(!file.exists(paste0('_extensions/', ext_name)))
  dir.create(paste0('_extensions/', ext_name))
cli::cli_alert_success('Created `_extensions/myhelpers` folder')

# copy from internals

cli::cli_progress_step(
  'Copying template files and style files ...',
  spinner = TRUE
)

# Copying _brand.yml
file.copy('_extensions/myhelpers/_brand.yml', './')

# copy my template
file.copy(
  from = system.file(
    paste0(
      'extdata/_extensions/',
      ext_name
    ),
    package = 'myhelpers'
  ),
  to = paste0('_extensions/'),
  overwrite = TRUE,
  recursive = TRUE,
  copy.mode = TRUE
)

# Create folder for recursive copying into ahead of time
if (draftname == '_extensions/myhelpers/draft-report.qmd') {
  file.copy(
    from = '_extensions/myhelpers/assets/',
    to = './',
    recursive = TRUE
  )
}

# create new qmd report based on skeleton
readLines(draftname) |>
  writeLines(
    text = _,
    con = paste0(filename, '.qmd', collapse = '')
  )

cli::cli_alert_success('Dashboard file created.')
# open the new file in the editor
# file.edit(paste0(filename, '.qmd'))
}
