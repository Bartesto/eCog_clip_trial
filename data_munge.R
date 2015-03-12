## Script to make string names for input, clip and outputs for clipping
## process in ArcGIS for python script

##Set top level working directory which contains:
## 1. this script
## 2. a folder called "input" containg eCog outputs
## 3. a folder called "clip" containing ALL UM tiles for use in clipping eCog outputs
## 4. a file geodatabse for clipped outputs

setwd("your file path here")

##Obtain top level file path
fp <- getwd()
fp <- gsub("/", "\\\\", fp, fixed = TRUE)

##Obtain file geo database name
gdb <- dir(pattern = "\\.gdb$")

##Get list of input files
input <- sort(list.files("./input", pattern = "\\.shp$"))#basename
input_files <- paste0(fp, "\\\\", "input", "\\\\", sort(list.files("./input", pattern = "\\.shp$")))

##Get list of clip files
clip_files <- paste0(fp, "\\\\", "clip", "\\\\", sort(list.files("./clip", pattern = "\\.shp$")))


## Get common identifier for output name
lgth <- length(input_files)
split <- as.data.frame(matrix(unlist(strsplit(input, split = "\\.")), nrow=lgth, byrow=T), 
                       stringsAsFactors = FALSE)


## Create name for output name
name_no_shp <- substr(split[,1], 1, 35)## hard coded to match input string format
out_name <- paste0(fp, "\\\\", gdb, "\\\\", "UM", "_", name_no_shp)


## Get common identifier to search UM tiles
id <- substr(split[,1], 15, 27)## hard coded to match input string format


## Match common id to UM tiles and put everything in a data frame
pos_ind <- sapply(1:lgth, function(i) {grep(id[i], clip_files)})#returns positions of matches
clips <- sapply(1:lgth, function(i){clip_files[pos_ind[i]]})

df <- as.data.frame(cbind(id = id, input = input_files, clip = clips,
                          output = out_name), stringsAsFactors = FALSE)





