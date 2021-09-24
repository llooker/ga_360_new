#Purpose of this file is to house the fields used to generate Custom Goals. This file is extended into the `hits` view.


view: goals {
  extension: required
   ########## FILTERS ##########

  filter: event_action_goal_selection {
    label: "Event Action"
    view_label: "Goals"
    group_label: "Goal Selection"
    description: "Enter Event Action to be used with Total Conversion measures."
    type: string
    suggest_explore: ga_sessions
    suggest_dimension: hits.event_action
  }

  filter: event_label_goal_selection {
    label: "Event Label"
    view_label: "Goals"
    group_label: "Goal Selection"
    description: "Enter Event Action to be used with Total Conversion measures."
    type: string
    suggest_explore: ga_sessions
    suggest_dimension: hits.event_label
  }

  filter: event_category_goal_selection {
    label: "Event Category"
    view_label: "Goals"
    group_label: "Goal Selection"
    description: "Enter Event Action to be used with Total Conversion measures."
    type: string
    suggest_explore: ga_sessions
    suggest_dimension: hits.event_category
  }

  filter: page_goal_selection {
    label: "Page"
    view_label: "Goals"
    group_label: "Goal Selection"
    description: "Enter Page Path to be used with Conversion measures (format should be: '/<page>'). Should not include Hostname."
    type: string
    suggest_explore: ga_sessions
    suggest_dimension:  hits.page_path_formatted
  }

  ########## DIMENSIONS ##########

  dimension: dynamic_goal {
    view_label: "Goals"
    group_label: "Goals"
    description: "Goal label based on Goal selection filters."
    type: string
    sql: IF(
          ${has_completed_goal}
          , CONCAT(
            IF({{ event_category_goal_selection._in_query }}, CONCAT(${event_category}, ": "), "")
            , IF({{ event_action_goal_selection._in_query }}, CONCAT(${event_action}, " "), "")
            , IF({{ event_label_goal_selection._in_query }}, CONCAT(${event_label}, " "), "")
            , IF({{ page_goal_selection._in_query }}, CONCAT("on ", ${page_path_formatted}), "")
          )
          , null
        );;
  }

  dimension: goal_in_query {
    description: "Check to verify user has entered a value for at least one goal filter."
    hidden: yes
    type: yesno
    sql: {{ event_action_goal_selection._in_query }}
          OR {{ event_label_goal_selection._in_query }}
          OR {{ event_category_goal_selection._in_query }}
          OR {{ page_goal_selection._in_query }};;
  }

  dimension: has_completed_goal {
    view_label: "Goals"
    group_label: "Goals"
    description: "A session that resulted in a conversion (i.e. resulted in reaching successful point on website defined in 'Goal Selection' field)."
    type: yesno
    sql:if(
          ${goal_in_query}
          , {% condition event_action_goal_selection %} ${event_action} {% endcondition %}
              AND {% condition event_label_goal_selection %} ${event_label} {% endcondition %}
              AND {% condition event_category_goal_selection %} ${event_category} {% endcondition %}
              AND {% condition page_goal_selection %} ${page_path_formatted} {% endcondition %}
          , false
        );;
  }

  ########## MEASURES ##########
  measure: conversion_count {
    view_label: "Goals"
    group_label: "Goal Conversions"
    label: "Total Conversions"
    description: "Total number of hits (Page or Event) that are identified as converisons based on 'Goal Selection' filters."
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${id} ;;

    filters: {
      field: has_completed_goal
      value: "Yes"
    }

    value_format_name: formatted_number
    drill_fields: []
  }

  measure: sessions_with_conversions {
    view_label: "Goals"
    group_label: "Goal Conversions"
    label: "Sessions with Conversion"
    description: "Sessions that result in a conversion based on 'Goal Selection' filters."
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${ga_sessions.id} ;;

    filters: {
      field: has_completed_goal
      value: "Yes"
    }

    value_format_name: formatted_number
    drill_fields: [client_id, visit_number, sessions_with_conversions]
  }

  measure: session_conversion_rate {
    view_label: "Goals"
    group_label: "Goal Conversions"
    label: "Session Conversion Rate"
    description: "Percentage of sessions resulting in a conversion based on 'Goal Selection' filters."
    type: number
    sql: (1.0*${sessions_with_conversions})/NULLIF(${ga_sessions.visits_total}, 0) ;;

    value_format_name: percent_1
    drill_fields: []
  }

}
