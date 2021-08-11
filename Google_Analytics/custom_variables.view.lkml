#############################################################################################################
# Purpose: Defines the fields within the `customvariables` struct in google analytics. Is joined to the ga_sessions explore
#          by unnesting the values.
#############################################################################################################
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/custom_variables.view.lkml"

view: custom_variables {
  
  view_label: "Custom Dimensions"

  ########## DIMENSIONS ##########


}
