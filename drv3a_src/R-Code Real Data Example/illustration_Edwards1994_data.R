## This code is free software: you can redistribute it and/or modify

## it under the terms of the GNU General Public License as published by

## the Free Software Foundation, either version 2 of the License, or

## (at your option) any later version.

## 

## For a copy of the GNU General Public License, 

## see <http://www.gnu.org/licenses/>.



## (c) 2020 Sarah Humberg



## This source code accompanies the paper "Cubic Response Surface Analysis: Investigating Asymmetric and Level-Dependent Congruence Effects With Third-Order Polynomial Models".





# ----------------------------------------------------------------------------

# Get data and load RSA package

# ----------------------------------------------------------------------------



## before you can run this code, you need to download the data file from Jeffrey R. Edwards' website: 

# 1. go to: http://public.kenan-flagler.unc.edu/faculty/edwardsj/downloads.htm

# 2. download "Files to reproduce analyses in Edwards (1994, The study of congruence in organizational behavior research: Critique and a proposed alternative)"

# 3. unpack the downloaded zip-folder "EDWARDS1994"

# 4. open the file "mba.xls" in Excel 

# (5. in case you can't leave the protected view, copy + paste all cells into a new excel file)

# 6. save the file as a csv-file with delimiter a semicolon ";", with file name "mba_csv.csv"

# 7. copy + paste the csv-file "mba_csv.csv" into the folder where you store this R-code.




## read data

# install.packages("readr")

library(readr)

edw_data <- read_csv2("mba_csv.csv")




## load the package RSA, required for estimation of the RSA models

# install.packages("RSA")

library(RSA)




# ----------------------------------------------------------------------------

# Data preparation and Pre-analyses

# ----------------------------------------------------------------------------



## we use the following variables from the dataset:

# MRACT = actual amount of the "motivating/rewarding" attribute (the variable in the dataset is scale-centered)

# MRPRE = preferred amount of the "motivating/rewarding" attribute (the variable in the dataset is scale-centered)

# MRSAT = satisfaction with the "motivating/rewarding" attribute




## Reverse the scale centering of MRACT and MRPRE to get the participants' original scores

edw_data$MRACT <- edw_data$MRACT + 20

edw_data$MRPRE <- edw_data$MRPRE + 20




## Are there discrepant predictor combinations in either direction?

diff_edw <- (edw_data$MRACT - edw_data$MRPRE)/sd(c(edw_data$MRACT, edw_data$MRPRE), na.rm=TRUE)

cong_edw <- cut(diff_edw, breaks=c(-Inf, -.5, .5, Inf), labels=c(paste0("MRACT", " < ", "MRPRE"), "Congruence", paste0("MRACT", " > ", "MRPRE")))

congtab_edw <- round(prop.table(table(cong_edw)), 2)*100

print(congtab_edw)




## Check: estimate the full second-order model (to reproduce results reported in Edwards, 1994, Table 6)

rsa_full <- RSA(MRSAT ~ MRACT*MRPRE, data=edw_data, model=c("full"), missing="fiml", out.rm=TRUE)

summary(rsa_full)

plot(rsa_full)




# grand mean center the predictors

gm <- mean(c(edw_data$MRACT,edw_data$MRPRE), na.rm=T)

edw_data$MRACT.c <- edw_data$MRACT - gm

edw_data$MRPRE.c <- edw_data$MRPRE - gm





# ----------------------------------------------------------------------------

# Analysis: Explore the data in terms of a rising ridge asymmetric congruence effect

# ----------------------------------------------------------------------------



## estimate the rising ridge asymmetric congruence model (RRCA) and the full third-order model (cubic)

edw_rsa <- RSA(MRSAT ~ MRACT.c*MRPRE.c, data=edw_data, model=c("RRCA","cubic"), missing="fiml", out.rm=TRUE)





# Step 1



# compare the rising ridge asymmetric congruence model (RRCA) and the full third-order model (cubic)

edw_comp <- compare2(edw_rsa, "RRCA", "cubic")

edw_comp





## Step 2



# inspect the estimated coefficients

edw_coef <- getPar(edw_rsa, model="RRCA")



# test c1 (= b3 in the output) against zero to test the congruence effect

edw_coef[edw_coef$label == "b3", c("label","est","se","pvalue")]



# test c2 (= b6 in the output) against zero to test the asymmetry effect

edw_coef[edw_coef$label == "b6", c("label","est","se","pvalue")]



# test u1 = b1 + b2 to test the linear level effect

edw_coef[edw_coef$label == "u1", c("label","est","se","pvalue")]



# find out how many data points behind the second extremum line E2 have a significantly higher outcome prediction than the respective same-level point on E2

edw_rangecheck <- caRange(edw_rsa, model="RRCA", alpha = 0.01, alphacorrection="Bonferroni")



# How many percent of the data lies behind E2?

edw_rangecheck$percentage.behind



# -> There are no data points behind E2.




## Plot the rising ridge asymmetric congruence model (including the second extremum line E2)

plot(edw_rsa, model="RRCA", axes=c("LOC","LOIC","E2"), project=c("LOC","LOIC","E2"), points = list(value="predicted"), 
     xlab="Actual amount", ylab="Preferred amount", zlab="Satisfaction")




## How much variance in the outcome can be explained by the full third-order polynomial model/the rising ridge asymmetric congruence model? 

getPar(edw_rsa, model="cubic", type="R2")

getPar(edw_rsa, model="RRCA", type="R2")


