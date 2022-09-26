library(sf)
library(cartography)
library(potential)
# path to the geopackage file embedded in cartography
#path_to_gpkg <- system.file("gpkg/mtq.gpkg", package="cartography")
# import to an sf object
#mtq <- st_read(dsn = path_to_gpkg, quiet = TRUE)
mtq <- st_read(dsn = "C:/Users/valty/Documents/vinna/github/PlasticSymposium2021/docs/skjol/vegr.gpkg/vegagerdin.shp", quiet = TRUE)
mtq <- mtq[grep("F",mtq$NRVEGUR,invert = T),]
mtq <- mtq[mtq$VEGHEITI!="Kjalvegur",]
mtq$ADU <- as.numeric(mtq$ADU)
mtq$aduB <- mtq$ADU/10000
#strnd <- st_read(dsn = "//BIO-POLPC/BioPol/Valt?r/Backup Biopol VS/GIS/IS50V_STRANDLINA_17062019_ISN93/IS50V_STRANDLINA_SHP/is50v_strandlina_flakar_17062019.shp", quiet = TRUE)
#mtq <- st_read(dsn = "//BIO-POLPC/BioPol/Valt?r/Backup Biopol VS/GIS/strandlinaogvegir.gpkg", quiet = TRUE)
# plot municipalities (only the backgroung color is plotted)
png(filename="C:/Users/valty/Documents/vinna/github/borgarnes22/docs/images/trafficDensity_BG.png",7,7,"cm",pointsize=6,res=900)
plot(st_geometry(mtq), col = NA, border = NA, bg = "#7DE8C5")
#plot(strnd[strnd$SHAPE_Area>10000000000,],add=T ,type='l')
# plot isopleth map
smoothLayer(
  x = mtq, 
  var = 'ADU',
  typefct = "exponential",
  span = 20000,
  beta = 3,
  nclass = 5,
  col = colorRampPalette(c('white', 'orange','red'))(5),
  border = "grey",
  lwd = 'aduB', 
  mask = mtq, 
  legend.values.rnd = -3,
  legend.title.txt = "Traffic Density",
  legend.pos = "bottomright",
  add=T
)
# annotation on the map
#text(x = 692582, y = 1611478, cex = 0.8, adj = 0, font = 3,  labels = 
#       "Distance function:\n- type = exponential\n- beta = 2\n- span = 4 km")
# layout
#layoutLayer(title = "Traffic density Iceland",
#            sources = "Sources: The Icelandic Road and Coastal Administration (IRCA), 2019",
#            author = "Valt?r Sigur?sson ",
#            frame = FALSE, north = FALSE, tabtitle = TRUE, theme = "pastel.pal")
# north arrow
#north(pos = "topleft")
dev.off()
