#' @title Create an ryx object
#' @description This code will take a dataset and find the correlations between
#' a given dependent variable and each variable in a list of independent variables
#' @param data datafile to import.
#' @param y dependent variable
#' @param x list of independent variables to compare to dependent variable
#' If not specified, will use all other variables
#' @export
#' @return a ryx object
#' @examples
#' \dontrun{
#'data(Boston, package = "MASS")
#'x <- ryx(Boston, y = "medv")
#' }



ryx <- function(data, y, x){
  if(missing(x)){
    x <- names(data)[sapply(data, class)=="numeric"]
    x <- setdiff(x, y)
  }
  df <- data.frame()
  for (var in x){
    res <- cor.test(data[[y]], data[[var]])
    df_temp <- data.frame(variable = var,
                          r = res$estimate,
                          p = res$p.value)
    df <- rbind(df, df_temp)
    df <- df[order(-abs(df$r)),]
  }

  df$sigif <- ifelse(df$p < .001, "***",
                     ifelse(df$p < .01, "**",
                            ifelse(df$p < .05, "*", " ")))
  results <- list(y=y, x=x, df=df)
  class(results) <- "ryx"
  return(results)
}
