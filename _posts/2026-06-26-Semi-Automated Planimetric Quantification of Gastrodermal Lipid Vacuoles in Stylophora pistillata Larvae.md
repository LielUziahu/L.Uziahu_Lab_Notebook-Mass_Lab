---
layout: post
title: "Semi-Automated Planimetric Quantification of Gastrodermal Lipid Vacuoles in Stylophora pistillata Larvae"
date: 2026-06-26
---


---
# Standard Operating Procedure (SOP)
## Semi-Automated Planimetric Quantification of Gastrodermal Lipid Vacuoles in Stylophora pistillata Larvae

---

## 1. Purpose and Scope
This protocol outlines the standardized methodology for isolating, quantifying, and categorizing lipid depletion and storage profiles within the gastrodermis of brooding Stylophora pistillata planula larvae. Designed for execution within the Fiji (ImageJ) environment, this semi-automated pipeline processes raw Olympus .oir imaging data. It utilizes spatial masking, spatial normalization, and particle analysis to generate reproducible volumetric proxies—specifically the Gastrodermal Lipid Area Fraction and the Structural Consumption Index—without the confounding noise introduced by total bulk-tissue extractions.

---

## 2. Methodological & Biological Rationale
Lecithotrophic S. pistillata planulae rely heavily on maternally translocated lipids (primarily wax esters and triacylglycerols) to fuel long-distance dispersal and settlement energetics. Standard histological processing (fixation, paraffin embedding, and clearing) completely dissolves these neutral lipid fractions, leaving behind distinct, clear intracellular vacuoles within the pink-stained host gastrodermal matrix. 

This digital planimetry pipeline isolates these vacuoles based on distinct optical and structural markers:
* **Optical Contrast Optimization:** Grayscale operations are executed exclusively on the Green Channel (C2-) of the split raw imaging file. This specific wavelength yields the highest signal-to-noise ratio and structural definition between the stained cytoplasmic tissue boundaries and the clear empty lumens of the lipid vacuoles.
* **Spatial Normalization (The Endodermal Boundary):** Neutral lipids are segregated to the gastrodermis (endoderm). Tracing the overall body boundary and isolating the internal endodermal ring removes variation caused by larva size or ectodermal thickness.
* **Morphological Filtering:** Natural intracellular surface tension maintains lipid droplets in near-perfect spherical configurations. The application of a digital Watershed separation technique resolves adjacent, overlapping droplets. The pipeline then categorizes structural variations based on size boundaries: intact, isolated droplets are separated from larger, irregular voids that characterize merged macro-vacuoles or tissue tearing artifacts.

---

## 3. Prerequisites & Workspace Setup
Before executing the macro file (script_3.ijm), ensure your workspace conforms to the following configuration:
* **Software Deployment:** Install the latest distribution of Fiji (ImageJ).
* **Dependency Verification:** Update the Bio-Formats Importer plugin library to ensure native rendering and metadata preservation of native Olympus .oir and .OIR structures.
* **Directory Infrastructure:** Establish a local workspace containing two isolated folders:
    1. Input_Directory: Populated exclusively with raw, uncompressed larval cross-section .oir files.
    2. Output_Directory: An empty target folder reserved for data append logging and visual auditing proofs.

---

## 4. Step-by-Step Operational Procedure

### Phase I: Macro Initialization
1. Launch Fiji.
2. Navigate to Plugins > Macros > Run... and select the designated file script_3.ijm.
3. Follow the graphical user interface prompts to define paths:
    * Prompt 1: Select the path pointing to your raw Input_Directory.
    * Prompt 2: Select the target destination path for your Output_Directory.

NOTE: The pipeline contains an integrated redundancy check. It parses the master output CSV string and will automatically skip any files that have already been cataloged, preventing duplicate entries if a run is paused or restarted.

### Phase II: Spatial Region of Interest (ROI) Boundaries
Once an image is opened, the script isolates the Green channel, converts the matrix to an 8-bit grayscale frame, activates the Polygon Selection Tool, and pauses for user annotation:

1. **Trace 1: Total Perimeter**
    * Trace along the absolute outer periphery of the larva's ectoderm layer.
    * Close the polygon loop and click OK on the text dialogue display box. The script records this value as totalArea and flushes the interface.
2. **Trace 2: Gastrodermal Isolation**
    * Trace the internal mesoglea ring, defining the outer boundary of the inner gastrodermal layer.
    * Close the loop and click OK. 
    * The macro automatically targets this specific zone, clearing out all background noise and tissue signals outside your selection to produce a clean, isolated analysis arena.

