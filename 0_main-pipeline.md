**Note: To run the bash scripts in this .md file, you need to download the Markdown Execute plugin.**

## Zhang_iScience_2022_Amel
- Download reference genome and annotation(GTF) from ensembl
- Check reference genome using [ref-inspection.ipynb](./Zhang_iScience_2022_Amel/ref-inspection.ipynb)
  - mitochondrial sequences exist? Yes
  - Is the UTR deletion rate acceptable? Yes
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
  conda activate fastq2matrix
  ./5_remove-doublet.sh -p Zhang_iScience_2022_Amel
  ```


## Sheng_SA_2020_Hsal
- The *H. saltator* genome and annotation in ensembl do not include mitochondria. Therefore, fasta and GTF containing mitochondria were generated beforehand using the [Mito_Assemble project](https://github.com/zliu90693/Mito_Assemble).
- Check reference genome using [ref-inspection.ipynb](./Sheng_SA_2020_Hsal/ref-inspection.ipynb)
  - mitochondrial sequences exist? Yes
  - Is the UTR deletion rate acceptable? Yes
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
  ./3_cellranger-count.sh -p Sheng_SA_2020_Hsal -l 20 -t H_sal_mkref_out -c true
  ```
- Remove ambient RNA using 4_cellbender-removebackground.sh
  ```bash
  conda activate cellbender
  ./4_cellbender-removebackground.sh -p Sheng_SA_2020_Hsal -c 20
  ```
- Remove doublet using 5_remove-doublet and run_scDblFinder.R
  ```bash
  conda activate fastq2matrix
  ./5_remove-doublet.sh -p Sheng_SA_2020_Hsal
  ```
  <!-- `↑ 20260514 20260401_download_fastq` -->

## Acer
- Download reference genome and annotation(GTF) from Refseq
- Check reference genome and <mark style="background: #FF5582A6;">adjust the format of the GTF</mark> using [ref-inspection.ipynb](./Acer/ref-inspection.ipynb)
  - mitochondrial sequences exist? Yes
  - Is the UTR deletion rate acceptable? Yes
- *A. cerana* data is provided by this project itself, make link:
  ```bash
  cd ./Acer/fastq
  ln -sf /data/share/data/Zhou_lab_seq_data/20260401_lzy_sc_fastq/Acer/queen_rep1 queen_rep1
  ln -sf /data/share/data/Zhou_lab_seq_data/20260401_lzy_sc_fastq/Acer/worker_rep1 worker_rep1
  ln -sf /data/share/data/Zhou_lab_seq_data/20260401_lzy_sc_fastq/Acer/worker_rep2 worker_rep2
  ln -sf /data/share/data/Zhou_lab_seq_data/20260401_lzy_sc_fastq/Acer/drone_rep1 drone_rep1
  ln -sf /data/share/data/Zhou_lab_seq_data/20260401_lzy_sc_fastq/Acer/drone_rep2 drone_rep2
  cd -
  ```
- Make index to ref data
  ```bash
  ./2_make-ref.sh -p Acer -g GCF_029169275.1_fixed.gtf -f GCF_029169275.1_fixed.filtered.gtf -r GCF_029169275.1_AcerK_1.0_genomic.fna -m A_cer_mkref_out -t 20
  ```
- Rename fastq using [rename.ipynb](./Acer/rename.ipynb)
- Run Cellranger count using 3_cellranger-count.sh
  ```bash
  conda activate fastq2matrix
  ./3_cellranger-count.sh -p Acer -l 20 -t A_cer_mkref_out -c false
  ```
- Remove ambient RNA using 4_cellbender-removebackground.sh
  ```bash
  conda activate cellbender
  ./4_cellbender-removebackground.sh -p Acer -c 20
  ```
- Remove doublet using 5_remove-doublet and run_scDblFinder.R
  ```bash
  conda activate fastq2matrix
  ./5_remove-doublet.sh -p Acer
  ```
  `20260514 Acer_c_count`

## ~~Jones_NEE_2023_Lzep~~
- The *L. zephyrus* genome and annotation in [dnazoo](https://dnazoo.s3.wasabisys.com/index.html?prefix=Lasioglossum_zephyrum/) do not include mitochondria, Therefore, fasta and GTF containing mitochondria were generated beforehand using the [Mito_Assemble project](https://github.com/zliu90693/Mito_Assemble).
- Check reference genome using [ref-inspection.ipynb](./Jones_NEE_2023_Lzep/ref-inspection.ipynb)
  - mitochondrial sequences exist? Yes
  - Is the UTR deletion rate acceptable? <mark style="background: #FF5582A6;">No</mark>
  - Manually annotate UTRs in the GTF file using the [UTR_anno project](https://github.com/zliu90693/UTR_anno)
- Install fastq using 1_get-fastq.sh
  - Get SRR list (Accession List) from NCBI manually, Create file ./metadata/SRR_list
  - download .sra file using Accession List & transfer .sra to .fastq & make link from storage server to current server
    ```bash
    conda activate kingfisher
    ./1_get-fastq.sh -p Jones_NEE_2023_Lzep -j 12 -x 5 -s 5 -t 8 -z 20
    ```
- Make index to ref data
  ```bash
  ./2_make-ref.sh -p Jones_NEE_2023_Lzep -g Lasioglossum_zephyrus.gtf -f Lasioglossum_zephyrus.filtered.gtf -r Lasioglossum_zephyrus.fasta -m L_zep_mkref_out -t 20
  ```
- Rename fastq using [rename.ipynb](./Jones_NEE_2023_Lzep/rename.ipynb)
- Run Cellranger count using 3_cellranger-count.sh
  ```bash
  conda activate fastq2matrix
  ./3_cellranger-count.sh -p Jones_NEE_2023_Lzep -l 20 -t L_zep_mkref_out -c true
  ```
- A critical issue was encountered during the Cell Ranger count analysis, characterized by an extremely low proportion of reads mapping to the *L. zephyrus* genome—and an even lower proportion mapping to the transcriptome—resulting in a recovered cell count of only approximately 700 per sample. Following consultation with the original authors of the published study, it was determined that this issue likely stemmed from errors during the library preparation process; consequently, this specific scRNA-seq dataset has been excluded from all subsequent analyses.