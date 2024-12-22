#' Create a quarto dashboard
#'
#' Creates personal quarto template for a dashboard in working directory.
#'
#' @param filename The name of the created file. You don't have
#'  to add \code{.qmd}.
#' @param path The path were to store and build everything. Default is working
#'  directory
#' @param draftname The path to the draft file. If not indicated, the package
#'  included draft file will be used.
#' @param path_to_templates The path to the location of the template, css, and
#'  other files.
#'
#' @returns \code{qmd}-file for a \code{dashboard} based on the template.
#'
#' @examples
#' # create_dashboard(
#' #   filename = NULL,
#' #   path = './',
#' #   draftname = 'draft-dashboard.qmd',
#' #   path_to_templates = '/my_path_to_templates/',
#' # )
#'
#' @importFrom cli cli_alert_success cli_progress_step cli_alert_info
#'  cli_alert_danger
#' @importFrom utils install.packages
#'
#' @export
create_dashboard <- function(
  filename = NULL,
  path = './',
  draftname = 'draft-dashboard.qmd',
  path_to_templates = '/Users/phil/Documents/templates/quarto/'
) {

  if(!requireNamespace('cli')) install.packages('cli')

  if (is.null(filename)) {
    stop('You must provide a valid filename')
  }

  out_dir <- getwd()

  # copy from internals
  cli::cli_progress_step(
    'Copying template files and style files ...',
    spinner = TRUE
  )

  # Create folder for recursive copying into ahead of time
  if (draftname == 'draft-dashboard.qmd') {

    if (dir.exists(paste0(path_to_templates, 'assets'))) {
      # copying all assets
      file.copy(
        from = paste0(path_to_templates, 'assets'),
        to = path,
        overwrite = TRUE,
        recursive = TRUE,
        copy.mode = TRUE
      )

      cli::cli_alert_success('Copied all assets into project directory.')
    }

    # create new qmd report based on draft or blank
    if (file.exists(paste0(path_to_templates, 'draft-dashboard.qmd'))) {
      readLines(paste0(path_to_templates, 'draft-dashboard.qmd')) |>
        writeLines(
          text = _,
          con = paste0(path, filename, '.qmd', collapse = '')
        )

      cli::cli_alert_success('Created qmd-file based on `draft-dashboard.qmd`.')

    } else {
      cli::cli_alert_info('`draft-dashboard.qmd` does not exist in `path_to_templates`.')

      readLines(draftname) |>
        writeLines(
          text = _,
          con = paste0(filename, '.qmd', collapse = '')
        )

      cli::cli_alert_info('A blank qmd-file was created.')
    }
  } else {
    readLines(draftname) |>
      writeLines(
        text = _,
        con = paste0(filename, '.qmd', collapse = '')
      )
    cli::cli_alert_info('A blank qmd-file was created.')
  }

  # copying _brand.yml
  if (file.exists(paste0(path_to_templates, '_brand.yml'))) {
    file.copy(
      from = paste0(path_to_templates, '_brand.yml'),
      to = paste0(path, '_brand.yml'),
      overwrite = FALSE,
      copy.mode = TRUE,
      copy.date = FALSE
    )

    cli::cli_alert_success('Created `_brand.yml` file')
  } else {
    cli::cli_alert_info(
      'The file `_brand.yml` does not exist at `path_to_templates`!'
    )
  }

  # copying _quarto.yml
  if (file.exists(paste0(path_to_templates, '_quarto.yml'))) {
    file.copy(
      from = paste0(path_to_templates, '_quarto.yml'),
      to = paste0(path, '_quarto.yml'),
      overwrite = FALSE,
      copy.mode = TRUE,
      copy.date = FALSE
    )

    cli::cli_alert_success('Created `_quarto.yml` file')
  } else {
    cli::cli_alert_info(
      'The file `_brand.yml` does not exist at `path_to_templates`!'
    )
  }

}
