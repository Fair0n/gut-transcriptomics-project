# Gut Spatial Transcriptomics Project

Replication and extension of Mayassi et al. 2024:
"Spatially restricted immune and microbiota-driven adaptation of the gut"

## Project Overview
This project analyzes Visium spatial transcriptomics data from the mouse gut,
focusing on the small intestine. We replicate the paper's core findings and
extend the analysis to characterize the crypt-to-villus transcriptional
gradient across duodenal, jejunal, and ileal segments.

## Data
Downloaded from Broad Single Cell Portal (SCP2762).
~120,000 Visium spots covering Duodenum, Jejunum1, Jejunum2, Ileum, Colon.
Three microbiome conditions: SPF, GF, FMT.

## Notebooks
- `01_data_loading_and_exploration.ipynb` — spatial overview, metadata exploration
- `02_anndata_construction_and_umap.ipynb` — preprocessing pipeline, UMAP replication
- `03_small_intestine_analysis.ipynb` — SI regional differences (in progress)
- `04_crypt_villus_trajectory.ipynb` — crypt-to-villus gradient analysis (in progress)

## Environment Setup
```bash
conda create -n gut_project python=3.11 -y
conda activate gut_project
conda install -c conda-forge scanpy leidenalg scikit-misc jupyter -y
```

## Reference
Mayassi et al. 2024, Nature. https://doi.org/10.1038/s41586-024-08216-z
EOF



gut-spatial-project/
│
├── README.md                  ← project overview
├── Snakefile                  ← automates the full workflow
├── environment.yml            ← conda environment (reproducibility)
│
├── data/
│   ├── raw/                   ← downloaded .rds / .csv files (gitignored)
│   └── processed/             ← converted .h5ad files
│
├── notebooks/
│   ├── 01_data_exploration.ipynb
│   ├── 02_replication_scrna.ipynb
│   ├── 03_small_intestine_focus.ipynb
│   └── 04_crypt_villus_trajectory.ipynb
│
├── scripts/
│   ├── convert_rds_to_h5ad.R  ← one R script to convert, then pure Python
│   └── utils.py
│
├── results/
│   ├── figures/
│   └── tables/
│
└── report/
    └── report.tex