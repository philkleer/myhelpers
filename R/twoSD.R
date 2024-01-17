twoSD <- function(
    x
){
  (x - mean(x, na.rm = TRUE))/(2 * sd(x, na.rm = TRUE))
}
