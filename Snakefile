# =============================================================================
# Snakefile — Gut Spatial Transcriptomics Pipeline
# Replication and extension of Mayassi et al. 2024
#
# Usage:
#   snakemake --cores 1
#
# This workflow executes the analysis notebooks in order using papermill.
# Each rule defines inputs (dependencies) and outputs (produced files).
# Snakemake automatically determines execution order and skips steps
# whose outputs already exist and are up to date.
# =============================================================================

# --- Configuration ---
NOTEBOOKS_DIR = "notebooks"
FIGURES_DIR   = "results/figures"
TABLES_DIR    = "results/tables"
PROCESSED_DIR = "data/processed"

# --- Master rule: defines the final targets ---
rule all:
    input:
        # Figures from all notebooks
        f"{FIGURES_DIR}/01_unrolled_gut_overview.png",
        f"{FIGURES_DIR}/02_umap_overview.png",
        f"{FIGURES_DIR}/03_si_umap.png",
        f"{FIGURES_DIR}/dotplot_03_region_marker_dotplot.png",
        f"{FIGURES_DIR}/dotplot_03_layer_marker_dotplot.png",
        f"{FIGURES_DIR}/03_layer_marker_conservation.png",
        f"{FIGURES_DIR}/03_conserved_tip_markers_heatmap.png",
        f"{FIGURES_DIR}/04_go_crypt_vs_top_villous.png",
        f"{FIGURES_DIR}/04_go_summary.png",
        f"{FIGURES_DIR}/05_microbiome_sensitivity_heatmap.png",
        f"{FIGURES_DIR}/05_go_bottom_villous.png",
        f"{FIGURES_DIR}/05_go_top_villous_gf_up.png",
        # Tables
        f"{TABLES_DIR}/region_degs.csv",
        f"{TABLES_DIR}/layer_degs.csv",
        f"{TABLES_DIR}/layer_degs_per_region.csv",
        f"{TABLES_DIR}/spf_vs_gf_bidirectional.csv",
        f"{TABLES_DIR}/spf_vs_gf_deg_counts.csv",


# --- Rule 01: Data loading and spatial exploration ---
rule notebook_01_exploration:
    input:
        spatial_meta  = "data/raw/visium/spatial_meta.tsv",
        unroll        = "data/raw/visium/unroll_cluster.tsv",
        spatial_umap  = "data/raw/visium/spatial_cluster.tsv",
    output:
        figure = f"{FIGURES_DIR}/01_unrolled_gut_overview.png",
    shell:
        """
        papermill {NOTEBOOKS_DIR}/01_data_loading_and_exploratin.ipynb \
                  {NOTEBOOKS_DIR}/executed/01_executed.ipynb \
                  --kernel gut_project
        """


# --- Rule 02: AnnData construction and UMAP ---
rule notebook_02_anndata:
    input:
        matrix   = "data/raw/visium/matrix.mtx",
        barcodes = "data/raw/visium/barcodes.tsv",
        genes    = "data/raw/visium/genes.tsv",
        meta     = "data/raw/visium/spatial_meta.tsv",
        unroll   = "data/raw/visium/unroll_cluster.tsv",
        umap     = "data/raw/visium/spatial_cluster.tsv",
    output:
        h5ad   = f"{PROCESSED_DIR}/visium_gut.h5ad",
        figure = f"{FIGURES_DIR}/02_umap_overview.png",
    shell:
        """
        papermill {NOTEBOOKS_DIR}/02_anndata_construction_and_umap.ipynb \
                  {NOTEBOOKS_DIR}/executed/02_executed.ipynb \
                  --kernel gut_project
        """


# --- Rule 03: Small intestine analysis ---
rule notebook_03_si_analysis:
    input:
        h5ad = f"{PROCESSED_DIR}/visium_gut.h5ad",
    output:
        h5ad_epi = f"{PROCESSED_DIR}/visium_si_epithelial.h5ad",
        fig1     = f"{FIGURES_DIR}/03_si_umap.png",
        fig2     = f"{FIGURES_DIR}/dotplot_03_region_marker_dotplot.png",
        fig3     = f"{FIGURES_DIR}/dotplot_03_layer_marker_dotplot.png",
        fig4     = f"{FIGURES_DIR}/03_layer_marker_conservation.png",
        fig5     = f"{FIGURES_DIR}/03_conserved_tip_markers_heatmap.png",
        table1   = f"{TABLES_DIR}/region_degs.csv",
        table2   = f"{TABLES_DIR}/layer_degs.csv",
        table3   = f"{TABLES_DIR}/layer_degs_per_region.csv",
    shell:
        """
        papermill {NOTEBOOKS_DIR}/03_small_intestine_analysis.ipynb \
                  {NOTEBOOKS_DIR}/executed/03_executed.ipynb \
                  --kernel gut_project
        """


# --- Rule 04: GO enrichment analysis ---
rule notebook_04_go_analysis:
    input:
        table1 = f"{TABLES_DIR}/layer_degs.csv",
        table2 = f"{TABLES_DIR}/layer_degs_per_region.csv",
        table3 = f"{TABLES_DIR}/region_degs.csv",
    output:
        fig1 = f"{FIGURES_DIR}/04_go_crypt_vs_top_villous.png",
        fig2 = f"{FIGURES_DIR}/04_go_summary.png",
    shell:
        """
        papermill {NOTEBOOKS_DIR}/04_GO_analysis.ipynb \
                  {NOTEBOOKS_DIR}/executed/04_executed.ipynb \
                  --kernel gut_project
        """


# --- Rule 05: Microbiome layer interaction ---
rule notebook_05_microbiome:
    input:
        h5ad_epi = f"{PROCESSED_DIR}/visium_si_epithelial.h5ad",
    output:
        fig1   = f"{FIGURES_DIR}/05_microbiome_sensitivity_heatmap.png",
        fig2   = f"{FIGURES_DIR}/05_go_bottom_villous.png",
        fig3   = f"{FIGURES_DIR}/05_go_top_villous_gf_up.png",
        table1 = f"{TABLES_DIR}/spf_vs_gf_bidirectional.csv",
        table2 = f"{TABLES_DIR}/spf_vs_gf_deg_counts.csv",
    shell:
        """
        papermill {NOTEBOOKS_DIR}/05_microbiome_layer_interaction.ipynb \
                  {NOTEBOOKS_DIR}/executed/05_executed.ipynb \
                  --kernel gut_project
        """