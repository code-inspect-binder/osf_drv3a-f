## This code is free software: you can redistribute it and/or modify

## it under the terms of the GNU General Public License as published by

## the Free Software Foundation, either version 2 of the License, or

## (at your option) any later version.

## 

## For a copy of the GNU General Public License, 

## see <http://www.gnu.org/licenses/>.



## (c) 2020 Sarah Humberg 



## This source code accompanies the paper "Cubic Response Surface Analysis: Investigating Asymmetric and Level-Dependent Congruence Effects With Third-Order Polynomial Models".







## load the package RSA, required for estimation of the RSA models

# install.packages("RSA")

library(RSA)




# ----------------------------------------------------------------------------

# CA - Example code for investigating the strict asymmetric congruence hypothesis

# ----------------------------------------------------------------------------



## load simulated data

ca_data <- read.table("illustration_data_ca.txt", sep="\t", header=TRUE)





## data preparation



# 1. Are there discrepant predictor combinations in either direction?

diff_ca <- (ca_data$X - ca_data$Y)/sd(c(ca_data$X, ca_data$Y), na.rm=TRUE)

cong_ca <- cut(diff_ca, breaks=c(-Inf, -.5, .5, Inf), labels=c(paste0("X", " < ", "Y"), "Congruence", paste0("X", " > ", "Y")))

congtab_ca <- round(prop.table(table(cong_ca)), 2)*100

print(congtab_ca)




# grand mean center the predictors

gm_ca <- mean(c(ca_data$X,ca_data$Y), na.rm=T)

ca_data$X <- ca_data$X - gm_ca

ca_data$Y <- ca_data$Y - gm_ca




# standardization (optional; might make sense to consider in cases where the ranges of the predictors and the outcome variable differ a lot)


# standardize the predictors at their grand sd 

gsd_ca <- sd(c(ca_data$X,ca_data$Y), na.rm=T)

ca_data$X <- ca_data$X / gsd_ca

ca_data$Y <- ca_data$Y / gsd_ca


# standardize the outcome variable

ca_data$Z <- ca_data$Z / sd(ca_data$Z, na.rm=T)




## estimate the strict asymmetric congruence model (CA) and the full third-order model (cubic)

ca_myrsa <- RSA(Z ~ X*Y, data=ca_data, model=c("CA","cubic"), missing="fiml", out.rm=TRUE)





## Step 1



# compare the strict asymmetric congruence model (CA) and the full third-order model (cubic)

ca_comp <- compare2(ca_myrsa, "CA", "cubic")

ca_comp





## Step 2



# inspect the estimated coefficients

ca_coef <- getPar(ca_myrsa, model="CA")



# test c1 (= b3 in the output) against zero to test the suggested congruence effect

ca_coef[ca_coef$label == "b3", c("label","est","se","pvalue")]



# test c2 (= b6 in the output) against zero to test the suggested asymmetry effect

ca_coef[ca_coef$label == "b6", c("label","est","se","pvalue")]



# find out how many data points behind the second extremum line E2 have a significantly higher outcome prediction than the points on E2

ca_rangecheck <- caRange(ca_myrsa, alpha = 0.01, alphacorrection="Bonferroni")



# How many percent of the data lies behind E2?

ca_rangecheck$percentage.behind



# What is the position of the intersection point (xr,yr) of the LOIC and E2?

ca_rangecheck$reversion_point_xy



# What is the predicted outcome value zr at the point (xr,yr)?

ca_rangecheck$reversion_point_z



# What is the one-sided confidence interval of zr?

ca_rangecheck$reversion_point_z_ci



# How many percent of the data points that lie behind E2 have an outcome prediction outside of the confidence interval of zr?

ca_rangecheck$percentage_bad_points





## Plot the strict asymmetric congruence model (including the second extremum line E2)

plot(ca_myrsa, model="CA", axes=c("LOC","LOIC","E2"), project=c("LOC","LOIC","E2"), 
     points = list(value="predicted"), legend=F, 
     xlab="Self-rated \n intelligence x", ylab="Friend-rated \n intelligence y", zlab="Interaction harmony z")




## How much variance in the outcome can be explained by the full third-order polynomial model/the strict asymmetric congruence model? 

getPar(ca_myrsa, model="cubic", type="R2")

getPar(ca_myrsa, model="CA", type="R2")





# ----------------------------------------------------------------------------

# RRCA - Example code for investigating the rising ridge asymmetric congruence hypothesis

# ----------------------------------------------------------------------------



## estimate the rising ridge asymmetric congruence model (RRCA) and the full third-order model (cubic)

rrca_myrsa <- RSA(Z ~ X*Y, data=ca_data, model=c("RRCA","cubic"), missing="fiml", out.rm=TRUE)





# Step 1



# compare the rising ridge asymmetric congruence model (RRCA) and the full third-order model (cubic)

rrca_comp <- compare2(rrca_myrsa, "RRCA", "cubic")

rrca_comp





## Step 2



# inspect the estimated coefficients

rrca_coef <- getPar(rrca_myrsa, model="RRCA")



# test c1 (= b3 in the output) against zero to test the suggested congruence effect

rrca_coef[rrca_coef$label == "b3", c("label","est","se","pvalue")]



# test c2 (= b6 in the output) against zero to test the suggested asymmetry effect

rrca_coef[rrca_coef$label == "b6", c("label","est","se","pvalue")]



# test u1 = b1 + b2 to test the suggested linear level effect (NOT significant in this example data)

rrca_coef[rrca_coef$label == "u1", c("label","est","se","pvalue")]



