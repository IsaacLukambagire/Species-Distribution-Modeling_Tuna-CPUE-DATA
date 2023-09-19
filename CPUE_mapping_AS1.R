library("cowplot")
library("googleway")
library("ggplot2")
library("ggrepel")
library("ggspatial")
library("lwgeom")
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
library("ggspatial")
library("rworldxtra")
library("rworldmap")

data <- read.csv("G:/INCOIS-training/sudheera-SL-data/2016_2019_fish_ocg_arabian_sea_full_1.csv")
coords <- cbind(longitude = data$longdegree, latitude = data$latdegree)
grid_size <- 1 
n_rows <- (nrow(data)-1) * grid_size + 1
n_cols <- ncol(data) * grid_size
grid <- matrix(NA, nrow = n_rows, ncol = n_cols)
months <- factor(format(as.Date(data$fdate), "%m"))
season <- data$season
means <- aggregate(mcpue ~ months+latdegree+londegree, data = data, FUN = mean)
means_season <- aggregate(mcpue ~ season+latdegree+londegree, data = data, FUN = mean)
library(ggplot2)
library(maps)

world_sf<- ne_countries(scale = "medium", returnclass = "sf")
basemap <- ggplot() + geom_sf(data = world_sf, color = "black", size = 0.2, fill="khaki1")
head(means)
head(means_season)

map2<- basemap+ geom_point(data=means,aes(x = londegree, y = latdegree, size = mcpue), colour = 'purple', alpha = .5) + 
  scale_size_continuous(range = c(0.1, 8), breaks = c(0.1, 0.5, 1.0, 1.5, 2, 5, 8)) + labs(size = 'mcpue') +
  coord_sf(xlim=c(50,70),ylim=c(0,25))+facet_wrap(~months,ncol=3)+ theme(axis.text = element_text(size = 10))
map2
map_season<- basemap+ geom_point(data=means_season,aes(x = londegree, y = latdegree, size = mcpue), colour = 'purple', alpha = .5) + 
  scale_size_continuous(range = c(0.1, 8), breaks = c(0.1, 0.5, 1.0, 1.5, 2, 5, 8)) + labs(size = 'mcpue') +
  coord_sf(xlim=c(50,70),ylim=c(0,25))+facet_wrap(~season,ncol=2)+ theme(axis.text = element_text(size = 10))
map_season
ggsave(path = "G:/INCOIS-training", filename = "as_map_cpue_monthly1.png", device = "png", width =10, height = 16, dpi=300)
ggsave(path = "G:/INCOIS-training", filename = "as_map_cpue_monthly.pdf", device = "pdf", width =10, height = 16, dpi=300)
map_season
ggsave(path = "G:/INCOIS-training", filename = "as_map_cpue_season.png", device = "png", width =10, height = 16, dpi=300)
ggsave(path = "G:/INCOIS-training", filename = "as_map_cpue_season.pdf", device = "pdf", width =10, height = 16, dpi=300)

#Bay of Bengal
data1 <- read.csv("G:/INCOIS-training/sudheera-SL-data/2016_2019_fish_ocg_bay_of_bengal_full_1.csv")
coords <- cbind(longitude = data1$longdegree, latitude = data1$latdegree)
grid_size <- 1 
n_rows <- (nrow(data1)-1) * grid_size + 1
n_cols <- ncol(data1) * grid_size
grid <- matrix(NA, nrow = n_rows, ncol = n_cols)
months <- factor(format(as.Date(data1$fdate), "%m"))
season <- data1$season
means <- aggregate(mcpue ~ months+latdegree+londegree, data = data1, FUN = mean)
means_season <- aggregate(mcpue ~ season+latdegree+londegree, data = data1, FUN = mean)
library(ggplot2)
library(maps)

world_sf<- ne_countries(scale = "medium", returnclass = "sf")
basemap <- ggplot() + geom_sf(data = world_sf, color = "black", size = 0.2, fill="khaki1")
head(means)
head(means_season)

map2<- basemap+ geom_point(data=means,aes(x = londegree, y = latdegree, size = mcpue), colour = 'purple', alpha = .5) + 
  scale_size_continuous(range = c(0.1, 8), breaks = c(0.1, 0.5, 1.0, 1.5, 2, 5, 8)) + labs(size = 'mcpue') +
  coord_sf(xlim=c(80,95),ylim=c(0,20))+facet_wrap(~months,ncol=3)+ theme(axis.text = element_text(size = 10))
map2
map_season<- basemap+ geom_point(data=means_season,aes(x = londegree, y = latdegree, size = mcpue), colour = 'purple', alpha = .5) + 
  scale_size_continuous(range = c(0.1, 8), breaks = c(0.1, 0.5, 1.0, 2.5, 5, 10)) + labs(size = 'mcpue') +
  coord_sf(xlim=c(80,95),ylim=c(0,25))+facet_wrap(~season,ncol=2)+ theme(axis.text = element_text(size = 10))
map_season
ggsave(path = "G:/INCOIS-training", filename = "BoB_map_cpue_monthly1.png", device = "png", width =10, height = 16, dpi=300)
ggsave(path = "G:/INCOIS-training", filename = "BoB_map_cpue_monthly.pdf", device = "pdf", width =10, height = 16, dpi=300)
map_season
ggsave(path = "G:/INCOIS-training", filename = "BoB_map_cpue_season.png", device = "png", width =10, height = 16, dpi=300)
ggsave(path = "G:/INCOIS-training", filename = "BoB_map_cpue_season.pdf", device = "pdf", width =10, height = 16, dpi=300)
