---
layout: post
title: Google Colab Standard Operating Procedure
category: [Code, AI, Protocol, Plottin ]
tags: [ Code, Planulae, AI tool, Plotting, Statistical Analysis ]
---

_LAB PROTOCOL — a practical guide for lab members using Google Colab (Python or R)._  
**Version:** Feb 3, 2026

This guide is written for everyone—whether you code in Python, R, or don't code at all. Please read this carefully to avoid losing your data.

> **Quick warning:** Colab sessions are temporary. Anything not saved to GitHub or downloaded can be lost when the session disconnects.

## Part 1 — The Concept (Read This First!)

### 1. 1. What is a "Jupyter Notebook"?
Colab uses a format called a <b>Jupyter Notebook.</b>

Think of it like a digital lab notebook: you combine <b>text</b> (notes) and <b>code</b> (analysis) in one document.

Why we use it: it keeps our science transparent—anyone can read the logic and see results immediately under the code.


### 2. Google Colab (The “digital lab bench”)
Colab runs on a Google-hosted <b>virtual machine (VM)</b>—you are not using your laptop’s CPU/RAM.

<b>Ephemeral rule:</b> the VM is temporary. When the session ends, files created/uploaded inside Colab can be deleted.

<b>Inactivity:</b> if you do not run code or interact for ~90 minutes, Colab may disconnect.

<b>Hard limit:</b> even with activity, sessions can end after ~12 hours.

Therefore: <b>save to GitHub</b> or <b>download</b> outputs before ending a session.


## Part 2 — Getting started & choosing your language

### Step A. Open the lab
Open Chrome (recommended) and go to <b>colab.research.google.com</b>.

Sign in with your Google account.

Start a new notebook: <b>New Notebook</b>.

Open an existing notebook from GitHub: choose the <b>GitHub</b> tab, paste the repository URL, and select the file.


### Step B. Python vs R (critical)
Colab defaults to <b>Python</b>.

If you need <b>R</b>: Runtime → Change runtime type → select <b>R</b> → Save.

Do not mix Python and R in the same notebook. Use one language per experiment.


### Step C. Get your data into Colab (Files pane)
Open the left sidebar → click the <b>folder</b> icon to open the Files pane.

Drag-and-drop your input files (CSV, Excel, images) into the Files pane.

Wait until upload finishes (the spinner/orange indicator disappears).

You can create temporary folders during a session for organization and download them at the end.


### Packages and hardware
Install missing packages with pip (Python):


```bash
!pip install -q <package_name>  # -q = quiet install
```
For heavy computation: Edit → Notebook settings → select <b>GPU</b> or <b>TPU</b> (if available).


## Part 3 — Writing your notebook (the “Sandwich” rule)

### The goal: no “walls of code”.
Use this structure for each analysis block:

Top bun (text): plain-language explanation.

Meat (code): the actual script.

Bottom bun (result): plots/tables output.


### How to add a text cell
Hover between cells → click <b>+ Text</b> → describe what you are doing.

Use headers (Markdown) like <b># Experiment 1: Heat Stress Analysis</b>.


## Part 4 — GitHub integration (the safety net)

### One-time setup
File → <b>Save a copy in GitHub</b>.

Grant permissions.

Check the option <b>“Access private repositories and organizations”</b> if you work in private repos/orgs.


### Daily routine (how to save)
File → <b>Save a copy in GitHub</b>.

Choose the repository.

Write a clear commit message (e.g., “Added pH data”).

Click OK.


### Open later
In GitHub, open your <b>.ipynb</b> notebook and click <b>Open in Colab</b> (badge/link).


## Part 5 — AI “cheat sheet” (Gemini)

### Use built‑in AI to accelerate, not replace, understanding.
Generate code: use the sparkle/Generate icon or Ctrl/Cmd + I and describe the task (e.g., “Read a CSV and filter null controls”).

Fix errors: use <b>Explain error</b> to interpret tracebacks and suggest fixes.

Improve readability: ask it to add docstrings and comments.


## Part 6 — Statistical analysis

### Reproducible stats over manual Excel
Always check missing values and dtypes before testing.

Common tools:

• Descriptive: <b>df.describe()</b>

• Hypothesis tests: <b>scipy.stats</b> (t‑tests, ANOVA, non‑parametric)

• Modeling: <b>statsmodels</b> (linear/multivariate regression)

Verify assumptions (normality, homogeneity of variance, etc.) before reporting p‑values.


## Part 7 — Figures & downloads (critical)

### Publication-quality figures
Target: <b>600 DPI</b> (typical journal requirement).

Python template:


```python
import matplotlib.pyplot as plt

# --- PLOTTING CODE ---
plt.plot(x, y)
# ---------------------

# Save high‑resolution figure
plt.savefig('Final_Fig.pdf', dpi=600, bbox_inches='tight')

# Download to your computer
from google.colab import files
files.download('Final_Fig.pdf')
```
R template (manual download from the Files pane):


```python
library(ggplot2)

# --- PLOTTING CODE ---

ggsave('Final_Fig.pdf', dpi=600)
```

### Manual download backup
If the file does not pop up automatically:

Files pane → right‑click the file → <b>Download</b>.


## Part 8 — End-of-shift checklist

### Do not close the tab until all are true:
☐ Saved notebook to GitHub (File → Save a copy in GitHub).

☐ Downloaded outputs (check your computer’s Downloads folder).

☐ Notebook is readable (text cells explain the math/logic).

☐ Figures are high‑res (600 DPI).


## End-of-shift checklist
- Saved notebook to GitHub (File → Save a copy in GitHub).
- Downloaded outputs (check your computer’s Downloads folder).
- Notebook is readable (text cells explain the math/logic).
- Figures are high‑res (600 DPI).
