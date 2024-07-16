#' Creating PDF of slide
#'
#' Creating a PDF document out of the \code{qmd}-slides.
#'
#' This function executes the decktape command in the terminal to create the
#'  PDF file. Please be aware that decktape and puppeteer needs to be installed.
#'  Furthermore, you need a folder
#'  \code{./cache/puppeteer/chrome/mac_arm-119.0.6045.105/} with the correct
#'  version of chrome to get puppeteer run (might change with updates
#'  of puppeteer).
#'
#' @param filename The name of the created file. You don't have to add
#' \code{.html}.
#' @param fragments Default is FALSE, indicates if you want to print fragments
#'  as single slides.
#' @param author Add the author name for the PDF information.
#'
#' @returns PDF document of \code{qmd}-slides.
#'
#' @examples
#' # create_slides_pdf(
#' #   filename = NULL,
#' #   fragments = FALSE,
#' #   author = 'Dr. Philipp Kleer'
#' # )
#'
#' @importFrom cli cli_alert_success cli_progress_step cli_alert_info
#'  cli_alert_danger
#' @importFrom rstudioapi terminalExecute terminalExitCode terminalKill
#' @importFrom utils install.packages

# Main function (and so far only function)
create_slides_pdf <- function(
    filename = NULL,
    fragments = FALSE,
    author = 'Dr. Philipp Kleer'
) {

  if (is.null(filename)) {
    stop('You must provide a valid filename!')
  }

  if (!dir.exists('./.cache/puppeteer/chrome/mac_arm-119.0.6045.105/')) {
    cli::cli_alert_danger(
      paste0(
        'Please check if you have a puppeteer/chrome/mac_arm-119.0.6045.105/ ',
        'folder. If not, copy it manually from /Users/phil/.cache/ !'
      )
    )
  }

  if (!file.exists(paste0(filename, '.html'))) {
    cli::cli_alert_danger('Please render your quarto-File first to HTML!')
  }

  if (fragments == TRUE) {
    string <- paste0(
      'decktape ',
      filename,
      '.html?fragments=true ',
      filename,
      '.pdf --screen-shot=1280x720 ',
      '--pdf-author "',
      author,
      '" --pdf-title "',
      filename,
      '"'
    )

    install <- rstudioapi::terminalExecute(string)

    while (is.null(rstudioapi::terminalExitCode(install))) {
      Sys.sleep(2)
    }

    rstudioapi::terminalKill(install)

    message('PDF with fragments has been created.')
  } else if (fragments == FALSE) {
    string <- paste0(
      'decktape ',
      filename,
      '.html ',
      filename,
      '.pdf --screen-shot=1280x720 ',
      '--pdf-author "',
      author,
      '" --pdf-title "',
      filename,
      '"'
    )

    install <- rstudioapi::terminalExecute(string)

    while (is.null(rstudioapi::terminalExitCode(install))) {
      Sys.sleep(2)
    }

    rstudioapi::terminalKill(install)

    cli::cli_alert_success('PDF without fragments has been created.')
  } else {
    cli::cli_alert_danger('There has been an error while creating the PDF.')
  }
}
