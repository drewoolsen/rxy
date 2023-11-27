#' @title prints correlation table
#' @description This code will take an ryx object and print a table with the variable name,
#' correlations, p-value, and significance level between each of the variables
#' @param x ryx object
#' @param ... any other parameters passed to the print function
#' @export
#' @examples
#' \dontrun{
#' data(Boston, package = "MASS")
#' x <- ryx(Boston, y = "medv")
#' print(x)
#' }


print.ryx <- function(x,...){
  if(!inherits(x, "ryx")) stop("must be ryx")
  cat("Correlations of",x$y,"with\n")
  print(x$df, row.names = F)
}
