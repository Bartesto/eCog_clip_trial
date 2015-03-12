##Get list of input files
input_files <- sort(list.files("./input", pattern = "\\.shp$"))

##Get list of clip files
clip_files <- sort(list.files("./clip", pattern = "\\.shp$"))


##Get common identifier for output name
lgth <- length(input_files)
split <- as.data.frame(matrix(unlist(strsplit(input_files, split = "\\.")), nrow=lgth, byrow=T), 
                       stringsAsFactors = FALSE)

out_id <- substr(split[,1], 9, 35)## hard coded to match input string format

##Get common identifier to search UM tiles
lgth <- length(input_files)
split <- as.data.frame(matrix(unlist(strsplit(input_files, split = "\\.")), nrow=lgth, byrow=T), 
                       stringsAsFactors = FALSE)

id <- substr(split[,1], 15, 27)## hard coded to match input string format

##Match data frame



grep(id[5], clip_files)


pos_ind <- sapply(1:lgth, function(i) {grep(id[i], clip_files)})#returns positions of matches
clips <- sapply(1:lgth, function(i){clip_files[pos_ind[i]]})

df <- as.data.frame(cbind(id = id, outn = out_id,input = input_files,
                          clip = clips), stringsAsFactors = FALSE)





