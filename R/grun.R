library(scater)

DATA = read.table("data.txt", header=T)

expr_mat = as.matrix(DATA[,2:length(DATA[1,])]);
keep = colSums(expr_mat> 0) > 100; # Some cell QC (avoid all zero cells)
expr_mat = expr_mat[,keep];

gene_names = DATA[,1];
gene_names = matrix(unlist(strsplit(as.character(gene_names),"__")),ncol=2, byrow=T )
dups = duplicated(gene_names[,1])
gene_names[dups,1] = DATA[dups,1]
rownames(expr_mat) <- gene_names[,1];

labels = colnames(expr_mat);
ncells = length(labels)
sorting = rep("NA", times=ncells)
sorting[grepl("HSC",labels)] <- "Lin-Kit+Sca1+CD48-CD150+"; #HSC
type = rep("Unknown", times=ncells)
type[grepl("HSC",labels)] <- "HSC"; #HSC
thing = strsplit(labels,"_")
plate = unlist(lapply(thing, function(x){x[1]}));

Annotation = data.frame(batch=plate, plate=plate, Source = rep("MmusBoneMarrow", times=ncells), cell_type1 = type, sorting=sorting, genotype=rep("WildType", times=ncells));
rownames(Annotation) <- colnames(expr_mat)

pd <- new("AnnotatedDataFrame", data=Annotation)
sceset <- newSCESet(countData=expr_mat, phenoData=pd, logExprsOffset=1, lowerDetectionLimit=0)
sceset <- calculateQCMetrics(sceset)
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

saveRDS(sceset, file="grun.rds")
