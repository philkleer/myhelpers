#' Helper function
#'
#' Just a helper function to create a start message. Don't use it individually.
#'
#' @returns None
#'
#' @importFrom utils packageVersion

myhelpers <- function()
{
  msg <- c(
    paste(
      "This is version",
      utils::packageVersion("myhelpers")
    ),
    "\nType 'lsf.str(\"package:myhelpers\")' for showing all functions.")
  return(msg)
}

.onAttach <- function(lib, pkg)
{
  #  unlockBinding(".myhelpers", asNamespace("myhelpers"))
  # startup message
  msg <- myhelpers()
  if(!interactive())
    msg[1] <- paste(
      "Package 'myhelpers' version",
      utils::packageVersion("myhelpers")
    )
  packageStartupMessage(msg)
  invisible()
}
