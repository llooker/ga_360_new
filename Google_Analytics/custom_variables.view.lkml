#############################################################################################################
# Purpose: Defines the fields within the `customvariables` struct in google analytics. Is joined to the ga_sessions explore
#          by unnesting the values.
#############################################################################################################


view: custom_variables {

  view_label: "Custom Dimensions"

  # Add view customizations here
  dimension: custom_var_name {
    hidden: yes
    group_label: "Custom Variables"
    label: "Custom Variable (Key XX)"
    description: "The name for the requested custom variable."
    type: string
    sql: ${TABLE}.customvarname ;;
  }

  dimension: custom_var_value {
    hidden: yes
    group_label: "Custom Variables"
    label: "Custom Variable (Value XX)"
    description: "The value for the requested custom variable."
    type: string
    sql: ${TABLE}.customvarvalue ;;
  }

  dimension: index {
    hidden: yes
    description: "The index number associated to the custom variable"
    type: number
    sql: ${TABLE}.index ;;
  }

  # dimension: some_name {
  #   type: number
  #   sql: CASE WHEN ${index} = 1 THEN ${custom_var_value} ELSE NULL END ;;
  # }


}
