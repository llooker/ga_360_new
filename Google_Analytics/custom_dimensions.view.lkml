#############################################################################################################
# Purpose: Defines the fields within the `custom_dimensions` struct in google analytics.
# Joined to the ga_sessions explore but by unnesting values.
#############################################################################################################
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/custom_dimensions.view.lkml"

view: custom_dimensions {
  extends: [custom_dimensions_config]
}


view: custom_dimensions_core {
  extension: required

  view_label: "Custom Dimensions"

}
