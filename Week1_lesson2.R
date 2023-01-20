


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
poudre_points_sf <- st_as_sf(poudre_points, coords = c("long", "lat"), crs = 4326)

#Using your investigative geography skills, find the highway on your map,
#find out what the exact ‘FULLNAME’ attribute is, and use that to filter()
#the data set.

poudre_hwy <- roads %>% 
  filter(FULLNAME == "Poudre Canyon Hwy")


qtm(poudre_hwy)+
  qtm(poudre_points_sf)

#Probably the most important part of working with spatial data is the coordinate reference system (CRS) that is used. In order to analyze spatial data, all objects should be in the exact same CRS.

# see the CRS in the header metadata:
counties

#return just the CRS (more detailed)
st_crs(counties)


#You can check if two objects have the same CRS like this:

st_crs(counties) == st_crs(poudre_points_sf)

#Uh oh, the CRS of our points and lines doesn’t match. While tmap performs some on-the-fly transformations to map the two layers together, in order to do any analyses with these objects you’ll need to re-project one of them. You can project one object’s CRS to that of another with st_transform like this:

poudre_points_prj <- st_transform(poudre_points_sf, st_crs(counties))

#Now check that they match
st_crs(poudre_points_prj) == st_crs(counties)



# lets import some elevation data using the elevatr package. The function get_elev_raster()

elevation <- get_elev_raster(counties, z = 7)


qtm(elevation)

#changes to a color gradient
tm_shape(elevation)+
  tm_raster(style = "cont", title = "Elevation (m)")

#####Converting a RasterLayer object to a terra SpatRaster object is quick using the rast() function. Lets also give this layer a more informative name in the process.

elevation <- rast(elevation)
names(elevation) <- "Elevation"

#####Now we can use terra functions
elevation_crop <- crop(elevation, ext(roads))

tm_shape(elevation_crop) +
  tm_raster(style = "cont")

