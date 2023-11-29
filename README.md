# ryx

ryx helps you quickly analyze and display correlations between your dependent and independent variables within your dataset.

## Installation

You can install the development version of ryx from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("drewoolsen/ryx")
```

## Example

The code below generates an ryx object from the mtcars database, and then summaries the correlations in text, in a table, and in a graph.

``` r
library(ryx)

data(mtcars)
x <- ryx(mtcars, y = "mpg", x = c("hp", "wt", "disp", "cyl", "am", "gear"))

summary(x)

print(x)

plot(x)
```
