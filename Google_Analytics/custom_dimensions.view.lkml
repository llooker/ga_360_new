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
  ########## DIMENSIONS ##########

  dimension: index {
    hidden: yes
    type: number
    group_label: "Custom Variables"
    label: "Custom Dimension XX"
    description: "The value of the requested custom dimension, where XX refers to the number or index of the custom dimension."
    sql: ${TABLE}.index ;;
  }

  dimension: value {
    hidden: yes
    description: "The value of the custom dimension for the specified index."
    type: string
    sql: ${TABLE}.value ;;
  }
}
