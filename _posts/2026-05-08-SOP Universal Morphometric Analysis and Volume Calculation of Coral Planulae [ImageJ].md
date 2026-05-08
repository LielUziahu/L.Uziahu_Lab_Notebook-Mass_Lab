---
layout: post
title: "SOP: Universal Morphometric Analysis and Volume Calculation of Coral Planulae."
date: 2026-05-07
categories: morphometrics
---
 
**Equipment:** Fiji (ImageJ)  
**Model:** Spherocylinder (Capsule) Geometric Model  
**Version:** May 7, 2026


### SOP: Universal Morphometric Analysis and Volume Calculation of Coral Planulae.
**Equipment:** Fiji (ImageJ)  
**Model:** Spherocylinder (Capsule) Geometric Model  
**Version:** May 7, 2026

### Part 1: Pre-Analysis Calibration (The Pixel Ratio)

Before running the macro, you must determine the specific **Pixel Ratio** for your microscope and zoom settings. If you change the magnification, you must recalibrate.

1.  **Capture a Scale:** Place a **Stage Micrometer** (microscope ruler) under the lens. Take a photo at the **exact same zoom level** as your larvae.
2.  **Open in Fiji:** Drag the ruler photo into Fiji.
3.  **Draw a Known Line:** Select the **Straight Line Tool** from the toolbar. Draw a line across a distance you know (e.g., 1 mm or 500 µm).
4.  **Analyze Scale:** Go to **Analyze > Set Scale...**
    * **Distance in pixels:** Fiji fills this automatically based on your line.
    * **Known distance:** Enter the value (e.g., `1000` for 1 mm).
    * **Unit of length:** `um`.
5.  **Identify the Ratio:** Look at the bottom line where it says **"Scale: 0.XXXX pixels/um"**.  
    * *Write this number down (e.g., 0.2740). This is your "Magic Number."*

---

## Part 2: Preparing Your Workspace

1.  **Work Locally:** Never run analysis directly from a Shared Network Drive (H:). Copy your images to your **Local C: Drive** (e.g., `C:\Larvae_Project`).
2.  **Organize Folders:** Create two sub-folders:
    * `1_Raw_Images`: Place your original photos here.
    * `2_Results`: Keep this empty. The macro will fill it with your CSV and proof images.

---

## Part 3: Setting Up and Running the Macro

1.  Open **Fiji**.
2.  Go to **Plugins > New > Macro**.
3.  **Copy and Paste** the code provided at the end of this document into the macro window.
4.  Click **Run**.

### The Setup Popup:
* **Pixels per unit:** Enter your "Magic Number" from Part 1.
* **Selection Tool:** * **Freehand:** Best for curved/flexed larvae. You click and hold to draw in one smooth motion.
    * **Polygon:** Best for small or straight larvae. You click point-by-point to outline the shape.

---

## Part 4: The Tracing Workflow (Interactive Loop)

Once you select your `Raw` and `Results` folders, the first image will open automatically.

1.  **Zoom In:** Press the **`+`** key so the larva fills the screen.
2.  **Trace:** Carefully outline the edge of the planula using your chosen tool.
3.  **The "T" Key:** As soon as you finish the outline, press **`t`** on your keyboard. 
    * The outline will turn yellow, and a number (**0, 1, 2...**) will appear on the larva.
4.  **Repeat:** Repeat for every planula visible in that photo.
5.  **Finish Photo:** Click **OK** on the Fiji message box **ONLY** when every planula in that photo has a number.
6.  **Auto-Processing:** The macro will instantly:
    * Save a "Proof" image with your traces and numbers.
    * Calculate Volume based on the Capsule Model.
    * Open the next photo automatically.

---

## Part 5: Understanding the Outputs

###  1. Numbered Proofs (`Numbered_Proof_...jpg`)
These are your primary evidence for peer review.
* They show exactly what you traced.
* The numbers match the **Label** column in your CSV.
* If a reviewer questions an outlier, you can point to the specific larva in the proof.

###  2. The Final CSV (`Universal_Planulae_Measurements.csv`)
Open this in Excel. The macro has automatically calculated:
* **`area_um2` / `perimeter_um`**: Raw morphometrics.
* **`Volume_mm3`**: Final volume derived analytically to account for larval bending.
* **`label`**: The ID number matching the proof photo.
* **`file name`**: The source file

---

