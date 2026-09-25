# TCGA-CESC Stage-Associated Transcriptional Reprogramming

Reproducibility repository for the focused cervical-cancer study:

> **Stage-Associated Transcriptional Reprogramming in Cervical Cancer Reveals Nonlinear Epithelial-Inflammatory and Stromal Expression States**

## Scope

This is a **standalone stage-associated transcriptional-state analysis**, separated from the broader cervical-cancer target-evidence triangulation project.

Only two archived inputs are used:

- `data/archived/clinical_metadata.csv`
- `data/archived/stage_expression.csv`

GWAS/MR, Open Targets, DepMap, GDSC, LINCS, CELLxGENE and age-stratified outputs are intentionally excluded because they do not establish stage-wise progression or prognosis.

## Scientific boundary

The archived stage table contains stage-level expression means and Spearman tests for 25 prespecified genes. It does **not** contain patient-level expression linked to PFI, OS, DSS or recurrence. Therefore this repository does not fit Kaplan-Meier curves, Cox models or a prognostic gene signature.

The locked tumour-only cohort is:

- 306 tumours total;
- 299 tumours with valid FIGO I-IV stage;
- Stage I: 162;
- Stage II: 69;
- Stage III: 46;
- Stage IV: 22;
- 7 tumours with missing stage;
- 3 stage-labelled solid-tissue normal records excluded from the tumour-stage denominator.

Across the 25 stage tests, 9 have nominal `P < 0.05`, but **0/25** meet `BH FDR < 0.05`; minimum FDR = `0.07822975`.

## Reproduce

```bash
python -m venv .venv
source .venv/bin/activate      # Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
python analysis/run_analysis.py
python tests/test_results.py
```

The workflow verifies SHA-256 checksums for both archived inputs before analysis.

## Repository layout

```text
analysis/run_analysis.py        deterministic stage-analysis pipeline
data/archived/                  two frozen processed inputs
data/manifest.csv               SHA-256 provenance manifest
results/tables/                 generated numerical outputs
results/figures/                manuscript figure outputs (PNG + SVG)
tests/test_results.py           numerical and claim-boundary checks
docs/ARTICLE_DATA_MAPPING.md    manuscript-to-output mapping
docs/PROGNOSTIC_EXTENSION_REQUIREMENTS.md
.github/workflows/reproduce.yml GitHub Actions reproduction test
```

## Main outputs

- `results/tables/cohort_summary.csv`
- `results/tables/stage_histology_counts.csv`
- `results/tables/stage_corrected.csv`
- `results/tables/nominal_stage_signals.csv`
- `results/tables/analysis_summary.json`
- `results/figures/Figure1_stage_histology_distribution.{png,svg}`
- `results/figures/Figure2_stage_association_effects.{png,svg}`
- `results/figures/Figure3_nominal_gene_stage_trajectories.{png,svg}`
  
## Execution Order to Reproduce Results
To reproduce the analyses presented in the manuscript, execute the scripts in the following order:
1. `01_curate_cohort.py` - Cleans the stage denominator and excludes normal samples.
2. `02_calculate_FDR.R` - Recalculates the Benjamini-Hochberg FDR values for the 25-gene panel.
3. `03_harmonize_OncoDB.py` - Consolidates the OncoDB 2.0 sensitivity analysis outputs.
   
## Figure typography

The plotting code requests **Times New Roman**. Linux CI runners may fall back to a Times-compatible serif. SVG text remains editable and is the preferred source for final journal typography adjustment on a workstation with Times New Roman installed.

## Prognostic extension

A true prognostic study requires patient-level TCGA-CESC expression linked to standardized outcomes, clinically adjusted Cox modelling, internal validation and independent validation. See `docs/PROGNOSTIC_EXTENSION_REQUIREMENTS.md`.

## Data provenance

This repository redistributes only the processed derivative inputs required to reproduce the archived stage audit. It does not contain controlled-access data or raw TCGA sequencing files.

## License

Code: MIT License. Third-party data remain subject to their original provider terms.

## Manuscript snapshot

The repository includes the current manuscript snapshot in both editable Word and GitHub-readable Markdown form:

- `manuscript/ARTICLE_CURRENT.docx`
- `manuscript/ARTICLE_CURRENT.md`

Numerical claims in the manuscript are mapped to pipeline outputs in `docs/ARTICLE_DATA_MAPPING.md`. If the manuscript changes, rerun the analysis and tests before release.
