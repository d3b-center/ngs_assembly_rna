# Merge kallisto files

The Steps for merging kallisto files are :
 1) Download kallisto isoform expression quantificaton files along with a manifest to merge with existing merged files from previous releases.
 
        -  Manifest is mandatory it can either be downloaded from cavatica project (deefault) or bix-ops generated json format manifest.
        -  Files can be downloaded using the script with --download==TRUE or manually and placed in "INPUTDIR"

```
Rscript 00-create-and-add-kallisto-isoforms-files.R --help

Options:
	--inputdir=INPUTDIR
		Input directory for kallisto files

	--manifest=MANIFEST
		Manifest file with cavatica downloaded csv file with colnames `Kids First Biospecimen ID, name, id`, json file with column names  `Kids_First_Biospecimen_ID,filepath,cavatica_id`

	--manifest_format=MANIFEST_FORMAT
		csv if manifest downloaded from cavatic GUI,json/yaml format if provided by bix-ops

	--outdir=OUTDIR
		Path to output directory for merged files

	-d DOWNLOAD, --download=DOWNLOAD
		TRUE to download from cavatica

	-u USERNAME, --username=USERNAME
		if download= TRUE mandatory;  cavatica username 

	-p PROJECTID, --projectid=PROJECTID
		 if download= TRUE mandatory; cavatica project id

	-m MERGEFILES, --mergefiles=MERGEFILES
		 TRUE to merge file and FALSE when only need them downloaded

	-t OLD_KALLISTO_TPM, --old_kallisto_tpm=OLD_KALLISTO_TPM
		Path to old tpm merged files

	-o OUTNAME, --outname=OUTNAME
		outname prefix for merged files

	-h, --help
		Show this help message and exit
		
```		
