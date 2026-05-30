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
3.  **Resuspension:** Resuspend the pellet in 0.1 mL of PBSX1.
4.  **Counting:** Load 20 µL onto a hemocytometer.
5.  **Imaging:** Use an inverted fluorescence microscope (Blue excitation, 440 nm emission) to capture chlorophyll autofluorescence. 
6.  **Automation:** Process images using the custom **Fiji/ImageJ Algae Counter Macro** to determine cells/mL.

---

## 4. Chlorophyll *a* Extraction
1.  **Separation:** Centrifuge the reserved 0.4 mL homogenate (5,000 rpm, 5 min, 4°C).
2.  **Supernatant:** Remove the supernatant thoroughly; this contains the host fraction. The pellet contains the symbionts.
1.  **Extraction:** To the remaining algae pellet (after cell count aliquot), add 0.3 mL of **pre-chilled 90% Acetone**.
2.  **Incubation:** Vortex and incubate in the dark at 4°C for 8–24 hours.
3.  **Clarification:** Centrifuge at 5,000 rpm for 5 minutes.
* **Loading Sample Triplicate :** For each individual planulae extract tube, load 3 separate wells with:
    * **80 µL** of clear sample acetone supernatant.
    * **20 µL** of your pure, unbuffered 90% acetone stock.
    * *Total In-Well Volume = 100 µL per well.*
* **Blank Wells:** Load a minimum of 3 separate control reference wells with exactly **100 µL** of pure 90% acetone.
5.  **Spectrophotometry:** Measure Optical Density (OD) at 630, 647, 664 and 750 nm.
6.  **Calculation:** Calculate Chl *a* concentration using the Jeffrey and Humphrey (1975) equations for dinoflagellates.

---


## 5.  Chl a Operational Parameters Matrix
* $N$ = Total count of individual planulae pooled inside that specific extraction tube (use $N=1$ for single-larva extractions).
* $b = 0.52\text{ cm}$ *(Fixed vertical pathlength correction constant for a 100 µL total volume footprint in a 96-well half-area well)*
* $\text{DF} = 1.25$ *(In-well pipetting dilution factor derived from $\frac{100\ \mu\text{L Well Volume}}{80\ \mu\text{L Extract Added}}$)*
* $\text{RF} = 1.25$ *(Biomass recovery factor derived from $\frac{100\ \mu\text{L Total Aqueous Volume}}{80\ \mu\text{L Saved for Acetone}}$ to mathematically re-integrate the 20% aliquot shifted to microscopy)*

### Step 5.1: Pathlength & Turbidity Adjustments
Clear out background light scattering artifacts by subtracting the zero-absorption value ($A_{750}$) and convert the vertical microplate optics into standardized horizontal 1-cm optical paths ($A_{1\text{cm}}$):

$$A_{1\text{cm at 664}} = \frac{A_{664} - A_{750}}{0.52}$$

$$A_{1\text{cm at 647}} = \frac{A_{647} - A_{750}}{0.52}$$

$$A_{1\text{cm at 630}} = \frac{A_{630} - A_{750}}{0.52}$$

### Step 5.2: In-Well Cross-Correction Concentrations (Jeffrey & Humphrey, 1975)
Determine the active raw pigment densities ($\mu\text{g/mL}$) inside the well using the certified dinoflagellate linear equations:

$$\text{Chl } a_{\text{well}} = 11.43 \times (A_{1\text{cm at 664}}) - 0.64 \times (A_{1\text{cm at 647}}) - 0.12 \times (A_{1\text{cm at 630}})$$

$$\text{Chl } c_{2\text{ well}} = -3.73 \times (A_{1\text{cm at 664}}) - 3.73 \times (A_{1\text{cm at 647}}) + 23.29 \times (A_{1\text{cm at 630}})$$

### Step 5.3: Standardized Physiological Yields per Larva

#### Average Symbiodiniaceae Abundance
Scale your grid count from the 20 µL microscopy fraction back up to the parent 100 µL aqueous volume, and normalize by the number of pooled planulae ($N$):

$$\text{Symbiodiniaceae Cells / Planula} = \frac{\text{Cells counted inside } 20\ \mu\text{L fraction} \times 5}{N}$$

#### Standardized Absolute Chlorophyll Mass
Calculate absolute pigment weight ($\mu\text{g}$) per single larva by multiplying by your in-well dilution ($\text{DF}=1.25$), total extraction volume ($V_{\text{extract}}=0.3\text{ mL}$), and biological pellet recovery factor ($\text{RF}=1.25$), combined as a static scalar coefficient ($1.25 \times 0.3 \times 1.25 = 0.46875$):

$$\text{Total Chl } a\ (\mu\text{g/planula}) = \frac{\text{Chl } a_{\text{well}} \times 0.46875}{N}$$

$$\text{Total Chl } c_2\ (\mu\text{g/planula}) = \frac{\text{Chl } c_{2\text{ well}} \times 0.46875}{N}$$

---

## 6. Integrated Spreadsheet Formulas (For Data Sheet Automation)

To process your raw microplate exports instantly in Excel, JMP, or Python scripts, use these fully expanded master expressions:

### Direct Formula for Chlorophyll *a* Yield per Planula ($\mu\text{g}$):
$$\text{Total Chl } a\ (\mu\text{g/planula}) = \frac{\left[ 11.43 \left(\frac{A_{664}-A_{750}}{0.52}\right) - 0.64 \left(\frac{A_{647}-A_{750}}{0.52}\right) - 0.12 \left(\frac{A_{630}-A_{750}}{0.52}\right) \right] \times 0.46875}{N}$$

### Direct Formula for Chlorophyll *c₂* Yield per Planula ($\mu\text{g}$):
$$\text{Total Chl } c_2\ (\mu\text{g/planula}) = \frac{\left[ -3.73 \left(\frac{A_{664}-A_{750}}{0.52}\right) - 3.73 \left(\frac{A_{647}-A_{750}}{0.52}\right) + 23.29 \left(\frac{A_{630}-A_{750}}{0.52}\right) \right] \times 0.46875}{N}$$

