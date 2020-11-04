# Overview of modules to generate RNA-Seq release files

| Module | Brief Description | Input to generate additional files needed for release |
|--------|-------------------| ------------------------|
merge_rsem | Downloads new rsem files and merges with existing rsem files | rnaseq_collapse
merge_kallisto | Downloads new kallisto files and merges with existing kallisto files | 
merge_fusion | Formats and downloads fusion files and merges with existing fusion caller files | fusion_filtering, molecular_subtyping

