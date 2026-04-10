#' Run scDblFinder and output singlet
#' Rscript --vanilla run_scDblFinder.R filtered.h5 singlet.h5
#' arg1: filtered H5 produced by `cellbender`
#' arg2: output H5 of singlets called by `scDblFinder`
library(hdf5r)

# utils ##########################################################################################
#' copy a group from one H5 file to another file recursively
#' @param from H5 file to copy from
#' @param to H5 file to copy to
#' @param grp group to be copied
copy_group <- function(from, to, grp){
    if(!existsGroup(to, grp)){
        createGroup(to, grp)
    }
    items <- from[[grp]]$ls()
    for(i in seq_len(nrow(items))){
        item_path <- paste(grp, items$name[i], sep = '/')
        if(items$obj_type[i] == 'H5I_GROUP'){
            copy_group(from, to, item_path)
        }else{
            to[[item_path]] <- from[[item_path]][]
        }
    }
}


#' read cellbender H5 into a sparse matrix
cb_h5_to_smat <- function(cb_h5){
    # when creating sparse Matrix, parameter `i` is 1-based. That's why the `+1`.
    # For a sparse matrix, index slot (`m@i` or `h5[["matrix/indices"]]`) is 0-based.
    m <- Matrix::sparseMatrix(
        i = cb_h5[["matrix/indices"]][] + 1,
        p = cb_h5[["matrix/indptr"]][],
        x = cb_h5[["matrix/data"]][],
        dims = cb_h5[["matrix/shape"]][][],
        dimnames = list(
            cb_h5[["matrix/features/name"]][],
            cb_h5[["matrix/barcodes"]][]),
        repr = "C")
    return(m)
}

bp <- BiocParallel::MulticoreParam(8, RNGseed=2023)
# main ##########################################################################################
args <- commandArgs(trailingOnly = TRUE)
cellbender_h5 <- args[1]
singlet_h5 <- args[2]

# read count matrix
# cb_h5 <- H5File$new('/nfs_data/huangy/bee_project/10xv3/queen_rep1_output_filtered.h5', mode = 'r')
cb_h5 <- H5File$new(cellbender_h5, mode = 'r')
fb_matrix <- cb_h5_to_smat(cb_h5)

# remove cells with two few UMIs
# https://bioconductor.org/packages/devel/bioc/vignettes/scDblFinder/inst/doc/scDblFinder.html#should-i-run-qc-cell-filtering-before-or-after-doublet-detection
fb_matrix <- fb_matrix[, Matrix::colSums(fb_matrix) >= 200]

# detect doublets
sce <- scDblFinder::scDblFinder(fb_matrix, clusters = TRUE, BPPARAM = bp)
sce_singlet <- sce[, sce$scDblFinder.class == 'singlet']

# export scDblFinder result
df_h5 <- H5File$new(singlet_h5, mode = 'w')
df_h5$create_group('matrix')
df_h5[['matrix/barcodes']] <- colnames(sce_singlet)
df_h5[['matrix/data']] <- SingleCellExperiment::counts(sce_singlet)@x
copy_group(cb_h5, df_h5, 'matrix/features')
df_h5[['matrix/indices']] <- SingleCellExperiment::counts(sce_singlet)@i
df_h5[['matrix/indptr']] <- SingleCellExperiment::counts(sce_singlet)@p
df_h5[['matrix/shape']] <- SingleCellExperiment::counts(sce_singlet)@Dim

df_h5$close_all()
cb_h5$close_all()
