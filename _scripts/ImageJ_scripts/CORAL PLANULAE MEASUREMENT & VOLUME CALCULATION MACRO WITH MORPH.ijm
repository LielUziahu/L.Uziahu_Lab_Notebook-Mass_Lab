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