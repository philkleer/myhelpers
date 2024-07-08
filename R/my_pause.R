my_pause <- function(
    time = 30
){
  Sys.sleep(time)

  gc()
}
