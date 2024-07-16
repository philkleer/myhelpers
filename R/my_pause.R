#' Pausing machine.
#'
#' Just a helper function to pause system and then do garbage collection
#'  (helpful when running a script with intense RAM use).
#'
#' @param time Indicate the time you want machine to pause (in seconds).
#'
#' @return Pauses machine and runs garbage collection.
#'
#' @examples
#' # mypause(time = 30)
#'
#' @importFrom cli cli_progress_bar cli_progress_update
#' @importFrom utils install.packages

my_pause <- function(
    time = 30
){
  if(!requireNamespace('cli')) install.packages('cli')

  clean <- function() {
    cli::cli_progress_bar('System pausing:', total = 100)
    for (i in 1:100) {
      Sys.sleep(time/100)
      cli::cli_progress_update()
    }
  }

  clean()

  gc()
}
