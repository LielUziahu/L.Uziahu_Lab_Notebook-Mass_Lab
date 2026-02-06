---
layout: post
title: "SOP: Standardized Algae Counting & Imaging Protocol"
category: [Lab Protocol, Image Analysis]
tags: [ImageJ, Fiji, Corals, Symbionts, Algae Counting]
---

# SOP: Standardized Algae Counting Protocol (2026)

This protocol outlines the end-to-end workflow for quantifying symbiont density, from microscope settings to automated image analysis using ImageJ/Fiji.

## 1. Information and Purpose
The goal of this protocol is to standardize the calculation of algae cell concentrations (cells/mL) across different coral research projects. By using a specific "Middle Big Square" crop logic, we ensure that the area analyzed always represents a known, fixed volume of the hemocytometer (0.1 µL), regardless of the camera's full field of view.

## 2. Phase 0: Imaging Protocol (Critical)
To ensure the automated script calculates volume correctly, all images **must** be taken using these exact settings.

| Setting | Requirement |
| :--- | :--- |
| **Magnification** | 10X Objective (Total Mag: 100X). Do not use 20X or 40X for counting. |
| **Fluorescence Channel** | Use the **Chlorophyll / Red** channel (Excitation: ~450-480nm, Emission: >600nm). |
| **Exposure** | Adjust so cells are bright but **not** saturated. Background should be dark. |

### Camera Settings (Binning)
* **Hemocytometer (Brightfield):** Full Resolution (Binning 1x1). Expected Size: ~1600 x 1600 pixels.
* **Algae (Fluorescence):** High Sensitivity (Binning 3x3). Expected Size: ~536 x 536 pixels.
    > **Note:** If you change the binning, you must update the `boxSize` in the script (e.g., 512 for 3x3 binning, 1360 for 1x1).

---

## 3. Mandatory File Naming Convention
The script uses **String Parsing** to group replicates and calculate averages. If the naming is wrong, the CSV output will be incorrect.

**The Rule:** `SampleID_ReplicateNumber.extension`

* **The Underscore (`_`) is the Divider:** The script reads everything *before* the first underscore as the Sample Name.
* **Replicate Number:** Everything *after* the underscore identifies the specific image.
* **Example of Correct Naming:**
    * `S1_01.nd2`, `S1_02.nd2`, `S1_03.nd2` → Result: One row for "S1" with an average of 3 counts.
    * `Coral-Alpha_01.tif`, `Coral-Alpha_02.tif` → Result: One row for "Coral-Alpha".

---

## 4. The Logic: Why It Works
The script relies on a precise spatial calibration to convert "pixels" into "volume".

| Parameter | Setting/Value | Rationale |
| :--- | :--- | :--- |
| **The "Cut" (Volume)** | 512x512 box | Represents exactly **0.1 µL**. Based on Standard Neubauer Central Square = 1mm x 1mm. |
| **The Threshold** | **"Triangle"** Method | Optimized for "dim" cells; ignores background static better than standard "Otsu". |
| **The Size Filter** | **> 50 pixels** | Removes small dust/noise (~14px) while keeping small algae (~240px). |
| **Watershed** | Active | Automatically cuts lines between cells that are touching to count them as two objects. |

---

## 5. Running the Scripts

### A. Universal Automated Counter (F4)
*Best for high-throughput analysis of clean images (no scale bars).*

* **File Name:** `Auto_Algae_Counter.ijm`
[**⬇️ View/Download the ImageJ Macro File (.ijm)**](https://github.com/LielUziahu/L.Uziahu_Lab_Notebook-Mass_Lab/blob/master/_scripts/ImageJ_scripts/Auto_Algae_Counter.ijm)
* **Installation:** In ImageJ/Fiji, go to `Plugins` > `Macros` > `Run...` and select the downloaded file.

1.  **Launch:** Open ImageJ and press **F4**.
2.  **Select Folders:** Choose your **Input** (raw images) and **Output** (where CSV/JPEGs go).
3.  **Process:** The script runs in **Batch Mode**. You won't see the images opening; wait for the "Success" message.

### B. Scale Bar Eraser Script (F2)
*Use if your images contain a scale bar, date stamp, or any text burned into the image.*

* **File Name:** `Auto_Algae_Counter_with_Scalebar.ijm`
[**⬇️ View/Download the ImageJ Macro File (.ijm)**](https://github.com/LielUziahu/L.Uziahu_Lab_Notebook-Mass_Lab/blob/master/_scripts/ImageJ_scripts/Auto_Algae_Counter_with_Scalebar.ijm)
* **Installation:** In ImageJ/Fiji, go to `Plugins` > `Macros` > `Run...` and select the downloaded file.


1.  **Launch:** Press **F2**.
2.  **Manual Step:** The script will open each image and **beep**.
3.  **Eraser Action:**
    * Use the **Rectangle tool** (it selects automatically) to draw a box over the scale bar.
    * Click **OK** in the "waitForUser" box.
4.  **Result:** The script paints that area black (value = 0) so the software ignores it during the count.

---

## 6. Final Output & Verification

### The CSV Results (`Algae_Results_...csv`)
* **Conc (Cells/mL):** The final concentration calculated as: $Average \times 10,000$.
* **Average:** The mean count of all replicates for that Sample ID.
* **Counts:** Raw data for every individual image to allow for outlier detection.

### "Checked" Evidence Images
Every image is saved as a `.jpg` with **Cyan Outlines** around detected cells.
> [!WARNING]
> **Check the JPEGs!** If you see a large cyan box around your scale bar, you forgot to use the Eraser script, and your concentration data is incorrect.

## 5. The Script Code (Downloadable)

To ensure the ImageJ macro runs correctly, the entire script is provided as a downloadable file. This prevents errors from broken line breaks during copy-paste.

---
