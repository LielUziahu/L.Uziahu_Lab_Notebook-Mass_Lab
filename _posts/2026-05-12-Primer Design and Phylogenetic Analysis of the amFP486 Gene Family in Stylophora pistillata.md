# Primer Design and Phylogenetic Analysis of the amFP486 Gene Family in *Stylophora pistillata*

## 1. Project Objective and Introduction
**Target Organism:** *Stylophora pistillata* (Lace Coral).  
**Gene/Barcode Region:** amFP486 (GFP-like fluorescent protein family).  

**Introduction:** In reef-building corals, fluorescent proteins play a vital role in physiological resilience and photoprotection. My research specifically focuses on the phenotypic divergence between High-GFP and Non-fluorescent larval morphs in *S. pistillata*. This project aims to analyze the evolutionary relationships between different gene codenig for the same fluorescent protein paralogs within the species and design specific primers for gene expression quantification (RT-qPCR).

**Goal:** Identify conserved domains for primer design and construct a phylogenetic tree to resolve the relationship between intra-species protein variants.

---

## 2. Sequence Collection and Alignment
**NCBI Accession Numbers Used:**
* `LOC111319708` (*S. pistillata* GFP-like fluorescent chromoprotein amFP486, mRNA - Target Template)
* `LOC111347142` (*S. pistillata* GFP-like fluorescent chromoprotein amFP486, mRNA)
* `LOC111346784` (*S. pistillata* GFP-like fluorescent chromoprotein amFP486, mRNA)
* `LOC111344518` (*S. pistillata* GFP-like fluorescent chromoprotein amFP486, mRNA)
* `LOC111344517` (*S. pistillata* GFP-like fluorescent chromoprotein amFP486, mRNA)
* `LOC111342395` (*S. pistillata* GFP-like fluorescent chromoprotein amFP486, mRNA)
* `DQ206398.1` (*S. pistillata* GFP-like chromoprotein mRNA, complete cds)
* `AF420592.1` (*Acropora tenuis* s0366_g7_t1 mRNA for green fluorescent protein, complete cds - **Outgroup**)

**Alignment Parameters:**
* **Software:** MEGA (Molecular Evolutionary Genetics Analysis)
* **Method:** ClustalW
* **Sequence Type:** DNA (mRNA/Coding Sequences)

### Multiple Sequence Alignment (MSA) Output
> <img width="1397" height="716" alt="image1" src="https://github.com/user-attachments/assets/ce39a3ce-3d45-44de-8fd3-fddbbfd655b5" />


**Sequence Analysis:**
* **Conserved Regions:** Identified by the '*' consensus symbols, particularly at the 5' and 3' flanking regions. These represent structurally essential motifs of the beta-barrel protein structure.
* **Variable Regions:** Significant SNPs were identified in the internal regions. These variations distinguish the different genes codenig for the same protein.

---

## 3. Primer Design (NCBI Primer-BLAST)
Primers were optimized for the target sequence `LOC111319708` using the following criteria: Product size ;430bp, Tm ~60°C.

> <img width="2451" height="1031" alt="image2" src="https://github.com/user-attachments/assets/d24d66c0-a0de-4e4d-a88b-7c3e9576aed4" />


### Selected Primer Pair Detail:
| Property | Forward Primer | Reverse Primer |
| :--- | :--- | :--- |
| **Sequence (5'->3')** | 	GTGGCACCGACCTTGAAGTA | GGTTGGTTCTGGTAAGGCGA |
| **Length** | 20 bp | 20 bp |
| **Melting Temp (Tm)** | 59.97°C | 59.96°C |
| **GC Content** | 55% | 55% |
| **Primer Position** | 181-200 | 610-591 |

* **Expected Amplicon Size:** 430bp.
* **Specificity:** Verified via Primer-BLAST against the *Stylophora pistillata* taxid; no significant off-target amplification predicted.

---

## 4. Phylogenetic Tree Construction
**Methodology:**
* **Tree-Building Method:** Neighbor-Joining (NJ)
* **Substitution Model:** Kimura 2-parameter model
* **Test of Phylogeny:** Bootstrap method (1000 replicates)
* **Gaps/Missing Data:** Pairwise deletion

### Final Phylogenetic Tree
<img width="1919" height="960" alt="image3" src="https://github.com/user-attachments/assets/9fbaa215-ee3e-4cef-9bf2-f56c54449ab1" />


**Interpretation:**
* **Clustering:** All *S. pistillata* fluorescent protein sequences cluster together with high bootstrap support, confirming they are paralogous genes within the same lineage.
* **Evolutionary Context:** The tree resolved the separation between the green fluorescent variants and the chromoprotein. 
* **Outgroup:** *Acropora tenuis* correctly branches as the outgroup after manual rooting, providing a clear evolutionary direction.

***
**Author:** Liel Uziahu  
**PhD Research Focus:** Larval Physiology in *Stylophora pistillata* **Date:** May 2026
