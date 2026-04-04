**Note: To run the bash scripts in this .md file, you need to download the Markdown Execute plugin.**

## Zhang_iScience_2022_Amel
- Download reference genome and annotation(GTF) from ensembl;
- Examined the reference genome 
  - using ref-inspection.ipynb (examine the presence of mitochondrial sequences and UTR coverage);
  - 
- Install fastq using 1_get-fastq.sh
  - Get SRR list (Accession List) from NCBI manually, Create file ./metadata/SRR_list
  - download .sra file using Accession List & transfer .sra to .fastq & make link from storage server to current server
    ```bash
    
    ```
- rename & distinguish R1 and R2