#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Paola Renteria
# Created: September 2019
# Purpose: Defines the fields within the `custom_dimensions` struct in google analytics. Is joined to the ga_sessions explore
#          by unnesting the values.
#############################################################################################################

view: custom_dimensions {
  view_label: "Custom Dimensions"
  ########## DIMENSIONS ##########

  dimension: index {
    type: number
    group_label: "Custom Variables"
    label: "Custom Dimension XX"
    description: "The value of the requested custom dimension, where XX refers to the number or index of the custom dimension."
    sql: ${TABLE}.index ;;
  }

  dimension: value {
    description: "The value of the custom dimension for the specified index."
    type: string
    sql: ${TABLE}.value ;;
  }
}
