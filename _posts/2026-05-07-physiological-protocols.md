---
layout: post
title: "Protocol: Integrated Physiological Analysis (Protein, Chl a, and Symbiont Density)"
date: 2026-05-30
categories: protocols physiology
---

Protocol: Physiological Quantification of *S. pistillata* Larvae and Spats

This protocol describes the multi-step processing of individual or pooled planulae and spats to quantify total protein content, chlorophyll *a* concentration, and algal symbiont density.

**Version:** May 7, 2026

## 1. Sample Preparation and Homogenization
To ensure all physiological metrics are captured from the same biological material, samples must be homogenized thoroughly.

1.  **Thawing:** Remove samples from the -80°C freezer and place on ice.
2.  **Initial Buffer:** Add 0.25 mL of filtered seawater (FSW) or PBS to each 1.5 mL Eppendorf tube.
3.  **Mechanical Lyse:** Homogenize the tissue using an electrical handheld homogenizer for 30 seconds or until no visible chunks remain.
4.  **Final Volume:** Add an additional 0.25 mL of buffer (Total volume = 0.5 mL) and vortex briefly.
5.  **Aliquoting:** * Transfer **0.1 mL** to a new tube for the **Protein Assay**.
    * Reserve the remaining **0.4 mL** for **Cell Counting** and **Chl a**.

---

## 2. Total Protein Quantification (BCA Assay)
*Utilizing the Cyanagen µQPRO – BCA kit.*

1.  **Centrifugation:** Spin the protein aliquot at 5,000 rpm for 5 minutes at 4°C.
2.  **Standards:** Prepare BSA calibration standards (range: 0–200 µg/mL).
3.  **Working Reagent (WR):** Mix Reagent A and Reagent B in a 25:24 ratio, then add 1 part Reagent C.
4.  **Loading:** Aliquot 100 µL of sample (diluted if necessary) and 100 µL of WR into a 96-well plate.
5.  **Incubation:** Incubate at 37°C for 120 minutes.
6.  **Measurement:** Read absorbance at **562 nm**.

---

## 3. Algal Symbiont Enumeration
1.  **Separation:** Centrifuge the reserved 0.4 mL homogenate (5,000 rpm, 5 min, 4°C).
2.  **Supernatant:** Remove the supernatant thoroughly; this contains the host fraction. The pellet contains the symbionts.
3.  **Resuspension:** Resuspend the pellet in 1 mL of FSW.
4.  **Counting:** Load 30 µL onto a hemocytometer.
5.  **Imaging:** Use an inverted fluorescence microscope (Blue excitation, 440 nm emission) to capture chlorophyll autofluorescence. 
6.  **Automation:** Process images using the custom **Fiji/ImageJ Algae Counter Macro** to determine cells/mL.

---

## 4. Chlorophyll *a* Extraction
1.  **Extraction:** To the remaining algae pellet (after cell count aliquot), add 0.5 mL of **95% Acetone**.
2.  **Incubation:** Vortex and incubate in the dark at 4°C for 8–24 hours.
3.  **Clarification:** Centrifuge at 5,000 rpm for 5 minutes.
4.  **Loading:** Transfer 100 µL of extract to a 96-well PTFE (solvent-resistant) plate.
5.  **Spectrophotometry:** Measure Optical Density (OD) at 630, 647, and 664 nm.
6.  **Calculation:** Calculate Chl *a* concentration using the Jeffrey and Humphrey (1975) equations for dinoflagellates.

---

## 5. Data Normalization
All resulting data (Protein, Chl a, Cells) should be normalized using the **Larval Volume ($mm^3$)** derived from the Capsule Model protocol to allow for meaningful comparisons between HF and NF morphs.
