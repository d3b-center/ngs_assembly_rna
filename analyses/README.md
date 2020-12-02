# Overview of modules to generate RNA-Seq release files

| Module | Brief Description | Input to generate additional files needed for release |
|--------|-------------------| ------------------------|
merge_rsem | Downloads new rsem files and merges with existing rsem files | [collapse_rnaseq](https://github.com/AlexsLemonade/OpenPBTA-analysis/tree/master/analyses/collapse-rnaseq) **
merge_kallisto | Downloads new kallisto files and merges with existing kallisto files | 
merge_fusion | Formats and downloads fusion files and merges with existing fusion caller files | [fusion_filtering](https://github.com/AlexsLemonade/OpenPBTA-analysis/tree/master/analyses/fusion_filtering), [molecular_subtyping](https://github.com/AlexsLemonade/OpenPBTA-analysis/tree/master/analyses/molecular-subtyping-HGG)

** collapse_rnaseq is only run on fpkm in OpenPBTA however for PNOC studies we also need TPM collapsed files. Please add the following code to shell script in the end

```
# generate collapsed matrices for poly-A and stranded datasets
libraryStrategies=("polya" "stranded")
for strategy in ${libraryStrategies[@]}; do

  Rscript --vanilla 01-summarize_matrices.R \
    -i ../../data/pbta-gene-expression-rsem-tpm.${strategy}.rds \
    -g ../../data/gencode.v27.primary_assembly.annotation.gtf.gz \
    -m results/pbta-gene-expression-rsem-tpm-collapsed.${strategy}.rds \
    -t results/pbta-gene-expression-rsem-tpm-collapsed_table.${strategy}.rds

done

# run the notebook for analysis of dropped genes
Rscript -e "rmarkdown::render(input = '02-analyze-drops.Rmd', params = list(polya.annot.table = 'results/pbta-gene-expression-rsem-tpm-collapsed_table.polya.rds', stranded.annot.table = 'results/pbta-gene-expression-rsem-tpm-collapsed_table.stranded.rds'), clean = TRUE)"
```
