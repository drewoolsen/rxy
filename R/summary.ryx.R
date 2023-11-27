#' @title Summarize the correlations in a dataset
#' @description This code will take an ryx object and summarize the findings
#' in text format
#' @param x ryx object
#' @param ... other parameters passed to the summary function
#' @export
#' @examples
#' \dontrun{
#' data(Boston, package = "MASS")
#' x <- ryx(Boston, y = "medv")
#' summary(x)
#' }



summary.ryx <- function(x,...) {
  if(!inherits(x, "ryx")) stop("must be ryx")
  cat("Correlating",x$y,"with",x$x,"\n")
  cat("The median absolute correlation was",round(median(abs(x$df$r)), 3),
      "with a range from",round(range(x$df$r), 3)[1],"to",round(range(x$df$r), 3)[2],"\n")
  cat(" ",sum(grepl("*", x$df$sigif)),"out of",nrow(x$df),"variables were significant at the p < 0.05 level.")
}
