# Executable Environment for OSF Project [drv3a](https://osf.io/drv3a/)

This repository was automatically generated as part of a project to test the reproducibility of open science projects hosted on the Open Science Framework (OSF).

**Project Title:** Cubic Response Surface Analysis: Investigating Asymmetric and Level-Dependent Congruence Effects With Third-Order Polynomial Models

**Project Description:**
> Here, we provide you with additional materials for the following article:

Humberg, S., Schönbrodt, F. D., Back, M. D., &amp; Nestler, S. (2022). Cubic response surface analysis: Investigating asymmetric and level-dependent congruence effects with third-order polynomial models. Psychological Methods, 27(4), 622–649. https://doi.org/10.1037/met0000352

The folder "Additional OSF Materials" contains a file where readers can find the OSF Materials A to H that we refer to in the manuscript. These materials contain mathematical proofs of diverse statements about the polynomial models that we suggest to investigate complex congruence hypotheses, detailed descriptions on how to investigate the broad versions of the (simple or complex) congruence hypotheses, as well as a step-by-step guide through the R code for investigating complex congruence hypotheses (see the table of contents in the file for more details).

The folder "Example R-Code" contains 
- the simulated data that was used in the manuscript 
- example R code that guides readers through investigating (strict and broad) asymmetric and level-dependent congruence hypotheses. 

The folder "R-Code Real Data Example" contains the R code that can be used to reproduce the results of Case Study 3.

**Original OSF Page:** [https://osf.io/drv3a/](https://osf.io/drv3a/)

---

**Important Note:** The contents of the `drv3a_src` folder were cloned from the OSF project on **12-03-2025**. Any changes made to the original OSF project after this date will not be reflected in this repository.

The `DESCRIPTION` file was automatically added to make this project Binder-ready. For more information on how R-based OSF projects are containerized, please refer to the `osf-to-binder` GitHub repository: [https://github.com/Code-Inspect/osf-to-binder](https://github.com/Code-Inspect/osf-to-binder)

## flowR Integration

This version of the repository has the **[flowR Addin](https://github.com/flowr-analysis/rstudio-addin-flowr)** preinstalled. flowR allows visual design and execution of data analysis workflows within RStudio, supporting better reproducibility and modular analysis pipelines.

To use flowR, open the project in RStudio and go to `Addins` > `flowR`.

## How to Launch:

**Launch in your Browser:**

🚀 **MyBinder:** [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/code-inspect-binder/osf_drv3a-f/HEAD?urlpath=rstudio)

   * This will launch the project in an interactive RStudio environment in your web browser.
   * Please note that Binder may take a few minutes to build the environment.

🚀 **NFDI JupyterHub:** [![NFDI](https://nfdi-jupyter.de/images/nfdi_badge.svg)](https://hub.nfdi-jupyter.de/r2d/gh/code-inspect-binder/osf_drv3a-f/HEAD?urlpath=rstudio)

   * This will launch the project in an interactive RStudio environment on the NFDI JupyterHub platform.

**Access Downloaded Data:**
The downloaded data from the OSF project is located in the `drv3a_src` folder.

## Run via Docker for Long-Term Reproducibility

In addition to launching this project using Binder or NFDI JupyterHub, you can reproduce the environment locally using Docker. This is especially useful for long-term access, offline use, or high-performance computing environments.

### Pull the Docker Image

```bash
docker pull meet261/repo2docker-drv3a-f:latest
```

### Launch RStudio Server

Run the container (with a name, e.g. `rstudio-dev`):
```bash
docker run -it --name rstudio-dev --platform linux/amd64 -p 8888:8787 --user root meet261/repo2docker-drv3a-f bash
```

Inside the container, start RStudio Server with no authentication:
```bash
/usr/lib/rstudio-server/bin/rserver --www-port 8787 --auth-none=1
```

Then, open your browser and go to: [http://localhost:8888](http://localhost:8888)

> **Note:** If you're running the container on a remote server (e.g., via SSH), replace `localhost` with your server's IP address.
> For example: `http://<your-server-ip>:8888`

## Looking for the Base Version?

For the original Binder-ready repository **without flowR**, visit:
[osf_drv3a](https://github.com/code-inspect-binder/osf_drv3a)

