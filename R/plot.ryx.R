#' @title Plot the correlations between variables
#' @description This code will take an ryx object and create a plot showing
#' the absolute value of correlation between the dependent and selected indpendent
#' variable
#'
#' @seealso
#' [ggplot]
#'
#' @param x ryx object.
#' @param ... any other parameters passed to plot function
#'
#' @import ggplot2
#' @export
#' @return a plot object
#' @examples
#' \dontrun{
#' data(Boston, package = "MASS")
#' x <- ryx(Boston, y = "medv")
#' plot(x)
#' }

plot.ryx <- function(x, ...){
  if(!inherits(x, "ryx")) stop("must be ryx")
  suppressMessages(require(ggplot2))
  ggplot(x$df,
         aes(x = factor(variable, level = rev(unique(variable))),
             y = abs(r))) +
    geom_point(aes(color = ifelse(x$df$r < 0, "red", "blue"))) +
    geom_segment(aes(xend=variable), yend=0, color = "lightgrey") +
    labs(title = paste("Correlations with", x$y, sep=" "),
         x = "Variables",
         y = "Correlation (absolute value)",
         color = "Direction") +
    scale_color_discrete(labels = c("negative", "positive")) +
    coord_flip() +
    theme_bw()
}
