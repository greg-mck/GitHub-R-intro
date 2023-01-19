packageLoad <-
  function(x) {
    for (i in 1:length(x)) {
      if (!x[i] %in% installed.packages()) {
        install.packages(x[i])
      }
      library(x[i], character.only = TRUE)
    }
  }

packages <- c('tidyverse',
              'palmerpenguins',
              'sf',
              'terra',
              'tmap',
              'rmarkdown',
              'tigris',
              'elevatr',
              'rgdal')

packageLoad(packages)
