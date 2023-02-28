
library(stm)
library(stminsights)
library(ggplot2)
library(dplyr)

# save objects in .RData file
load('./outputs/stm_models/stm_models_dens_survey_paper_final_2022.RData')

### MAKE DATAFRAMES for each of the STM models of interest to export for custom python visualizations. 

############### GET EFFECT DATAFRAMES WITH TOPIC PROPORTIONS ######################
#participation without controls
testdf <- stminsights::get_effects(estEff_frame_part, variable='imce_Partic', type='continuous')

#participation with controls
testdf <- stminsights::get_effects(estEff_frame_part_w_controls, variable='imce_Partic', type='continuous')
testdf <- testdf %>% rename(imce_Partic = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_frame_part_w_controls_imce_Partic.csv", row.names = FALSE)

testdf <- stminsights::get_effects(estEff_frame_part_w_controls, variable='frame', type='pointestimate')
testdf<- testdf %>% rename(frame = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_pointestimate_topic_model_to_graph_estEff_frame_part_w_controls_frame.csv", row.names = FALSE)

#climate with controls
testdf <- stminsights::get_effects(estEff_climate_w_controls, variable='imce_ClimNeutr', type='continuous')
testdf <- testdf %>% rename(imce_ClimNeutr = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_climate_w_controls_imce_ClimNeutr.csv", row.names = FALSE)

testdf <- stminsights::get_effects(estEff_climate_w_controls, variable='climate_concern', type='continuous')
testdf <- testdf %>% rename(climate_concern = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_climate_w_controls_climate_concern.csv", row.names = FALSE)

#dens with controls
testdf <- stminsights::get_effects(estEff_dens_w_preframe_attitude_w_controls, variable='imce_dens', type='continuous')
testdf <- testdf %>% rename(imce_dens = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_dens_w_preframe_attitude_w_controls_imce_dens.csv", row.names = FALSE)

testdf <- stminsights::get_effects(estEff_dens_w_preframe_attitude_w_controls, variable='preframe_densifproj_acceptance', type='continuous')
testdf <- testdf %>% rename(preframe_densifproj_acceptance = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_dens_w_preframe_attitude_w_controls_preframe_densifproj_acceptance.csv", row.names = FALSE)

# rent zoning w. controls
testdf <- stminsights::get_effects(estEff_rentc_zone_pol_w_controls, variable='imce_RentContr', type='continuous')
testdf <- testdf %>% rename(imce_RentContr = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_rentc_zone_pol_w_controls_imce_RentContr.csv", row.names = FALSE)

testdf <- stminsights::get_effects(estEff_rentc_zone_pol_w_controls, variable='imce_InclZon', type='continuous')
testdf <- testdf %>% rename(imce_InclZon = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_rentc_zone_pol_w_controls_imce_InclZon.csv", row.names = FALSE)

testdf <- stminsights::get_effects(estEff_rentc_zone_pol_w_controls, variable='political_left_right', type='continuous')
testdf <- testdf %>% rename(political_left_right = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_rentc_zone_pol_w_controls_political_left_right.csv", row.names = FALSE)

testdf <- stminsights::get_effects(estEff_rentc_zone_pol_w_controls, variable='income', type='continuous')
testdf <- testdf %>% rename(income = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_rentc_zone_pol_w_controls_income.csv", row.names = FALSE)

testdf <- stminsights::get_effects(estEff_rentc_zone_city_w_context_w_controls, variable='city', type='pointestimate')
testdf<- testdf %>% rename(city = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_pointestimate_topic_model_to_graph_estEff_rentc_zone_city_w_context_w_controls_city.csv", row.names = FALSE)

############## TOPIC CORRELATIONS ###############################################
topiccors_part <- topicCorr(survey.fit.frame_part_w_controls, cutoff = 0.05)
topiccors_part_df <- do.call(rbind.data.frame, topiccors_part)

write.csv(topiccors_part$cor,"./outputs/model_info/topiccorrs_to_graph_survey.fit.frame_part_w_controls.csv") #, row.names = FALSE)
write.csv(topiccors_part$posadj,"./outputs/model_info/topiccorrs_to_graph_survey.fit.frame_part_w_controls_posadj.csv") #, row.names = FALSE)
topiccors_part

testdf
write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_frame_part_w_controls_imce_Partic.csv", row.names = FALSE)
#write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_climate_w_controls_imce_ClimNeutr.csv", row.names = FALSE)
#write.csv(testdf,"./outputs/model_info/test_df_continuous_topic_model_to_graph_estEff_dens_w_preframe_attitude_w_controls_imce_dens.csv", row.names = FALSE)

########### CONTENT #############################################################

# Model 2 w/ controls and city content modifier
survey.fit.dens_w_preframe_attitude_w_controls_inc_city_content <- stm(out$documents, 
                                                                       vocab = out$vocab, 
                                                                       K = 15, max.em.its = 100,
                                                                       prevalence =~ imce_dens + preframe_densifproj_acceptance + gender_Male + minority + age + income + education + city,
                                                                       content =~ city, 
                                                                       data = out$meta, 
                                                                       init.type = "Spectral", verbose=FALSE)


estEff_dens_w_preframe_attitude_w_controls_inc_city_content <- estimateEffect(
  formula = 1:15 ~ imce_dens + preframe_densifproj_acceptance + gender_Male + minority + age + income + education + city,
  stmobj = survey.fit.dens_w_preframe_attitude_w_controls_inc_city_content, 
  meta = out$meta, 
  uncertainty = "Global")

pdf("stm-plot-densification-content-perspectives_cities_v2.pdf", width=10, height=8.5)
plot(survey.fit.dens_w_preframe_attitude_w_controls_inc_city_content, type="perspectives", topics=c(2)) #, topics=7) #2, 5, 8, 11, 14, 15
dev.off()

estEff_dens_w_preframe_attitude_w_controls_inc_city_content_summary <- summary(estEff_dens_w_preframe_attitude_w_controls_inc_city_content, 
                                                topics=1:15) 
estEff_dens_w_preframe_attitude_w_controls_inc_city_content_summary

survey.fit.dens_w_preframe_attitude_w_controls_inc_city_content.labels_city <- labelTopics(survey.fit.dens_w_preframe_attitude_w_controls_inc_city_content, n=20)
survey.fit.dens_w_preframe_attitude_w_controls_inc_city_content.labels_city 



testdf <- stminsights::get_effects(estEff_dens_w_preframe_attitude_w_controls_inc_city_content, variable='city', type='pointestimate')
testdf<- testdf %>% rename(city = value, ci_lower = lower, ci_upper = upper)
write.csv(testdf,"./outputs/model_info/test_df_pointestimate_topic_model_to_graph_estEff_dens_w_preframe_attitude_w_controls_inc_city_content_city.csv", row.names = FALSE)


#################################################################################

chosenModel <- survey.fit.frame_part_w_controls
plot_estEff_chosenModel <- plot(estEff_frame_part_w_controls, 
                         covariate = "imce_Partic", 
                         model= chosenModel, #survey.fit.nometa,
                         topics = 1:15,
                         method = "continuous", 
                         xlab="IMCE (participation)",
                         ylab="Expected Topic Proportions",
                         main = "Effect of participation IMCE on Topic Proportion",
                         printlegend = TRUE)

estEff_frame_part_w_controls_summary <- summary(estEff_frame_part_w_controls, 
                                                topics=1) 
#                                                topics=1:15)
estEff_frame_part_w_controls_summary #$tables
