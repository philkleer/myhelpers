# Template-Package to create quarto-presentation in folder
# Author: Philipp Kleer
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

# -------------------------------------------------------------------------

# Main function (and so far only function)
create_slides_pdf <- function(
    filename = NULL,
    fragments = FALSE,
    author = "Dr. Philipp Kleer"
) {

  if (is.null(filename)) {
    stop("You must provide a valid filename!")
  }

  if (!dir.exists("./.cache/puppeteer/chrome/mac_arm-119.0.6045.105/")) {
    message("Please check if you have a puppeteer/chrome/mac_arm-119.0.6045.105/ folder. If not, copy it manually from /Users/phil/.cache/ !")
  }

  if (!file.exists(paste0(filename, ".html"))) {
    message("Please render your PDF-File first to HTML!")
  }

  if (fragments == TRUE) {
    string <- paste0(
      "decktape ",
      filename,
      ".html?fragments=true ",
      filename,
      ".pdf --screen-shot=1280x720 ",
      "--pdf-author '",
      author,
      "' --pdf-title '",
      filename,
      "'"
    )

    install <- rstudioapi::terminalExecute(string)

    while (is.null(rstudioapi::terminalExitCode(install))) {
      Sys.sleep(2)
    }

    rstudioapi::terminalKill(install)

    message("PDF with fragments has been created.")
  } else if (fragments == FALSE) {
    string <- paste0(
      "decktape ",
      filename,
      ".html ",
      filename,
      ".pdf --screen-shot=1280x720 ",
      "--pdf-author '",
      author,
      "' --pdf-title '",
      filename,
      "'"
    )

    install <- rstudioapi::terminalExecute(string)

    while (is.null(rstudioapi::terminalExitCode(install))) {
      Sys.sleep(2)
    }

    rstudioapi::terminalKill(install)

    message("PDF without fragments has been created.")
  } else {
    message("There has been an error while creating the PDF.")
  }
}
