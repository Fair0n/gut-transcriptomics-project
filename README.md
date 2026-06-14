# Gut Spatial Transcriptomics Project

Replication and extension of Mayassi et al. 2024:  
*"Spatially restricted immune and microbiota-driven adaptation of the gut"*  
Nature, 2024. https://doi.org/10.1038/s41586-024-08216-z

---

## Project Overview

This project uses Visium spatial transcriptomics data from Mayassi et al. 2024 
to characterize the transcriptional architecture of the small intestinal villus 
and its sensitivity to microbiome presence.

**Primary question:** Is the crypt-to-villus transcriptional gradient conserved 
across SI segments (duodenum, jejunum, ileum)?

**Secondary question:** Does the microbiome (SPF vs GF) affect gene expression 
differently depending on villus layer position?

---

## Data

Downloaded from Broad Single Cell Portal (SCP2762).

| Property | Value |
|---|---|
| Technology | Visium Spatial Gene Expression |
| Species | Mouse (*Mus musculus*) |
| Total spots | ~120,000 |
| Regions | Duodenum, Jejunum1, Jejunum2, Ileum, Colon |
| Conditions | SPF (normal), GF (germ-free), FMT (transplant) |
| Villus layers | Crypt SI, Bottom villous SI, Top villous SI, Muscle SI |

For further analysis the colon and FMT data was abandoned.

Raw data files are not included in this repository due to size.  
Download from: https://singlecell.broadinstitute.org/single_cell/study/SCP2762

---

## Repository Structure
gut-transcriptomics-project/
│
├── Snakefile
├── README.md
│
├── notebooks/
│   ├── 01_data_loading_and_exploratin.ipynb
│   ├── 02_anndata_construction_and_umap.ipynb
│   ├── 03_small_intestine_analysis.ipynb
│   ├── 04_GO_analysis.ipynb
│   └── 05_microbiome_layer_interaction.ipynb
│
├── results/
│   ├── figures/
│   └── tables/
│
└── report/

---

## Key Findings

1. **Conserved villus layer program:** A large conserved transcriptional 
   core exists across all SI segments — 646 crypt markers and 2,381 villus 
   tip markers are shared across duodenum, jejunum, and ileum.

2. **Region-specific overlay:** The villus tip shows the most region-specific 
   variation, with the ileum having the most unique tip transcriptional program 
   (975 unique markers).

3. **Microbiome asymmetry:** The microbiome differentially affects villus layers — 
   promoting expression in the bottom villous SI and suppressing gene expression 
   machinery (mRNA processing, translation) at the villus tip. In germ-free mice
   these processes are upregulated at the villus tip.


---

## Environment Setup

```bash
conda create -n gut_project python=3.11 -y
conda activate gut_project
conda install -c conda-forge scanpy leidenalg scikit-misc jupyter -y
python -m pip install snakemake papermill gseapy
```

---

## Running the Workflow

```bash
# Dry run — shows what would be executed
snakemake --dry-run --cores 1

# Full run — executes all notebooks in order
snakemake --cores 1
```

Note: Full execution requires ~23GB RAM and due to 
the size of the expression matrix.

---

## Reference

Mayassi T, et al. Spatially restricted immune and microbiota-driven adaptation 
of the gut. *Nature*. 2024. https://doi.org/10.1038/s41586-024-08216-z
