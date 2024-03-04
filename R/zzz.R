myhelpers <- function()
{
  msg <- c(
    paste(
      "This is version",
      packageVersion("myhelpers")
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
    msg[1] <- paste("Package 'myhelpers' version", packageVersion("myhelpers"))
  packageStartupMessage(msg)
  invisible()
}
