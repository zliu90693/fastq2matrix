```bash
log() {
    echo
    echo "==================== $1 ===================="
    echo
}
```

```bash
check_pattern() {
    local label="$1"
    local pattern="$2"
    local file="$3"
    local count
    count=$(grep -c "$pattern" "$file" 2>/dev/null || true)
    echo "==================== [CHECK] ===================="
    echo "Stage: $label"
    echo "target: $pattern"
    echo "file: $(basename $file)"
    echo "${count} fits in total"
}
```

```bash
check_biotypes() {
    local label="$1"
    local file="$2"
    echo "==================== [CHECK] ===================="
    echo "Stage: $label"
    echo "All gene_biotype: "
    grep -o 'gene_biotype "[^"]*"' "$file" | sort | uniq -c | sort -rn
}
```

```bash
gtf_name="Apis_mellifera.Amel_HAv3.1.62.gtf"
clean_gtf_name="Apis_mellifera.Amel_HAv3.1.62.clean.gtf"
filtered_gtf_name="Apis_mellifera.Amel_HAv3.1.62.filtered.gtf"
ref_fasta="Apis_mellifera.Amel_HAv3.1.dna.toplevel.fa"
mkref_output_name="Amel_index"
```

```bash
mkdir -p .tmp
```

```bash
log "STEP 1: remove transcript_id \"\""
```

```bash
check_pattern "Before step 1" 'transcript_id "";' "$gtf_name"
sed 's/transcript_id ""; //' "$gtf_name" > ".tmp/tmp.gtf"
check_pattern "After step 1" 'transcript_id "";' "$gtf_name"
```

```bash
log "STEP 2: remove composite fields"
check_pattern "Before step 2" 'note ".*; product "' ".tmp/tmp.gtf"
check_pattern "Before step 2" 'model_evidence ".*; transcript_biotype "' ".tmp/tmp.gtf"
check_pattern "Before step 2" ' $' ".tmp/tmp.gtf"
sed 's/ $//' ".tmp/tmp.gtf" | \
    perl -pe 's|note ".*?; product "|product "|' | \
    perl -pe 's|model_evidence ".*?; transcript_biotype "|transcript_biotype "|' \
    > ".tmp/tmp1.gtf"
check_pattern "After step 2" 'note ".*; product "' ".tmp/tmp1.gtf"
check_pattern "After step 2" 'model_evidence ".*; transcript_biotype "' ".tmp/tmp1.gtf"
check_pattern "After step 2" ' $' ".tmp/tmp1.gtf"
```

```bash
log "STEP 3: Remove the quote in the middle of a value"
check_pattern "Before step 3" '" "' ".tmp/tmp1.gtf"
sed 's/" "/,/g' ".tmp/tmp1.gtf" > ".tmp/$clean_gtf_name"
check_pattern "After step 3" '" "' ".tmp/$clean_gtf_name"
```

```bash
log "STEP 4: Filt biotype using mkgtf"
check_biotypes "Before step 4" ".tmp/$clean_gtf_name"
cellranger mkgtf \
    ".tmp/${clean_gtf_name}" \
    "$filtered_gtf_name" \
    --attribute=gene_biotype:protein_coding \
    --attribute=gene_biotype:lncRNA
check_biotypes "After step 4" "$filtered_gtf_name"
```

```bash
log "STEP 5: Building reference index"
cellranger mkref --nthreads 20 \
    --genome="$mkref_output_name" \
    --fasta="$ref_fasta" \
    --genes="$filtered_gtf_name"
```

