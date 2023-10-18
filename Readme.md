# Readme

WGCNA_ROSMAP was written in Rmarkdown format, which could be called in WGCNA_ConfigAndRun.R.

# Required Files

I processed the RNASeq data, the other co-factors were regressed out, and the residual lcpm were saved in lcpm_WithoutFactors_ROSMAP.Rdata

The corresponding sample demographics including Sex, APOE, Age, etc were in x_normalized_ROSMAP.Rdata

Both files were in the directory specified in the variable ``dataDir`` in WGCNA_ConfigAndRun.R

# Run

To run the script, just go to WGCNA_ConfigAndRun.R, config the `current_groupname` and `current_groups`, and Run 'WGCNA_ConfigAndRun.R'.