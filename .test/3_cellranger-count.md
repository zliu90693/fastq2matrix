```bash
cd Zhang_iScience_2022_Amel/cellranger-count-out
cellranger count --localcores 20 \
    --id=GSM5590453 \
    --fastqs=../fastq/GSM5590453 \
    --sample=GSM5590453 \
    --transcriptome=../ref/A_mel_mkref_out/ \
    --create-bam false
```