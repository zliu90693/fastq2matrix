Reference process: https://bioinformatics-core-shared-training.github.io/UnivCambridge_ScRnaSeq_Nov2021/Markdowns/03_CellRanger.html and https://www.sc-best-practices.org

The main steps include: 
- getting fastq; 
- aligning fastq to the reference genome using CellRanger to generate a UMI counting matrix;
- removing ambient RNA using CellBender;
- and removing doublet RNA using scDblfinder.

To reproduce this project, please follow the workflow in 0_main-pipeline.md.

Note: To run the bash scripts in .md file, you need to download the Markdown Execute plugin.
