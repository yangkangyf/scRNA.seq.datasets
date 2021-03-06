library(scater)

# read data
d <- read.table("data.txt")

# select 5 patients
d <- d[,grepl("MGH26_", colnames(d)) |
       grepl("MGH264_", colnames(d)) |
       grepl("MGH28_", colnames(d)) |
       grepl("MGH29_", colnames(d)) |
       grepl("MGH30_", colnames(d)) |
       grepl("MGH31_", colnames(d))]

# create phenodata
patients <- unlist(lapply(strsplit(colnames(d), "_"), "[[", 1))
patients[patients == "MGH264"] <- "MGH26"
ann <- data.frame(cell_type1 = patients)
rownames(ann) <- colnames(d)
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
sceset <- newSCESet(exprsData = d, phenoData = pd, logExprsOffset = 1)

# QC was not calculated since the data is heavily normalised

# use gene names as feature symbols
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

# save the data
saveRDS(sceset, file = "patel.rds")
