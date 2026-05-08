// =================================================================================
// MASS LAB: CORAL PLANULAE MEASUREMENT & VOLUME CALCULATION MACRO WITH MORPH (HF vs NF)
// By: Liel Uziahu
// Version 1.4 (08/05/2026) (Fixed "Perim." Column Naming & Math Safeguards)
// =================================================================================

// --- 1. STARTUP CALIBRATION ---
Dialog.create("Microscope Calibration Setup");
Dialog.addMessage("Enter the scale for the current microscope/objective:");
Dialog.addNumber("Pixels per unit:", 0.2740); 
Dialog.addNumber("Known Distance:", 1);
Dialog.addChoice("Units:", newArray("um", "mm", "pixels"));
Dialog.show();

pixelDist = Dialog.getNumber();
knownDist = Dialog.getNumber();
unit = Dialog.getChoice();

// Create anchor image for global scale
newImage("temp", "8-bit black", 1, 1, 1);
run("Set Scale...", "distance=" + pixelDist + " known=" + knownDist + " unit=" + unit + " global");
close(); 

run("Set Measurements...", "area perimeter display redirect=None decimal=4");

// --- 2. FOLDER SELECTION ---
inputDir = getDirectory("STEP 1: Choose folder with your RAW images");
outputDir = getDirectory("STEP 2: Choose folder to save CSV and NUMBERED proofs");

list = getFileList(inputDir);
setBatchMode(false); 

run("Clear Results");
table = "Planulae_Final_Data";
if (isOpen(table)) { selectWindow(table); run("Close"); }
run("New... ", "name=["+table+"] type=Table");
print("["+table+"]", "\\Headings:sample no\tarea_um2\tperimeter_um\tarea_mm2\tperimeter_mm\tVolume_mm3\tmorph\tlabel\tfile name");

rowCount = 1;

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".jpg") || endsWith(list[i], ".tif") || endsWith(list[i], ".png") || endsWith(list[i], ".TIF") || endsWith(list[i], ".JPG")) {
        
        open(inputDir + list[i]);
        currentTitle = getTitle();
        if (isOpen("ROI Manager")) { selectWindow("ROI Manager"); roiManager("reset"); }
        else { run("ROI Manager..."); }
        
        morph = "Unknown";
        if (indexOf(currentTitle, "HF") >= 0) morph = "HF";
        else if (indexOf(currentTitle, "NF") >= 0) morph = "NF";

        setTool("freehand");
        waitForUser("IMAGE: " + currentTitle, "1. Trace a planula\n2. Press 't' to add\n3. Click OK ONLY when finished with ALL larvae in this photo");
        
        larvaCount = roiManager("count");
        
        if (larvaCount > 0) {
            roiManager("Show All with labels");
            run("Flatten"); 
            saveAs("Jpeg", outputDir + "Numbered_Proof_" + currentTitle);
            close(); 

            for (j = 0; j < larvaCount; j++) {
                roiManager("select", j);
                run("Measure"); 
                
                // --- THE CRITICAL FIX: Change "Perimeter" to "Perim." ---
                A = getResult("Area", nResults-1);
                P = getResult("Perim.", nResults-1); 
                
                // MATH: CAPSULE MODEL
                // We use a safeguard (abs) to ensure the square root doesn't fail on rough traces
                discriminant = pow(P, 2) - 4 * PI * A;
                if (discriminant < 0) discriminant = 0; 
                
                r = (P - sqrt(discriminant)) / (2 * PI);
                l = (P - 2 * PI * r) / 2;
                if (l < 0) l = 0; // Ensures length isn't negative for round larvae
                
                Vol_um3 = (PI * pow(r,2) * l) + (4.0/3.0 * PI * pow(r,3));
                
                // UNIT CONVERSIONS
                A_mm2 = A / 1000000;
                P_mm = P / 1000;
                Vol_mm3 = Vol_um3 / 1000000000;
                
                print("["+table+"]", rowCount + "\t" + A + "\t" + P + "\t" + A_mm2 + "\t" + P_mm + "\t" + Vol_mm3 + "\t" + morph + "\t" + j + "\t" + currentTitle);
                rowCount++;
            }
        }
        close(); 
    }
}

selectWindow(table);
saveAs("Text", outputDir + "Final_Planulae_Measurements.csv");
showMessage("Done!", "Check the CSV. Perimeter and Volume should now be filled!");