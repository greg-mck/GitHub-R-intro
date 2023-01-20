


source("setup.R")


#import colorado counties with tigris

counties <- counties(state = "CO")


#import rouads for larimer country

roads <- roads(state = "CO", county = "Larimer")

#setup tmap mode to iterative 



