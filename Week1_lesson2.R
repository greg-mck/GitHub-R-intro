


source("setup.R")


#import colorado counties with tigris

counties <- counties(state = "CO")


#import rouads for larimer country

roads <- roads(state = "CO", county = "Larimer")

#setup tmap mode to iteractive 

tmap_mode("view")

qtm(counties)

tm_shape(counties)+
  tm_polygons()

qtm(counties)+
    qtm(roads)


#look at what data type 

class(counties)

#counties object is fata frame and a sf.
#sf is useful for ploptting this stuff

#convert data frame of lat long coordinates to sf 

poudre_points <- data.frame(name = c("Mishawaka", "Rustic", "Blue Lake Trailhead"),
                            long = c(-105.35634, -105.58159, -105.85563),
                            lat = c(40.68752, 40.69687, 40.57960))
