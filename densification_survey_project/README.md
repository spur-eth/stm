# Code for reproducing STM models and visualizations presented in the "Nuancing Conjoint Experiments" SPUR paper (to be submitted)

## Setup for STM (R)
The code for computing STM (Structural Topic Modelling) is in R. Install R if you have not already installed it, and download the required packages for workflow.

    > The main packages you might require are [stm](https://cran.r-project.org/web/packages/stm/stm.pdf) and [stminsights](https://cran.r-project.org/web/packages/stminsights/vignettes/intro.html) and any dependencies.
    > The version of R and R packages used for the analysis of this survey data can be found in the `R_session_info_STM.pdf` file in the `resources` folder, in case there are any issues with replicating the analysis. 
    > For convenience the data from the survey responses (spur_survey_response_filtered_df1_for_stm_corrected_imces_v2.csv) is provided in the `data` folder, and the .RData image of the STM models generated from this data for the paper (stm_models_dens_survey_paper_final_2022.RData) are in the `stm_models` folder in the `outputs` folder. 
    > A file with information about each of the topics (`stm_topic_interpretations.xlsx`) is included in the `metadata` folder.

## Generating the STM models and visualizing the topics
Can rerun the `01_generate_stm.Rmd` script to regenerate the results from the paper, or just visualize them by loading the .RData file and running stminsights to visualize the models. A .html version of the `01_generate_stm.Rmd` file is included in the `resources` folder for easy visualization of the code and some of its outputs.

One can load the .RData file by running the following: 

```R
library(stm)
load('.outputs/stm_models/stm_models_dens_survey_paper_final_2022.RData')
```

If you want to run stiminsights you can also execute: 

```R
library(stminsights)
run_stminsights()
```

stminsights facilitates exploration of the STM models generated including top scoring words for each topic, top responses for each topic, and wordclouds of top scoring words, and visualization of topic semantic coherence and exclusivity amongst others. 

## Writing out model information for custom visualizations
To make some custom visualizations* of the STM model results, I export the relevant information from the effect estimates for the STM models to csv files with the `02_stm_models_to_df.R` script in the `code` folder.  

*(Being more familiar with python, I created some python code for these visualizations that requires these dataframes as input)


### Additional resources for stm and stminsights
(In addition to the documentation for the packages referenced above)

- Many amazing resources listed on [this page](http://www.structuraltopicmodel.com/), and a simple example of STM (with pretty visualizations) can be found on [this blog](https://juliasilge.com/blog/sherlock-holmes-stm/) and more on STM model training, evaluation, and interpretation can be found [here](https://juliasilge.com/blog/evaluating-stm/) 