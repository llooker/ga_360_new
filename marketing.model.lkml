connection: "ga_generated"

# include: "/datagroups.lkml"

include: "/*/*.view.lkml"
include: "/Google_Analytics/Attribution_Models/*.view.lkml"
include: "/Dashboards/*.dashboard"

datagroup: bqml_datagroup {
  #retrain model every day
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURRENT_DATE() ;;
}
aggregate_awareness: yes



explore: ga_sessions {
  label: "Google Analytics Sessions"
  description: "Explores Google Analytics sessions  data."

  always_filter: {
    filters: {
      field: partition_date
      value: "@{PARTITION_DATE_FILTER}"
    }
  }


  join: hits {
    type: left_outer
    sql: LEFT JOIN UNNEST(${ga_sessions.hits}) AS hits ;;
    relationship: one_to_many
  }

  join: page_funnel {
    type: left_outer
    sql_on: ${page_funnel.event1_hit_id} = ${hits.id} ;;
    relationship: one_to_one
  }

  join: event_action_funnel {
    type: left_outer
    sql_on: ${event_action_funnel.event1_hit_id} = ${hits.id} ;;
    relationship: one_to_one
  }

  join: asset_facts {
    type: left_outer
    sql_on: ${hits.page_path_formatted} = ${asset_facts.page} ;;
    relationship: many_to_one
  }

  join: custom_dimensions {
    type: left_outer
    sql: LEFT JOIN UNNEST(${hits.custom_dimensions}) AS custom_dimensions ;;
    relationship: one_to_many
  }

  join: custom_variables {
    type: left_outer
    sql: LEFT JOIN UNNEST(${hits.custom_variables}) AS custom_variables ;;
    relationship: one_to_many
  }

  join: session_page_sequence {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga_sessions.full_visitor_id} = ${session_page_sequence.full_visitor_id}
          AND ${ga_sessions.visit_id} = ${session_page_sequence.visit_id}
          AND ${hits.page_title} = ${session_page_sequence.page_title} ;;
    sql_where:  ${hits.type} = 'PAGE' ;;
  }

  join: session_page_facts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga_sessions.full_visitor_id} = ${session_page_facts.full_visitor_id}
      AND ${ga_sessions.visit_id} = ${session_page_facts.visit_id} ;;
  }

  join: time_on_page {
    type: left_outer
    sql_on: ${hits.id} = ${time_on_page.hit_id} ;;
    relationship: one_to_one
  }

  join: attribution_model_pdt {
    type: inner
    sql_on: ${ga_sessions.id} = ${attribution_model_pdt.id};;
    relationship: one_to_one
  }

#   join: user_label {
#     type: left_outer
#     sql_on:  ${ga_sessions.full_visitor_id} = ${user_label.fullvisitorId} ;;
#     relationship: many_to_one
#     sql_where:   {% if  user_label.made_purchase._value == 'Yes' %}
#                   ${ga_sessions.visit_start_seconds} < ifnull(${user_label.event_session_seconds}, 0) OR ${user_label.event_session_seconds} is NULL
#                   {% else %}
#                     1=1
#                   {% endif %};;
#   }

#   join: future_purchase_prediction {
#     type: left_outer
#     sql_on: ${future_purchase_prediction.fullVisitorId} = ${ga_sessions.full_visitor_id} ;;
#     relationship: one_to_many
#   }
}




named_value_format: hour_format {
  value_format: "[h]:mm:ss"
}
