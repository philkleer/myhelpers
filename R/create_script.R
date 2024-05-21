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
create_script <- function(
    filename = NULL,
    draftname = "_extensions/myhelpers/template.R",
    ext_name = "myhelpers"
) {

  if (is.null(filename)) {
    stop("You must provide a valid filename")
  }

  out_dir <- getwd()

  # check for available extensions
  stopifnot("Extension not in package" = ext_name %in% c("myhelpers"))

  new_file <- file.path(paste0(filename, ".R"))
  if (!file.exists(new_file)) {
    file.create(new_file)
    message("Created '.R' file")

    # copy lines to .R file
    r_txt <- readLines(
      system.file(
        "/extdata/_extensions/myhelpers/template.R",
        package = "myhelpers",
        mustWork = TRUE
      )
    )

    # write to new file
    writeLines(r_txt, con = new_file)
    message("'.R' contents copied")
  }

  # open the new file in the editor
  file.edit(paste0(filename, ".R", collapse = ""))
}
