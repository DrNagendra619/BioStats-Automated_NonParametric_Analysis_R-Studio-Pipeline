# ==============================================================================
# FILE NAME: Automated_NonParametric_Analysis_Pipeline.R
# PURPOSE: Automated Non-Parametric Statistical Testing & Visualization
# OUTPUT PATH: D:/DOWNLOADS
# ==============================================================================

# ------------------------------------------------------------------------------
# SETUP: Define Output Path & Logging
# ------------------------------------------------------------------------------
# Define the path where files will be saved
output_path <- "D:/DOWNLOADS"

# Check if directory exists, if not, create it
if(!dir.exists(output_path)){
  dir.create(output_path)
  message("Created directory: ", output_path)
}

# Set working directory
setwd(output_path)

# Start recording all console output to a text file
sink(file = "NonParametric_Results_Log.txt", split = TRUE)

print(paste("Analysis started at:", Sys.time()))
print(paste("Script Name: Automated_NonParametric_Analysis_Pipeline.R"))
print(paste("Saving all outputs to:", output_path))


# ------------------------------------------------------------------------------
# PART 1: Data Loading & Preparation
# ------------------------------------------------------------------------------
print("--- Loading Data ---")
data(mtcars) 

# Convert 'am' variable to factor (0 = automatic, 1 = manual) 
mtcars$am <- factor(mtcars$am, labels=c("Automatic","Manual"))

# Save the modified dataset for reference
write.csv(mtcars, "mtcars_cleaned.csv")
print("Saved: mtcars_cleaned.csv")


# ------------------------------------------------------------------------------
# PART 2: Wilcoxon Signed Rank Test (One-Sample)
# ------------------------------------------------------------------------------
print("------------------------------------------------")
print("2. Wilcoxon Signed Rank Test (One-Sample)")
print("HO: median(mpg) = 20 | H1: median(mpg) != 20")
print("------------------------------------------------")

# Run Test
print(wilcox.test(mtcars$mpg, mu=20))

# Visualization: Histogram with target line
png(filename = "1_OneSample_Wilcoxon_Hist.png", width=800, height=600)
hist(mtcars$mpg, main="Histogram of MPG (Test mu=20)", xlab="MPG", col="lightblue", border="white")
abline(v=20, col="red", lwd=3, lty=2)
legend("topright", legend="Null Hypothesis (20)", col="red", lty=2, lwd=3)
dev.off()
print("Saved: 1_OneSample_Wilcoxon_Hist.png")


# ------------------------------------------------------------------------------
# PART 3: Wilcoxon Signed Rank Test (Paired Data)
# ------------------------------------------------------------------------------
print("------------------------------------------------")
print("3. Wilcoxon Signed Rank Test (Paired Data)")
print("HO: median difference = 0 | H1: median difference != 0")
print("------------------------------------------------")

# Create Dataset
before <- c(72, 75, 78, 70, 69) 
after <- c(68, 70, 72, 67, 66)

# Save this small dataset
paired_df <- data.frame(Before=before, After=after)
write.csv(paired_df, "paired_data.csv", row.names=FALSE)

# Run Test
print(wilcox.test(before, after, paired=TRUE))

# Visualization: Boxplot of changes
png(filename = "2_Paired_Wilcoxon_Boxplot.png", width=800, height=600)
boxplot(before, after, names=c("Before", "After"), 
        col=c("salmon", "lightgreen"),
        main="Effect of Training Program (Paired Data)", ylab="Weight")
dev.off()
print("Saved: 2_Paired_Wilcoxon_Boxplot.png")


# ------------------------------------------------------------------------------
# PART 4: Mann-Whitney U Test (Two-Independent Samples)
# ------------------------------------------------------------------------------
print("------------------------------------------------")
print("4. Mann-Whitney U Test (MPG by Transmission)")
print("HO: Distributions are same | H1: Distributions differ")
print("------------------------------------------------")

# Run Test
print(wilcox.test(mpg ~ am, data=mtcars))

# Visualization: Boxplot
png(filename = "3_MannWhitney_Boxplot.png", width=800, height=600)
boxplot(mpg ~ am, data=mtcars, 
        col=c("orange", "skyblue"),
        main="Mann-Whitney U Test: MPG by Transmission", 
        ylab="Miles Per Gallon", xlab="Transmission")
dev.off()
print("Saved: 3_MannWhitney_Boxplot.png")


# ------------------------------------------------------------------------------
# PART 5: Kruskal-Wallis Test (Non-Parametric ANOVA)
# ------------------------------------------------------------------------------
print("------------------------------------------------")
print("5. Kruskal-Wallis Test (MPG by Cylinders)")
print("HO: All groups have same distribution")
print("------------------------------------------------")

# Run Test
print(kruskal.test(mpg ~ factor(cyl), data=mtcars))

# Visualization: Boxplot
png(filename = "4_KruskalWallis_Boxplot.png", width=800, height=600)
boxplot(mpg ~ factor(cyl), data=mtcars, 
        col=c("lightgray", "grey", "darkgrey"),
        main="Kruskal-Wallis: MPG by Cylinders", 
        xlab="Number of Cylinders", ylab="MPG")
dev.off()
print("Saved: 4_KruskalWallis_Boxplot.png")


# ------------------------------------------------------------------------------
# PART 6: Chi-Square Test (Categorical Association)
# ------------------------------------------------------------------------------
print("------------------------------------------------")
print("6. Chi-Square Test (Cylinders vs Transmission)")
print("HO: No association | H1: Association exists")
print("------------------------------------------------")

# Create Contingency Table
tbl <- table(mtcars$cyl, mtcars$am) 
print("--- Contingency Table ---")
print(tbl)

# Save Table
write.csv(tbl, "chisq_contingency_table.csv")

# Run Test
print(chisq.test(tbl)) 

# Visualization: Stacked Bar Plot
png(filename = "5_ChiSquare_Barplot.png", width=800, height=600)
barplot(tbl, beside=TRUE, legend=TRUE, 
        col=c("red", "blue", "green"),
        main="Chi-Square: Cylinders by Transmission",
        xlab="Transmission", ylab="Count",
        args.legend = list(title = "Cylinders"))
dev.off()
print("Saved: 5_ChiSquare_Barplot.png")


# ------------------------------------------------------------------------------
# TEARDOWN
# ------------------------------------------------------------------------------
# Stop logging
sink()
message("------------------------------------------------")
message("Analysis Complete.")
message("Please check D:/DOWNLOADS for:")
message("1. NonParametric_Results_Log.txt")
message("2. CSV Data Files")
message("3. PNG Visualization Files")
message("------------------------------------------------")
