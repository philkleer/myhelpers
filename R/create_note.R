#' Initializes files and directories for a new R project
#'
#' This function just creates a new note with a timestamp
#'
#' @param content Content to be written, default None
#' @returns None
#'
#' @examples
#' # create_note()
#'
#' @export
#'
create_note <- function(content = "") {
  # Ensure the "notes" directory exists
  if (!dir.exists("notes")) {
    dir.create("notes")
  }

  # Generate timestamp-based filename
  timestamp <- format(Sys.time(), "%Y-%m-%d_%H-%M-%S")
  filename <- paste0("notes/", timestamp, ".md")

  # Write content to the file
  writeLines(content, filename)

  # Return the file path
  return(paste("Markdown file created:", filename))
}
