```bash
for GSM in ./Zhang_iScience_2022_Amel/fastq/*; do
    mkdir -p "./Zhang_iScience_2022_Amel/singlet-out/$(basename $GSM)"
done
```

```bash
GSM="GSM5590453"
input_h5="./Zhang_iScience_2022_Amel/cellbender-out/${GSM}/${GSM}_filtered.h5"
output_h5="./Zhang_iScience_2022_Amel/singlet-out/${GSM}/${GSM}_singlet.h5"
Rscript --vanilla run_scDblFinder.R $input_h5 $output_h5
```

```bash
GSM="GSM5590454"
input_h5="./Zhang_iScience_2022_Amel/cellbender-out/${GSM}/${GSM}_filtered.h5"
output_h5="./Zhang_iScience_2022_Amel/singlet-out/${GSM}/${GSM}_singlet.h5"
Rscript --vanilla run_scDblFinder.R $input_h5 $output_h5
```

```bash
GSM="GSM5590455"
input_h5="./Zhang_iScience_2022_Amel/cellbender-out/${GSM}/${GSM}_filtered.h5"
output_h5="./Zhang_iScience_2022_Amel/singlet-out/${GSM}/${GSM}_singlet.h5"
Rscript --vanilla run_scDblFinder.R $input_h5 $output_h5
```

```bash
GSM="GSM5590456"
input_h5="./Zhang_iScience_2022_Amel/cellbender-out/${GSM}/${GSM}_filtered.h5"
output_h5="./Zhang_iScience_2022_Amel/singlet-out/${GSM}/${GSM}_singlet.h5"
Rscript --vanilla run_scDblFinder.R $input_h5 $output_h5
```