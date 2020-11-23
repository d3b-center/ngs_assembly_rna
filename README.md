# ngs_assembly_rna

In this repo wee are generating merged rsem, kallisto and fusion files that are direct release files 
	
	- pbta-fusion-arriba.tsv.gz
	
	- pbta-fusion-starfusion.tsv.gz
	
	- pbta-gene-expression-rsem-fpkm.polya.rds
	
	- pbta-gene-expression-rsem-fpkm.stranded.rds
	
	- pbta-gene-expression-rsem-tpm.polya.rds
	
	- pbta-gene-expression-rsem-tpm.stranded.rds

The above files are then used as direct inputs for OpenPBTA modules to generate other release files 
	
	- pbta-fusion-putative-oncogenic.tsv
	
	- pbta-gene-expression-rsem-fpkm-collapsed.polya.rds
	
	- pbta-gene-expression-rsem-fpkm-collapsed.stranded.rds
	
	- molecular_subtype for histology file
	 
	- batch correction files 



## RNA-Seq release files description and owners:

### Specific for OpenPBTA

FileName |  Description | Owner 
--- | --- | --- 
pbta-fusion-arriba.tsv.gz | Fusion - Arriba TSV, annotated with FusionAnnotator | @kgaonkar6 
pbta-fusion-putative-oncogenic.tsv | Filtered and prioritized fusions | @kgaonkar6 
pbta-fusion-starfusion.tsv.gz | Fusion - STARFusion TSV | @kgaonkar6 
pbta-gene-expression-rsem-fpkm-collapsed.polya.rds | Gene expression - RSEM FPKM for poly-A samples (geneid-level) collapsed to gene symbol | @kgaonkar6 
pbta-gene-expression-rsem-fpkm-collapsed.stranded.rds | Gene expression - RSEM FPKM for stranded  samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-fpkm.polya.rds | Gene expression - RSEM FPKM for poly-A samples (geneid-level) | @kgaonkar6 
pbta-gene-expression-rsem-fpkm.stranded.rds | Gene expression - RSEM FPKM for stranded  samples (geneid-level) | @kgaonkar6 
pbta-gene-expression-rsem-tpm-collapsed.polya.rds | Gene expression - RSEM FPKM for poly-A samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-tpm-collapsed.stranded.rds | Gene expression - RSEM TPM for stranded  samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-tpm.polya.rds | Gene expression - RSEM TPM for poly-A samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-tpm.stranded.rds | Gene expression - RSEM TPM for stranded  samples (geneid-level) collapsed to gene symbol  | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008

### Specific for 003/008

FileName |  Description | Owner 
--- | --- | --- 
pbta-hgat-dx-gene-expression-rsem-fpkm-uncorrected.rds | pbta-hgat-dx uncorrected fpkm (n = 122) | @komalsrathi  
pbta-hgat-dx-gene-expression-rsem-tpm-uncorrected.rds | pbta-hgat-dx uncorrected tpm  (n = 122) | @komalsrathi  | pbta-hgat-dx n = 122
pbta-hgat-dx-gene-expression-rsem-tpm-corrected.rds | pbta-hgat-dx corrected tpm (n = 122) | @komalsrathi | pbta-hgat-dx n = 122
pbta-hgat-dx-gene-expression-rsem-fpkm-corrected.rds | pbta-hgat-dx corrected fpkm (n = 122) | @komalsrathi | pbta-hgat-dx n = 122
pbta-gene-expression-rsem-tpm-collapsed.combined.rds | full combined tpm (n = 1049) | @komalsrathi |  v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-fpkm-collapsed.combined.rds | full combined fpkm (n = 1049) | @komalsrathi |  v17 PBTA + PNOC003 + 21 008