# find out how many data points behind the second extremum line E2 have a significantly higher outcome prediction than the respective same-level point on E2

rrca_rangecheck <- caRange(rrca_myrsa, model="RRCA", alpha = 0.01, alphacorrection="Bonferroni")



# How many percent of the data lies behind E2?

rrca_rangecheck$percentage.behind



# How many percent of the data points that lie behind E2 have an outcome prediction that significantly differs from the outcome prediction of the same-level point on E2?

rrca_rangecheck$percentage_bad_points



## Plot the rising ridge asymmetric congruence model (including the second extremum line E2)

plot(rrca_myrsa, model="RRCA", axes=c("LOC","LOIC","E2"), project=c("LOC","LOIC","E2"), points = list(value="predicted"))





## How much variance in the outcome can be explained by the full third-order polynomial model/the rising ridge asymmetric congruence model? 

getPar(rrca_myrsa, model="cubic", type="R2")

getPar(rrca_myrsa, model="RRCA", type="R2")





# ----------------------------------------------------------------------------

# CL - Example code for investigating the strict level-dependent congruence hypothesis

# ----------------------------------------------------------------------------



## load simulated data

cl_data <- read.table("illustration_data_cl.txt", sep="\t", header=TRUE)





## data preparation



# 1. Are there discrepant predictor combinations in either direction?

diff_cl <- (cl_data$X - cl_data$Y)/sd(c(cl_data$X, cl_data$Y), na.rm=TRUE)

cong_cl <- cut(diff_cl, breaks=c(-Inf, -.5, .5, Inf), labels=c(paste0("X", " < ", "Y"), "Congruence", paste0("X", " > ", "Y")))

congtab_cl <- round(prop.table(table(cong_cl)), 2)*100

print(congtab_cl)




# grand mean center the predictors

gm_cl <- mean(c(cl_data$X,cl_data$Y), na.rm=T)

cl_data$X <- cl_data$X - gm_cl

cl_data$Y <- cl_data$Y - gm_cl




## estimate the level-dependent congruence model (CL) and the full third-order model (cubic)

cl_myrsa <- RSA(Z ~ X*Y, data=cl_data, model=c("CL","cubic"), missing="fiml", out.rm=TRUE)





## Step 1



# compare the level-dependent congruence model (CL) and the full third-order model (cubic)

cl_comp <- compare2(cl_myrsa, "CL", "cubic")

cl_comp





## Step 2



# inspect the estimated coefficients

cl_coef <- getPar(cl_myrsa, model="CL")



# test c3 (= b6 in the output) against zero to test the suggested level-dependancy effect

cl_coef[cl_coef$label == "b6", c("label","est","se","pvalue")]



# compute the regions of (negative, non-, positive) significance and their intersections with the data

cl_rangecheck <- clRange(cl_myrsa, model="CL", alpha = 0.01)



# the variable "percent_data" in the following table informs how many percent of the data points lie in the respective regions

cl_rangecheck$regions





## Plot the strict level-dependent congruence model (including the lines gk1 and gk2 where the significance status of the curvature changes)

plot(cl_myrsa, model="CL", axes=c("LOC","LOIC","K1","K2"), project=c("LOC","LOIC","K1","K2"), 
     claxes.alpha=0.01, points = list(value="predicted", jitter=0.2), legend=F, 
     xlab="Self-reported \n value importance x", ylab="Partner-reported \n value importance y", zlab="Emotional distance z")




## How much variance in the outcome can be explained by the full third-order polynomial model/the strict level-dependent congruence model? 

getPar(cl_myrsa, model="cubic", type="R2")

getPar(cl_myrsa, model="CL", type="R2")





# ----------------------------------------------------------------------------

# RRCL - Example code for investigating the rising ridge level-dependent congruence hypothesis

# ----------------------------------------------------------------------------



## estimate the rising ridge level-dependent congruence model (RRCL) and the full third-order model (cubic)

rrcl_myrsa <- RSA(Z ~ X*Y, data=cl_data, model=c("RRCL","cubic"), missing="fiml", out.rm=TRUE)





## Step 1



# compare the rising ridge level-dependent congruence model (RRCL) and the full third-order model (cubic)

rrcl_comp <- compare2(rrcl_myrsa, "RRCL", "cubic")

rrcl_comp





## Step 2



# inspect the estimated coefficients

rrcl_coef <- getPar(rrcl_myrsa, model="RRCL")



# test c3 (= b6 in the output) against zero to test the suggested level-dependancy effect

rrcl_coef[rrcl_coef$label == "b6", c("label","est","se","pvalue")]



# test u1 = b1 + b2 to test the suggested linear level effect (NOT significant in this example data)

rrcl_coef[rrcl_coef$label == "u1", c("label","est","se","pvalue")]



# compute the regions of (negative, non-, positive) significance and their intersections with the data

rrcl_rangecheck <- clRange(rrcl_myrsa, model="RRCL", alpha = 0.01)



# the variable "percent_data" in the following table informs how many percent of the data points lie in the respective regions

rrcl_rangecheck$regions





## Plot the rising ridge level-dependent congruence model (including the lines gk1 and gk2 where the significance status of the curvature changes)

plot(rrcl_myrsa, model="RRCL", axes=c("LOC","LOIC","K1","K2"), project=c("LOC","LOIC","K1","K2"), claxes.alpha=0.01, points = list(value="predicted"))





## How much variance in the outcome can be explained by the full third-order polynomial model/the rising ridge level-dependent congruence model? 

getPar(rrcl_myrsa, model="cubic", type="R2")

getPar(rrcl_myrsa, model="RRCL", type="R2")




