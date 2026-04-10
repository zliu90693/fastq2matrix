**Note: To run the bash scripts in this .md file, you need to download the Markdown Execute plugin.**

## Zhang_iScience_2022_Amel
- Download reference genome and annotation(GTF) from ensembl
- Check reference genome using ref-inspection.ipynb
  - mitochondrial sequences exist? Yes
  - the CDS and exon start sites are different? Yes
- Install fastq using 1_get-fastq.sh
  - Get SRR list (Accession List) from NCBI manually, Create file ./metadata/SRR_list
  - download .sra file using Accession List & transfer .sra to .fastq & make link from storage server to current server
    ```bash
    conda activate kingfisher
    ./1_get-fastq.sh -p Zhang_iScience_2022_Amel -j 12 -x 5 -s 5 -t 8 -z 20
    ```
- Make index to ref data
  ```bash
  conda activate fastq2matrix
  ./2_make-ref.sh -p Zhang_iScience_2022_Amel -g Apis_mellifera.Amel_HAv3.1.62.gtf -f Apis_mellifera.Amel_HAv3.1.62.filtered.gtf -r Apis_mellifera.Amel_HAv3.1.dna.toplevel.fa -m A_mel_mkref_out -t 20
  ```

- Distinguish R1/R2 fastq and rename fastq using check_R1R2_rename.ipynb
- Run Cellranger count using 3_cellranger-count.sh
  ```bash
  conda activate fastq2matrix
  ./3_cellranger-count.sh -p Zhang_iScience_2022_Amel -l 20 -t A_mel_mkref_out -c false
  ```
- Remove ambient RNA using 4_cellbender-removebackground.sh
  ```bash
  # conda config --set channel_priority flexible
  # conda env create -y -n cellbender --file .env/cellbender.yml
  conda activate cellbender
  ./4_cellbender-removebackground.sh -p Zhang_iScience_2022_Amel -c 20
  ```
- Remove doublet using 5_remove-doublet and run_scDblFinder.R
  ```bash
  
  ```


## Sheng_SA_2020_Hsal
- Download reference genome and annotation(GTF) from ensembl
- Check reference genome using ref-inspection.ipynb
  - mitochondrial sequences exist? 
  - the CDS and exon start sites are different? 