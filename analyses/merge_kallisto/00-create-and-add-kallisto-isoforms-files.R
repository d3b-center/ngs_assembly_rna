# Author: : Krutika Gaonkar
# Merge step from Komal Rathi's code in OpenPBTA
# Date: 05/10/2020
# Function:
# merges new kallisto files into previous version of kallisto RDS object

# load libraries
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(reshape2))
suppressPackageStartupMessages(library(stringr))

# read params
option_list <- list(
  make_option(c("--inputdir"),
    type = "character",
    help = "Input directory for kallisto files"
  ),
  make_option(c("--manifest"),
    type = "character",
    help = "Manifest file "
  ),
  make_option(c("--manifest_format"),
              type = "character", default = "csv",
              help = "csv if manifest downloaded from cavatic GUI,json/yaml format if provided by bix-ops"
  ),
  make_option(c("--outdir"),
    type = "character",
    help = "Path to output directory"
  ),
  make_option(c("-d", "--download"),
    type = "logical",
    help = "download from cavatica", default = TRUE
  ),
  make_option(c("-u", "--username"),
    type = "character",
    help = "if download= TRUE mandatory;  cavatica username "
  ),
  make_option(c("-p", "--projectid"),
    type = "character",
    help = " if download= TRUE mandatory; cavatica project id"
  ),
  make_option(c("-m", "--mergefiles"),
              type = "logical",default=TRUE,
              help = " TRUE to merge file and FALSE when only need them downloaded"
  ),
  make_option(c("-t", "--old_kallisto_tpm"),
    type = "character",
    help = "Path to old tpm merged files", default = NULL
  ),
  make_option(c("-o", "--outname"),
    type = "character",
    help = "outname"
  )
)

# parse the parameters
opt <- parse_args(OptionParser(option_list = option_list))
topDir <- opt$inputdir
manifest <- opt$manifest
manifest_format <- opt$manifest_format
outdir <- opt$outdir
download <- opt$download
username <- opt$username
projectid <- opt$projectid
old_kallisto_tpm <- opt$old_kallisto_tpm
outname <- opt$outname
mergefiles <- opt$mergefiles

# read manifest file
if (manifest_format == "csv"){
  manifest <- read.csv(manifest, stringsAsFactors = F)
  manifest <- manifest %>%
    select(Kids.First.Biospecimen.ID, name, id) %>% dplyr::rename(Kids_First_Biospecimen_ID = Kids.First.Biospecimen.ID)
} 


if (manifest_format=="json" || manifest_format == "yaml"){
  manifest <- rlist::list.load(manifest)
  
  manifest <- data.frame("Kids_First_Biospecimen_ID" = unlist(lapply(manifest$`rnaseq-analysis`,function(x) x$kf_biospecimen_id)),
                            "name" = unlist(lapply(manifest$`rnaseq-analysis`,function(x) 
                              gsub(".*[/]","",x$filepath))),
                            "id" = unlist(lapply(manifest$`rnaseq-analysis`,function(x) x$cavatica_id)))
  
}

manifest <- manifest[grep("kallisto[.]abundance[.]tsv[.]gz", manifest$name), ]

# read histology file and split into polyA and stranded
# clin <- read.delim(clin, stringsAsFactors = F)
# polya <- clin %>%
#   filter(experimental_strategy == "RNA-Seq" & RNA_library == "poly-A")
# stranded <- clin %>%
#   filter(experimental_strategy == "RNA-Seq" & RNA_library == "stranded")


if (download) {
  # download files from manifest
  source("utils/download-files-manifest.R")
  print(head(manifest))
  download_files_manifest(
    manifest = manifest, username =
      username, projectid = projectid,
    outputfolder = topDir
  )
}

if (mergefiles) {
  
  # read and merge kallisto isoform files
  lfiles <- list.files(path = topDir, pattern = "*.kallisto.abundance.tsv.gz", recursive = TRUE)
  read.kallisto <- function(x) {
    print(x)
    dat <- data.table::fread(file.path(topDir, x))
    filename <- x
    sample.id <- manifest[which(manifest$name %in% filename), "Kids_First_Biospecimen_ID"]
    dat$Sample <- sample.id
    return(dat)
  }
  expr <- lapply(lfiles, read.kallisto)
  expr <- data.table::rbindlist(expr)
 
  expr.tpm <- dcast(expr,target_id ~ Sample, value.var = "tpm") %>%
    # TPM
    as.data.frame()
  
  # gtf formatted by wongj https://cavatica.sbgenomics.com/u/wongj4/test/files/#q?search=gencode_primary_assembly.reformatted.annotation.gft
  gtf <- data.table::fread("input/gencode_primary_assembly.reformatted.annotation.gft",stringsAsFactors = FALSE) %>% 
    dplyr::select(Transcript_ID,Transcript_Name,Gene_ID,Gene_Name) %>%
    unique()
  rnaseq.tpm <-merge(expr.tpm ,gtf,by.x="target_id",by.y="Transcript_ID")
  rnaseq.tpm <- rnaseq.tpm %>%
    dplyr::mutate(transcript_id=paste(rnaseq.tpm$target_id,rnaseq.tpm$Transcript_Name,sep="_"),
                  gene_id = paste(rnaseq.tpm$Gene_ID,rnaseq.tpm$Gene_Name,sep="_")) %>%
    dplyr::select(transcript_id,gene_id,everything(),-target_id,-Transcript_Name,-Gene_ID,-Gene_Name) 
  
  if (!is.null(old_kallisto_tpm)) {
    # read old file
    old_kallisto_tpm <- readRDS(old_kallisto_tpm)
    # get new samples
    new_samples <- setdiff(colnames(rnaseq.tpm), colnames(old_kallisto_tpm))
    print(paste0("adding ", toString(new_samples)))
    # merge with old file
    all_rnaseq_kallisto.tpm <- old_kallisto_tpm %>% left_join(rnaseq.tpm[, c("transcript_id","gene_id", new_samples)], by = c("transcript_id","gene_id"))
    # save output
    saveRDS(all_rnaseq_kallisto.tpm, file = file.path(outdir, paste0(outname)))
  }
  
}

print("Done!")
