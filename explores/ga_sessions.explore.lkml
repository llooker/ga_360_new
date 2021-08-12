include: "/*/*.view.lkml"
include: "/Google_Analytics/*.view.lkml"
include: "/Google_Analytics/Sessions/*.view.lkml"
include: "/Google_Analytics/Custom_Views/*.view.lkml"

explore: ga_sessions {
  label: "Google Analytics Sessions"
  description: "Explores Google Analytics sessions data."

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


  join: custom_dimensions {
    type: left_outer
    relationship: one_to_one
    sql: LEFT JOIN UNNEST(${ga_sessions.custom_dimensions}) AS custom_dimensions ;;
  }

  join: custom_variables {
    type: left_outer
    relationship: one_to_one
    sql: LEFT JOIN UNNEST(${ga_sessions.custom_variables}) AS custom_variables ;;
  }

  ## Aggregate Tables for LookML Dashboards
  ## GA360 Overview Dashboard

  aggregate_table: rollup__percent_new_sessions__visits_total {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.continent, ga_sessions.country]
      measures: [percent_new_sessions, visits_total]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__bounce_rate__bounces_total {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [bounce_rate, bounces_total]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__timeonsite_average_per_session {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [timeonsite_average_per_session]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__time_on_site_tier {
    query: {
      dimensions: [time_on_site_tier, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [visits_total]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__continent__visit_start_month {
    query: {
      dimensions: [continent, ga_sessions.visit_start_month, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [visits_total]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__region {
    query: {
      dimensions: [region, ga_sessions.country, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [visits_total]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__source {
    query: {
      dimensions: [source, ga_sessions.medium, ga_sessions.source_medium, ga_sessions.partition_date, ga_sessions.landing_page_hostname, ga_sessions.continent, ga_sessions.country]
      measures: [visits_total]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__landing_page_formatted {
    query: {
      dimensions: [landing_page_formatted, ga_sessions.landing_page_hostname, ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [visits_total, percent_new_sessions]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__hits_page_count__hits_unique_page_count {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [hits.page_count, hits.unique_page_count]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__hits_page_path_formatted {
    query: {
      dimensions: [hits.page_path_formatted, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [hits.page_count, hits.unique_page_count]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  ## End GA360 Dashboard

  ## Acquisition Dashboard
  aggregate_table: rollup__unique_visitors {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.continent, ga_sessions.country, ga_sessions.landing_page_hostname]
      measures: [unique_visitors]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__hits_page_count {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.continent, ga_sessions.country, ga_sessions.landing_page_hostname]
      measures: [hits.page_count]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__audience_trait {
    query: {
      dimensions: [audience_trait]
      measures: [bounce_rate, page_views_session, percent_new_sessions, timeonsite_average_per_session, visits_total]
      filters: [
        ga_sessions.audience_selector: "Channel",
        ga_sessions.partition_date: "7 days"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  ## End Acquisition Dashboard

  ## Audience Dashboard
  aggregate_table: rollup__visits_total {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [visits_total]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__unique_visitors_02 {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [unique_visitors]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: rollup__hits_page_count_02 {
    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [hits.page_count]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__visit_number_tier {
    query: {
      dimensions: [visit_number_tier, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [unique_visitors]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__session_flow_days_since_previous_session_tier {
    query: {
      dimensions: [session_flow.days_since_previous_session_tier, ga_sessions.partition_date, ga_sessions.visit_number]
      measures: [visits_total]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: rollup__session_flow_pages_visited {
    query: {
      dimensions: [ga_sessions.partition_date, session_flow.pages_visited]
      measures: [visits_total]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  ## End Audience Dashboard

  ## Behavior Dashboard
  aggregate_table: rollup__hits_full_event {
    query: {
      dimensions: [hits.full_event, ga_sessions.partition_date, hits.host_name]
      measures: [hits.event_count, hits.unique_event_count]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  ## End Behavior Dashboard

  ## Custom Page Funnel Dashboard
  aggregate_table: rollup__top_page_paths {
    query: {
      dimensions: [ga_sessions.partition_date,
        session_flow.page_path_1,
        session_flow.page_path_2,
        session_flow.page_path_3,
        session_flow.page_path_4,
        session_flow.page_path_5,
        session_flow.page_path_6
      ]
      measures: [visits_total]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  ## End Custom Page Funnel Dashboard

}