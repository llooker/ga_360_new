connection: "@{CONNECTION_NAME}"

# include: "/datagroups.lkml"
include: "/*/*.view.lkml"
include: "/Google_Analytics/*.view.lkml"
include: "/Google_Analytics/Custom_Views/*.view.lkml"
include: "/Dashboards/*.dashboard"
include: "//@{CONFIG_PROJECT_NAME}/block_google_analytics_360_config.model"
datagroup: bqml_datagroup {
  #retrain model every month
  sql_trigger: SELECT EXTRACT(month from CURRENT_DATE()) ;;
}
aggregate_awareness: yes

explore: ga_sessions {
  extends: [ga_sessions_config]
}

explore: ga_sessions_core {
  extension: required
  label: "Google Analytics Sessions"
  description: "Explores Google Analytics sessions  data."

  always_filter: {
    filters: {
      field: partition_date
      value: "@{EXPLORE_DATE_FILTER}"
    }
  }

  aggregate_table: sessions_by_session_start_date {
    query: {
      dimensions: [visit_start_date]
      measures: [visits_total]
    }
    materialization: {
      sql_trigger_value: SELECT CURRENT_DATE() ;;
    }
  }

  join: audience_cohorts {
    type: left_outer
    sql_on: ${ga_sessions.audience_trait} = ${audience_cohorts.audience_trait} ;;
    relationship: many_to_one
  }

  join: hits {
    type: left_outer
    sql: LEFT JOIN UNNEST(${ga_sessions.hits}) AS hits ;;
    relationship: one_to_many
  }

  join: page_funnel {
    type: left_outer
    sql_on: ${page_funnel.page1_hit_id} = ${hits.id} ;;
    relationship: one_to_one
  }

  join: event_action_funnel {
    type: left_outer
    sql_on: ${event_action_funnel.event1_hit_id} = ${hits.id} ;;
    relationship: one_to_one
  }

  join: event_action_facts {
    type: left_outer
    sql_on: ${ga_sessions.id} = ${event_action_facts.session_id}
    AND (${hits.hit_number} BETWEEN ${event_action_facts.hit_number} AND COALESCE(${event_action_facts.next_event_hit_number}-1, ${event_action_facts.hit_number}));;
    relationship: one_to_one
  }


  join: page_facts {
    type: left_outer
    sql_on: ${ga_sessions.id} = ${page_facts.session_id}
              AND (${hits.hit_number} BETWEEN ${page_facts.hit_number} AND COALESCE(${page_facts.next_page_hit_number}-1, ${page_facts.hit_number}));;
    relationship: one_to_one
  }

  join: session_flow {
    type: left_outer
    sql_on: ${ga_sessions.id} = ${session_flow.session_id};;
    relationship: one_to_one
  }


  join: time_on_page {
    view_label: "Behavior"
    type: left_outer
    sql_on: ${hits.id} = ${time_on_page.hit_id} ;;
    relationship: one_to_one
  }

  join: user_segment {
    type: left_outer
    sql_on: ${ga_sessions.full_visitor_id} = ${user_segment.full_visitor_id} ;;
    relationship: many_to_one
  }

}

explore: future_input {
  extends: [future_input_config]
}

explore: future_input_core {
  extension: required
  view_label: "Audience Traits"
  label: "BQML Customer Likelihood to Purchase"
  description: "This explore allows you to slice and dice likeliness to purchase scores by different customer traits to see how they differ. The default range of data you are looking at is in the past 30 days"
  join: future_purchase_prediction {
    type: left_outer
    sql_on: ${future_purchase_prediction.clientId} = ${future_input.client_id} ;;
    relationship: one_to_one
  }
}




named_value_format: hour_format {
  value_format: "[h]:mm:ss"
}

named_value_format: formatted_number {
  value_format:"[<1000]0;[<1000000]0.0,\"K\";0.0,,\"M\""
}
