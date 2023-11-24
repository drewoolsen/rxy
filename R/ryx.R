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


library(MASS)
x <- ryx(Boston, y="medv")

print.ryx <- function(x,...){
  if(!inherits(x, "ryx")) stop("must be ryx")
  cat("Correlations of",x$y,"with\n")
  print(x$df, row.names = F)
}

print(x)


summary.ryx <- function(x,...) {
  if(!inherits(x, "ryx")) stop("must be ryx")
  cat("Correlating",x$y,"with",x$x,"\n")
  cat("The median absolute correlation was",round(median(abs(x$df$r)), 3),
      "with a range from",round(range(x$df$r), 3)[1],"to",round(range(x$df$r), 3)[2],"\n")
  cat(" ",sum(grepl("*", x$df$sigif)),"out of",nrow(x$df),"variables were significant at the p < 0.05 level.")
}
summary(x)

plot.ryx <- function(x, ...){
  if(!inherits(x, "ryx")) stop("must be ryx")
  suppressMessages(require(ggplot2))
  ggplot(x$df,
         aes(x = abs(r))) +
    geom_bar()
}
library(ggplot2)


ggplot(x$df,
       aes(x = factor(variable, level = rev(unique(variable))),
           y = abs(r))) +
  geom_point() +
  geom_segment(aes(xend=variable), yend=0) +
  coord_flip()
x$df
