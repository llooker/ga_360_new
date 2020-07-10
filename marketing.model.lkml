connection: "ga_generated"

# include: "/datagroups.lkml"

include: "/*/*.view.lkml"
include: "/Google_Analytics/Attribution_Models/*.view.lkml"

datagroup: bqml_datagroup {
  #retrain model every day
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURRENT_DATE() ;;
}
# aggregate_awareness: yes
explore: funnel_explorer_new {}

explore: hit_facts {}

explore: ga_sessions {
  label: "Google Analytics Sessions"
  description: "Explores Google Analytics sessions merged with Salesforce data."

  # always_filter: {
  #   filters: {
  #     field: ga_sessions.partition_date
  #     value: "7 days ago for 7 days"
  #   }
  # }

  join: hits {
    type: left_outer
    sql: LEFT JOIN UNNEST(${ga_sessions.hits}) AS hits ;;
    relationship: one_to_many
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
    sql_on: ${time_on_page.hit_id} = ${hits.id} ;;
    relationship: one_to_one
  }

  join: attribution_model_ndt {
    type: inner
    sql_on: ${ga_sessions.id} = ${attribution_model_ndt.id};;
    relationship: one_to_one
  }

  join: user_label {
    type: left_outer
    sql_on: ${ga_sessions.full_visitor_id} = ${user_label.fullvisitorId} ;;
    relationship: many_to_one
    sql_where:  TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))  BETWEEN {% date_start user_label.date_range_filter %} AND {% date_end user_label.date_range_filter %} AND geoNetwork.Country="United States" AND ${ga_sessions.visit_start_seconds} < ifnull(${user_label.event_session_seconds}, 0) OR ${user_label.event_session_seconds} is NULL  ;;
  }
}

explore: funnel_explorer {
}
