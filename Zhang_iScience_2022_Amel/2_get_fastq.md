Please modify the path according to your needs.
```bash
conda activate kingfisher
cd /home/liuzhiyu/Projects/neo_caste/fastq2matrix/Zhang_iScience_2022_Amel
storage_path=/data/share/data/Zhou_lab_seq_data/20260401_lzy_sc_fastq/Zhang_iScience_2022_Amel
```

Batch prefetch, download to storage server.
```bash
prefetch --output-directory ${storage_path}/.prefetch --option-file "./metadata/SRR_list"
```