### Phase III: Segmentation Gate & Particle Analysis
Following manual tracing, the macro applies a localized smoothing filter (Gaussian Blur, Radius: 1.5) to normalize pixelation. It then launches the interactive manual Threshold configuration screen.

CRITICAL RUNTIME WARNING: Do NOT click the "Apply", "Auto", or bottom control buttons within the ImageJ Threshold parameter box. Clicking these buttons manually breaks the macro loop. Only interact with the adjustment sliders and the separate text pop-up window.

1. Adjust the upper threshold density slider until ONLY the empty structural lipid vacuoles are highlighted in a red mask. The surrounding cellular tissue must remain black.
2. Change the threshold algorithm dropdown menu from "Default" to "Otsu" to optimize edge detection against the staining profile.
3. Click OK on the independent macro dialogue box once you have verified the mask alignment.

---

## 5. Script Parameters & Mathematical Classifications

The logic constraints governing the automated detection loop are configured via the macro's top-level control panel:

| Global Parameter | Default Setting | Operational Rule |
| :--- | :--- | :--- |
| minDropletSize | 5 | Noise Cutoff: Ignores any identified particles smaller than 5 pixels to exclude background artifacts. |
| blobSizeCutoff | 300 | Classification Boundary: The maximum size boundary for an individual droplet. Voids exceeding 300 pixels are categorized as fused macro-vacuoles. |
| minCircularity | 0.3 | Shape Filter: Rejects highly elongated linear structures (such as tissue delamination or tears). |
| maxCircularity | 1.00 | Spherical Boundary: Captures near-perfect spherical droplet spaces. |
| blurRadius | 1.5 | Smoothing Radius: Sets the pixel sigma for the Gaussian pre-processing filter. |

### Particle Sorting Logic
Once particles are measured within the minCircularity boundary, they are classified using the blobSizeCutoff filter:
* **Intact Droplets (under 300 pixels):** Outlined with a 1-pixel cyan trace and cataloged as healthy, individual energy reserves (Drop).
* **Consumed Blobs (over 300 pixels):** Outlined with a 3-pixel magenta trace and categorized as large, merged vacuole networks or advanced degradation zones (Void).

---

## 6. Output Analytics & Quality Assurance

The macro continuously compiles data rows into a unified master file within your target directory: Larvae_Consumption_Data_v10.1.csv.

### Spreadsheet Column Reference Matrix
* **File_Name:** Unique string identification key mapped to the individual larva .oir source file.
* **Total_Area:** Total cross-sectional body footprint derived from the outer boundary trace.
* **Endoderm_Area:** Isolated footprint of the inner metabolic gastrodermal tissue zone.
* **Intact_Droplet_Area:** Cumulative area of all localized particles classified below the 300-pixel threshold.
* **Consumed_Blob_Area:** Cumulative area of large, irregular, or fused vacuole spaces.
* **Total_Vacuole_Area:** Net space occupied by all detected lipid reserves within the sample tissue (Intact Droplet Area + Consumed Blob Area).
* **Consumption_Index:** A ratio indicating structural lipid consolidation or degradation:
  * *Formula:* Consumption Index = Consumed Blob Area / Total Vacuole Area
* **Vacuole_Percentage_Total:** The core physiological metric used to compare different color morphs or treatment groups. This represents the percentage of total larval cross-sectional tissue dedicated to lipid energy stores:
  * *Formula:* Vacuole Percentage Total (%) = (Total Vacuole Area / Total Body Area) * 100

### Quality Auditing
For every file processed, the script writes a corresponding [Filename]_Consumption_Proof.jpg file. Operators must review these proof files before uploading rows to the central lab database. If any proof file displays significant background tissue artifacts outlined in magenta, or shows that real lipid droplets were missed due to a restrictive threshold selection, that specific data row must be pruned from the CSV and re-run.

