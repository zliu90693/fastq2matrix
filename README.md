Reference process: https://medium.com/@datirium/the-single-cell-mess-at-ncbi-how-geo-sra-store-10x-genomics-scrna-seq-data-and-how-to-load-them-981b75a87c93

Note: To run the bash scripts in .md file, you need to download the Markdown Execute plugin.

---

Detailed pipeline:

Zhang_iScience_2022_Amel
- The reference genome and its annotations (located in the ref directory) can be downloaded from ensembl manually;
- Subsequently, the reference genome was examined using 1_ref_inspection.py, including the presence of mitochondrial sequences and UTR coverage;
- The SRR list is obtained by querying GEO (i.e., downloading the Accession List from NCBI). Next, we will use 2_get_fastq.md (need the Markdown Execute plugin) to download FastQ via the SRR list.