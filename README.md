# BioStats-Automated_NonParametric_Analysis_R-Studio-Pipeline
BioStats = Automated_NonParametric_Analysis_R Studio Pipeline
# 📉 Automated Non-Parametric Statistical Analysis Pipeline (R)

This R script provides a robust and automated pipeline for executing common **non-parametric statistical tests** and the **Chi-Square test** for association. These tests are vital when the assumptions for parametric methods (like normality or homogeneity of variances) are violated, or when dealing with ordinal or nominal data.

The script uses the built-in `mtcars` dataset and a simulated dataset for a comprehensive demonstration.

## 🚀 Key Features

* **Five Core Non-Parametric Tests:** Includes structured sections for non-parametric equivalents of $t$-tests and ANOVA, plus the Chi-Square test.
* **Wilcoxon Suite:** Covers **One-Sample**, **Paired**, and **Independent Samples** (Mann-Whitney U) Wilcoxon tests.
* **Non-Parametric ANOVA:** Implements the **Kruskal-Wallis Test** for comparing more than two independent groups.
* **Categorical Association:** Includes the **Chi-Square Test** for assessing the relationship between two categorical variables (`cyl` and `am`).
* **Automated Visualization:** Generates relevant PNG plots (Histograms, Boxplots, and Bar Plots) to visually support the findings of each test.
* **Comprehensive Logging:** All statistical output, contingency tables, test results, and file save information are automatically logged to a text file for full traceability and reproducibility.

## 📁 Output Structure

All generated files are saved to the defined `output_path` (default: `D:/DOWNLOADS`).

| Filename | Type | Description |
| :--- | :--- | :--- |
| `NonParametric_Results_Log.txt` | Text Log | Detailed output of all five statistical tests and intermediate messages. |
| `mtcars_cleaned.csv` | CSV | The processed `mtcars` data used for analysis (with the `am` variable factored). |
| `paired_data.csv` | CSV | The simulated 'before' and 'after' data used for the Paired Wilcoxon test. |
| `chisq_contingency_table.csv` | CSV | The contingency table used for the Chi-Square test. |
| `1_OneSample_Wilcoxon_Hist.png` | PNG Image | Histogram of MPG, visualizing the distribution against the median null hypothesis ($\text{median}=20$). |
| `2_Paired_Wilcoxon_Boxplot.png` | PNG Image | Boxplot comparing the simulated 'Before' vs. 'After' weight data. |
| `3_MannWhitney_Boxplot.png` | PNG Image | Boxplot comparing MPG distributions for Automatic vs. Manual transmission. |
| `4_KruskalWallis_Boxplot.png` | PNG Image | Boxplot comparing MPG distributions across different levels of Cylinder count (`cyl`). |
| `5_ChiSquare_Barplot.png` | PNG Image | Stacked Bar Plot visualizing the count breakdown of Cylinders by Transmission. |

## ⚙️ How to Run the Script

1.  **Download** the `Automated_NonParametric_Analysis_Pipeline.R` file.
2.  **Optional:** Modify the `output_path` variable at the beginning of the script to your desired saving location.
    ```R
    output_path <- "D:/DOWNLOADS" # Change this path
    ```
3.  **Execute** the script in your R environment (RStudio or R console):
    ```R
    source("Automated_NonParametric_Analysis_Pipeline.R")
    ```
4.  **Check** the specified output directory for the log file, data, and five visualization images.

## 🔬 Statistical Tests Overview

| Part | Test Performed | Parametric Equivalent | Variables | Null Hypothesis ($\text{H}_0$) |
| :--- | :--- | :--- | :--- | :--- |
| **Part 2** | Wilcoxon Signed Rank (One-Sample) | One-sample $t$-test | `mpg` | The population median of MPG is equal to 20. |
| **Part 3** | Wilcoxon Signed Rank (Paired) | Paired $t$-test | `before` vs. `after` (Simulated) | The median difference between the paired measurements is zero. |
| **Part 4** | Mann-Whitney U Test | Independent $t$-test | `mpg` vs. `am` (Transmission) | The distribution of MPG is the same in both transmission groups. |
| **Part 5** | Kruskal-Wallis Test | One-way ANOVA | `mpg` vs. `cyl` (Cylinders) | All cylinder groups have the same median (or distribution). |
| **Part 6** | Chi-Square Test | N/A | `cyl` vs. `am` | There is no association between the number of cylinders and the transmission type. |

---
*Created by the Automated Non-Parametric Analysis Pipeline using R.*