```macro
// =========================================================================
// 🎛️ CONTROL PANEL
// =========================================================================
var minDropletSize   = 5;
var blobSizeCutoff   = 300; // Increase this if lipids are misclassified as voids
var minCircularity   = 0.3;
var maxCircularity   = 1.00;
var blurRadius       = 1.5;
// =========================================================================
// 1. Setup: Directs the script to the folder with your raw OIR files and where to export CSVs.
macro "Batch Larvae Consumption Production v10.1" {
    inputDir = getDirectory("Select Folder Containing Larvae .oir Files");
    outputDir = getDirectory("Select Local Target Folder for Results");
    list = getFileList(inputDir);
    outputFile = outputDir + "Larvae_Consumption_Data_v10.1.csv";
    
// 2. CSV Initialization: Creates the CSV header file if it doesn't already exist.
    if (!File.exists(outputFile)) {
        File.saveString("File_Name,Total_Area,Endoderm_Area,Intact_Droplet_Area,Consumed_Blob_Area,Total_Vacuole_Area,Consumption_Index,Intact_Count,Blob_Count,Vacuole_Percentage_Total\n", outputFile);
    }
    
    setOption("BlackBackground", true);
// 3. Batch Loop: Cycles through every file in the directory.    
    for (i = 0; i < list.length; i++) {
    	// Only process files ending in .oir
        if (endsWith(list[i], ".oir") || endsWith(list[i], ".OIR")) {
            if (indexOf(File.openAsString(outputFile), list[i]) >= 0) continue; 
// 4. Import: Load the OIR file using the Bio-Formats library to preserve metadata.            
            run("Bio-Formats Importer", "open=[" + inputDir + list[i] + "] autoscale");
            mainTitle = getTitle(); 
            run("Split Channels");
            //Selecting Green channal for beter contrast
            selectWindow("C2-" + mainTitle); 
            rename("Working_Copy");
            close("\\Others");
// 5. Image Pre-processing: Convert to grayscale and apply Gaussian blur to prepare for segmentation.
            run("8-bit");
            

            setTool("polygon");
            waitForUser("Trace 1: Total Perimeter", "Trace outer perimeter.");
            run("Measure");
            totalArea = getResult("Area", 0);
            run("Clear Results");
            
            setTool("polygon");
            waitForUser("Trace 2: Endoderm", "Trace inner boundary.");
            run("Measure");
            endodermArea = getResult("Area", 0);
            run("Clear Results");
            
            // Masking background
            setBackgroundColor(0, 0, 0); 
            run("Clear Outside");
            
            roiManager("reset");
            roiManager("Add"); // Index 0: Endoderm
            run("Select None");
            
// 6. Thresholding (Manual adjustment gate)
            run("Duplicate...", "title=Base_Mask");
            run("Gaussian Blur...", "radius=" + blurRadius);
            
// 7.Force manual thresholding to solve "all red" background issues
            run("Threshold...");
            waitForUser("Verify Threshold", "Adjust slider so ONLY lipids/voids are red (and background is black), You may select diffrent threshold model (`Otsu` is recommended). DO NOT CLICK THE BUTTONS AT THE BOTTOM. Click OK to confirm.");
            run("Convert to Mask");
            
            run("Watershed");
            
// 8. Particle Analysis: Detects voids based on the size and circularity parameters set above.
            run("Set Measurements...", "area display");
            run("Analyze Particles...", "size=" + minDropletSize + "-Infinity circularity=" + minCircularity + "-" + maxCircularity + " display clear add");
            
            intactArea = 0; intactCount = 0;
            blobArea = 0; blobCount = 0;
            
// 9. Logic Loop: Categorizes results into 'Blobs' (irregular) or 'Droplets' (round).
            run("Clear Results");
            for (j = 0; j < roiManager("count"); j++) {
                roiManager("select", j);
                run("Measure");
                area = getResult("Area", nResults-1);
                
                if (area > blobSizeCutoff) {
                    blobArea += area;
                    blobCount++;
                    roiManager("Set Color", "magenta");
                    roiManager("Set Line Width", 3);
                    roiManager("Rename", "Void");
                } else {
                    intactArea += area;
                    intactCount++;
                    roiManager("Set Color", "cyan");
                    roiManager("Set Line Width", 1);
                    roiManager("Rename", "Drop");
                }
            }
            run("Clear Results");
            
// 10. Proof Generation: Saves a JPEG with ROI overlays to visually audit measurements.
            selectWindow("Working_Copy");
            roiManager("Show All without labels");
            run("Flatten");
            saveAs("Jpeg", outputDir + replace(list[i], ".oir", "_Consumption_Proof.jpg"));
            
// 11. Final Calculations: Computes the indices for export.
            totalVacuoleArea = intactArea + blobArea;
            
            consumptionIndex = 0;
            if (totalVacuoleArea > 0) {
                consumptionIndex = blobArea / totalVacuoleArea;
            }
            
            vacuolePercentTotal = 0;
            if (totalArea > 0) {
                vacuolePercentTotal = (totalVacuoleArea / totalArea) * 100;
            }
            
// 12. Logging: Appends all calculated metrics to the CSV file.
            File.append(list[i] + "," + totalArea + "," + endodermArea + "," + intactArea + "," + blobArea + "," + totalVacuoleArea + "," + consumptionIndex + "," + intactCount + "," + blobCount + "," + vacuolePercentTotal + "\n", outputFile);
            
// 13. Memory Cleanup: Resets ROIs and closes images to keep processing fast.
            roiManager("reset");
            run("Clear Results");
            run("Close All");
        }
    }
    showMessage("Success");
}
```

