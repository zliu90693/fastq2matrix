**Note: To run the bash scripts in this .md file, you need to download the Markdown Execute plugin.**

## Zhang_iScience_2022_Amel
`branch main`
- Download reference genome and annotation(GTF) from ensembl
- Check reference genome using [ref-inspection.ipynb](./Zhang_iScience_2022_Amel/ref-inspection.ipynb)
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

- Distinguish R1/R2 fastq and rename fastq using [check_R1R2_rename.ipynb](./Zhang_iScience_2022_Amel/check_R1R2_rename.ipynb)
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
- The *H. saltator* genome and annotation in ensembl do not include mitochondria. Therefore, fasta and GTF containing mitochondria were generated beforehand using the [Mito_Assemble project](https://github.com/zliu90693/Mito_Assemble).
- Check reference genome using [ref-inspection.ipynb](./Sheng_SA_2020_Hsal/ref-inspection.ipynb)
  - mitochondrial sequences exist? Yes
  - the CDS and exon start sites are different? Yes
- Install fastq using 1_get-fastq.sh
  - Get SRR list (Accession List) from NCBI manually, Create file ./metadata/SRR_list
  - download .sra file using Accession List & transfer .sra to .fastq & make link from storage server to current server
    ```bash
    conda activate kingfisher
    ./1_get-fastq.sh -p Sheng_SA_2020_Hsal -j 12 -x 5 -s 5 -t 8 -z 20
    ```
- Make index to ref data
  ```bash
  conda activate fastq2matrix
  ./2_make-ref.sh -p Sheng_SA_2020_Hsal -g Harpegnathos_saltator.gtf -f Harpegnathos_saltator.filtered.gtf -r Harpegnathos_saltator.fa -m H_sal_mkref_out -t 20
  ```
- Rename fastq using [check_R1R2_rename.ipynb](./Sheng_SA_2020_Hsal/rename.ipynb)
- Run Cellranger count using 3_cellranger-count.sh
  ```bash
  conda activate fastq2matrix
  ./3_cellranger-count.sh -p Sheng_SA_2020_Hsal -l 20 -t H_sal_mkref_out -c false
  ```

## Acer
- Download reference genome and annotation(GTF) from Refseq
- Check reference genome and <mark style="background: #FF5582A6;">adjust the format of the GTF</mark> using [ref-inspection.ipynb](./Acer/ref-inspection.ipynb)
  - mitochondrial sequences exist? Yes
  - the CDS and exon start sites are different? Yes
- *A. cerana* data is provided by this project itself.
- Make index to ref data
  ```bash
  ./2_make-ref.sh -p Acer -g GCF_029169275.1_AcerK_1.0_genomic_neat.gtf -f GCF_029169275.1_AcerK_1.0_genomic_neat.filtered.gtf -r GCF_029169275.1_AcerK_1.0_genomic.fna -m A_cer_mkref_out -t 20
  ```