## The Macro Code (Copy-Paste)

``` javascript
// =================================================================================
// MASS LAB: UNIVERSAL PLANULAE MEASUREMENT & VOLUME CALCULATION MACRO
// By: Liel Uziahu
// Version 1.5 (Universal Use) (08/05/2026)
// =================================================================================

// --- 1. STARTUP CALIBRATION (Dummy Proofing) ---
Dialog.create("Universal Calibration Setup");
Dialog.addMessage("Enter the scale for the current microscope/objective:");
Dialog.addNumber("Pixels per unit:", 0.2740); 
Dialog.addNumber("Known Distance:", 1);
Dialog.addChoice("Units:", newArray("um", "mm", "pixels"));
Dialog.addMessage("--------------------------------------------------");
Dialog.show();

pixelDist = Dialog.getNumber();
knownDist = Dialog.getNumber();
unit = Dialog.getChoice();

// Create anchor image to apply the scale globally
newImage("temp", "8-bit black", 1, 1, 1);
run("Set Scale...", "distance=" + pixelDist + " known=" + knownDist + " unit=" + unit + " global");
close(); 

// Set Required Measurements
run("Set Measurements...", "area perimeter display redirect=None decimal=4");

// --- 2. FOLDER SELECTION ---
inputDir = getDirectory("STEP 1: Choose folder with your RAW images");
outputDir = getDirectory("STEP 2: Choose folder to save CSV and NUMBERED proofs");

list = getFileList(inputDir);
setBatchMode(false); 

// Clear results and initialize the Universal Table
run("Clear Results");
table = "Universal_Planulae_Data";
if (isOpen(table)) { selectWindow(table); run("Close"); }
run("New... ", "name=["+table+"] type=Table");
print("["+table+"]", "\\Headings:sample no\tarea_um2\tperimeter_um\tarea_mm2\tperimeter_mm\tVolume_mm3\tlabel\tfile name");

rowCount = 1;

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".jpg") || endsWith(list[i], ".tif") || endsWith(list[i], ".png") || endsWith(list[i], ".TIF") || endsWith(list[i], ".JPG")) {
        
        open(inputDir + list[i]);
        currentTitle = getTitle();
        
        // Reset ROI Manager
        if (isOpen("ROI Manager")) { selectWindow("ROI Manager"); roiManager("reset"); }
        else { run("ROI Manager..."); }

        // --- 3. INTERACTIVE TRACING ---
        setTool("freehand");
        waitForUser("IMAGE: " + currentTitle, "1. Trace a planula\n2. Press 't' to add\n3. Repeat for ALL planulae\n4. Click OK ONLY when finished with THIS photo");
        
        larvaCount = roiManager("count");
        
        if (larvaCount > 0) {
            // --- 4. SAVE NUMBERED PROOF ---
            roiManager("Show All with labels");
            run("Flatten"); 
            saveAs("Jpeg", outputDir + "Numbered_Proof_" + currentTitle);
            close(); 

            // --- 5. CALCULATE & RECORD ---
            for (j = 0; j < larvaCount; j++) {
                roiManager("select", j);
                run("Measure"); 
                
                A = getResult("Area", nResults-1);
                P = getResult("Perim.", nResults-1); 
                
                // MATH: CAPSULE MODEL (Microns)
                discriminant = pow(P, 2) - 4 * PI * A;
                if (discriminant < 0) discriminant = 0; 
                
                r = (P - sqrt(discriminant)) / (2 * PI);
                l = (P - 2 * PI * r) / 2;
                if (l < 0) l = 0; 
                
                Vol_um3 = (PI * pow(r,2) * l) + (4.0/3.0 * PI * pow(r,3));
                
                // UNIT CONVERSIONS
                A_mm2 = A / 1000000;
                P_mm = P / 1000;
                Vol_mm3 = Vol_um3 / 1000000000;
                
                // Print to the final universal table
                print("["+table+"]", rowCount + "\t" + A + "\t" + P + "\t" + A_mm2 + "\t" + P_mm + "\t" + Vol_mm3 + "\t" + j + "\t" + currentTitle);
                rowCount++;
            }
        }
        close(); 
    }
}

// --- 6. FINAL EXPORT ---
selectWindow(table);
saveAs("Text", outputDir + "Universal_Planulae_Measurements.csv");
showMessage("Task Complete", "Results Saved to: " + outputDir);
```