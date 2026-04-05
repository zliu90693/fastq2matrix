**Note: To run the bash scripts in this .md file, you need to download the Markdown Execute plugin.**

## Zhang_iScience_2022_Amel
- Download reference genome and annotation(GTF) from ensembl

- Check reference genome using ref-inspection.ipynb
  - mitochondrial sequences exist? Yes
  - the CDS and exon start sites are different? 

- Install fastq using 1_get-fastq.sh
  - Get SRR list (Accession List) from NCBI manually, Create file ./metadata/SRR_list
  - download .sra file using Accession List & transfer .sra to .fastq & make link from storage server to current server
    ```bash
    ./1_get-fastq.sh -p Zhang_iScience_2022_Amel -j 12 -x 5 -s 5 -t 8 -z 20
    ```
- distinguish R1 and R2