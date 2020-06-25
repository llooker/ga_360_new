connection: "ga_generated"

# include: "/datagroups.lkml"
include: "/Google_Analytics/*.view.lkml"
include: "/Dashboards/*.dashboard"
include: "/Google_Analytics/Attribution_Models/attribution_model_ndt.view.lkml"

# aggregate_awareness: yes


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
}

explore: funnel_explorer {
}


# explore: campaign_analytics {
#   description: "Explores Marketing touches and attribution models by merging Campaign Member data with Salesforce Opportunity data."
#   case_sensitive: no
#
#   always_filter: {
#     filters: {
#       field: allocation
#       value: "Acquisition"
#     }
#
#     filters: {
#       field: campaign.origin
#       value: ""
#     }
#   }
#
#   join: account {
#     view_label: "Account"
#     type: left_outer
#     sql_on: ${person.account_id} = ${account.id} ;;
#     relationship: many_to_one
#
#     fields: [account.campaign_analytics_explore_fields*]
#   }
#
#   join: account_pbl_flag {
#     view_label: "Account"
#     type: left_outer
#     sql_on: ${account.id} = ${account_pbl_flag.account_id} ;;
#     relationship: one_to_one
#     fields: [account_pbl_flag.account_pbl_flag_base*]
#   }
#
#   join: account_user {
#     from: _base_salesforce_account_user
#     view_label: "Account"
#     type: left_outer
#     sql_on: ${account.id} = ${account_user.account_id} ;;
#     relationship: many_to_one
#   }
#
#   join: campaign {
#     view_label: "Campaign"
#     type: left_outer
#     sql_on: ${campaign_analytics.campaign_id} = ${campaign.id} ;;
#     relationship: many_to_one
#   }
#
#   join: campaign_merge {
#     type: left_outer
#     sql_on: ${campaign_analytics.member_id} = ${campaign_merge.id} ;;
#     relationship: many_to_one
#   }
#
#   join: clearbit {
#     from:_base_salesforce_clearbit
#     view_label: "Account"
#     type: left_outer
#     sql_on: ${account.clearbit_id} = ${clearbit.id} ;;
#     relationship: many_to_one
#   }
#
#   join: attribution_model_ndt {
#     type: inner
#     sql_on: ${campaign_analytics.id} = ${attribution_model_ndt.id} ;;
#     relationship: one_to_one
#   }
#
#   join: ga_sfdc_user_map {
#     type: left_outer
#     sql_on: ${person.person_id} = ${ga_sfdc_user_map.person_id} ;;
#     relationship: one_to_many
#     fields: []
#   }
#
#   join: ga_sessions {
#     type: left_outer
#     sql_on: ${ga_sfdc_user_map.ga_client_id} = ${ga_sessions.client_id} ;;
#     relationship: one_to_many
#   }
#
#   join: hits {
#     type: left_outer
#     sql: LEFT JOIN UNNEST(${ga_sessions.hits}) AS hits ;;
#     relationship: one_to_many
#   }
#
#   join: custom_dimensions {
#     type: left_outer
#     sql: LEFT JOIN UNNEST(${hits.custom_dimensions}) AS custom_dimensions ;;
#     relationship: one_to_many
#   }
#
#   join: custom_variables {
#     type: left_outer
#     sql: LEFT JOIN UNNEST(${hits.custom_variables}) AS custom_variables ;;
#     relationship: one_to_many
#   }
#
#   join: budget_goal {
#     view_label: "Planning & Goals"
#     type: inner
#     sql_on: ${campaign_analytics.member_created_raw} BETWEEN SAFE_CAST(${budget_goal.start_raw} AS TIMESTAMP) AND SAFE_CAST(${budget_goal.end_raw} AS TIMESTAMP)
#               AND CONCAT(${budget_goal.region}, ${budget_goal.segment}, ${budget_goal.campaign}) = CONCAT(LOWER(${budget_goal.region_join}), LOWER(${budget_goal.segment_join}), LOWER(${budget_goal.campaign_join}))
#               AND ${budget_goal.name} = "budget" ;;
#     relationship: many_to_many
#   }
#
#   join: mql_goal {
#     view_label: "Planning & Goals"
#     type: left_outer
#     sql_on: ${campaign_analytics.latest_mql_raw} BETWEEN SAFE_CAST(${mql_goal.start_raw} AS TIMESTAMP) AND SAFE_CAST(${mql_goal.end_raw} AS TIMESTAMP)
#               AND CONCAT(${mql_goal.region}, ${mql_goal.segment}, ${mql_goal.campaign}) = CONCAT(LOWER(${mql_goal.region_join}), LOWER(${mql_goal.segment_join}), LOWER(${mql_goal.campaign_join}))
#               AND ${mql_goal.name} = "mql" ;;
#     relationship: many_to_many
#   }
#
#   join: routed_goal {
#     view_label: "Planning & Goals"
#     type: left_outer
#     sql_on: ${person.created_raw} BETWEEN SAFE_CAST(${routed_goal.start_raw} AS TIMESTAMP) AND SAFE_CAST(${routed_goal.end_raw} AS TIMESTAMP)
#               AND CONCAT(${routed_goal.region}, ${routed_goal.segment}, ${routed_goal.campaign}) = CONCAT(LOWER(${routed_goal.region_join}), LOWER(${routed_goal.segment_join}), LOWER(${routed_goal.campaign_join}))
#               AND ${routed_goal.name} = "routed" ;;
#     relationship: many_to_many
#   }
#
#   join: stage_1_goal {
#     view_label: "Planning & Goals"
#     type: left_outer
#     sql_on: ${campaign_analytics.opportunity_created_raw} BETWEEN SAFE_CAST(${stage_1_goal.start_raw} AS TIMESTAMP) AND SAFE_CAST(${stage_1_goal.end_raw} AS TIMESTAMP)
#               AND CONCAT(${stage_1_goal.region}, ${stage_1_goal.segment}, ${stage_1_goal.campaign}) = CONCAT(LOWER(${stage_1_goal.region_join}), LOWER(${stage_1_goal.segment_join}), LOWER(${stage_1_goal.campaign_join}))
#               AND ${stage_1_goal.name} = "stage 1" ;;
#     relationship: many_to_many
#   }
#
#   join: stage_2_goal {
#     view_label: "Planning & Goals"
#     type: left_outer
#     sql_on: ${campaign_analytics.opportunity_qualified_raw} BETWEEN SAFE_CAST(${stage_2_goal.start_raw} AS TIMESTAMP) AND SAFE_CAST(${stage_2_goal.end_raw} AS TIMESTAMP)
#               AND CONCAT(${stage_2_goal.region}, ${stage_2_goal.segment}, ${stage_2_goal.campaign}) = CONCAT(LOWER(${stage_2_goal.region_join}), LOWER(${stage_2_goal.segment_join}), LOWER(${stage_2_goal.campaign_join}))
#               AND ${stage_2_goal.name} = "stage 2" ;;
#     relationship: many_to_many
#   }
#
#   join: lead_owner {
#     view_label: "Person"
#     type: left_outer
#     sql_on: ${person.lead_id} = ${lead_owner.lead_id} ;;
#     relationship: many_to_one
#   }
#
#   join: marketing_qualified_dates {
#     type: left_outer
#     sql_on: ${marketing_qualified_dates.id} = ${campaign_analytics.lead_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mql_dates {
#     sql: LEFT JOIN UNNEST(${marketing_qualified_dates.mql_dates}) AS mql_dates ;;
#     relationship: one_to_many
#   }
#
#   join: opportunity {
#     type: left_outer
#     sql_on: ${campaign_analytics.opportunity_id} = ${opportunity.id} ;;
#     relationship: many_to_one
#
#     fields: [opportunity.campaign_analytics_explore_fields*]
#   }
#
#   join: opportunity_owner {
#     from: opportunity_user
#     view_label: "Opportunity"
#     type: left_outer
#     sql_on: ${opportunity.id} = ${opportunity_owner.id} ;;
#     relationship: many_to_one
#   }
#
#   join: person {
#     type: inner
#     sql_on: ${campaign_analytics.person_lead_id} = ${person.person_lead_id} ;;
#     relationship: many_to_one
#   }
#
#   join: person_owner {
#     from: person_user
#     view_label: "Person"
#     type: left_outer
#     sql_on: ${person.person_id} = ${person_owner.person_id} ;;
#     relationship: many_to_one
#   }
#
#   join: person_cohorts {
#     view_label: "Person"
#     type: inner
#     sql_on: ${campaign_analytics.member_id} = ${person_cohorts.member_id} ;;
#     relationship: one_to_one
#   }
#
#   join: task {
#     from: task_extended
#     type: left_outer
#     sql_on: ${campaign_analytics.person_id} = ${task.who_id} ;;
#     relationship: many_to_many
#   }
#
#   join: task_owner {
#     view_label: "Task"
#     from: task_user
#     type: left_outer
#     sql_on: ${task.owner_id} = ${task_owner.owner_id} ;;
#     relationship: many_to_one
#   }
#
# ########## Queries ##############
#   ##### View Data #####
#
#   query: _view_campaign_data {
#     dimensions: [
#       campaign.name,
#       campaign.created_date,
#       campaign.start_date,
#       medium,
#       campaign.content,
#       campaign.content_detail
#     ]
#     measures: [member_count]
#
#     filters: {
#       field: member_created_date
#       value: "this quarter"
#     }
#
#     sort: {
#       field: member_count
#       desc: yes
#     }
#   }
#
#   ##### First Touch #####
#
#   query: ft_mediums_by_mql_count {
#     label: "First Touch Leads & Opps by Medium"
#     dimensions: [medium]
#     measures: [
#       attribution_model_ndt.ft_mql_lead_count
#       , attribution_model_ndt.ft_opportunities
#       , attribution_model_ndt.ft_qualified_opportunities
#       , attribution_model_ndt.ft_won_opportunities
#     ]
#
#     filters: [
#       person.created_date: "this quarter"
#       , opportunity.type: "New Business, Marketplace, Resell"
#     ]
#
#     sort: {
#       field: attribution_model_ndt.ft_mql_lead_count
#       desc: yes
#     }
#   }
#
#   query: lt_mediums_by_opp_count {
#     label: "Last Touch New Business Opps by Medium"
#     dimensions: [medium]
#     measures: [
#       attribution_model_ndt.lt_opportunities
#       , attribution_model_ndt.lt_qualified_opportunities
#       , attribution_model_ndt.lt_won_opportunities
#     ]
#
#     filters: [
#       opportunity_created_date: "this quarter"
#       , opportunity.type: "New Business, Marketplace, Resell"
#     ]
#
#     sort: {
#       field: attribution_model_ndt.lt_opportunities
#       desc: yes
#     }
#   }
#
#   ##### MQLs #####
#   query: mql_count_by_score {
#     label: "MQLs by Score"
#     dimensions: [person.score_at_mql_value]
#     measures: [mql_count]
#
#     filters: [
#       person.score_at_mql_value: "-NULL"
#       , latest_mql_date: "this quarter"]
#
#     sort: {
#       field: person.score_at_mql_value
#       desc: no
#     }
#   }
#
#   query: mql_count_by_segment {
#     label: "MQLs by Segment"
#     dimensions: [person.employee_segment]
#     measures: [mql_count]
#
#     filters: [latest_mql_date: "this quarter"]
#
#     sort: {
#       field: person.employee_segment
#       desc: yes
#     }
#   }
#
#   query: mql_count_by_region {
#     label: "MQLs by Region"
#     dimensions: [person.person_region]
#     measures: [mql_count]
#
#     filters: [latest_mql_date: "this quarter"]
#   }
#
#   query: mql_count_by_emea_territories {
#     label: "MQLs by EMEA Territories"
#     dimensions: [person.emea_sub_territory]
#     measures: [mql_count]
#
#     filters: [
#       latest_mql_date: "this quarter"
#       , person.person_region: "EMEA"]
#
#     sort: {
#       field: mql_count
#       desc: yes
#     }
#   }
#
#   query: stage_2_by_segment {
#     label: "Stage 2 Opps by Segment"
#     dimensions: [account.segment]
#     measures: [
#       stage_2_count
#     ]
#
#     filters: [
#       opportunity_qualified_date: "this quarter"
#       , opportunity.type: "New Business, Marketplace, Resell"
#     ]
#
#     sort: {
#       field: stage_2_count
#       desc: yes
#     }
#   }
#
#   query: stage_2_by_region {
#     label: "Stage 2 Opps by Region"
#     dimensions: [person.region]
#     measures: [
#       stage_2_count
#     ]
#
#     filters: [
#       opportunity_qualified_date: "this quarter"
#       , opportunity.type: "New Business, Marketplace, Resell"
#     ]
#
#     sort: {
#       field: stage_2_count
#       desc: yes
#     }
#   }
#
#   query: stage_2_by_emea_territory {
#     label: "Stage 2 Opps by EMEA Territory"
#     dimensions: [person.emea_sub_territory]
#     measures: [
#       stage_2_count
#     ]
#
#     filters: [
#       opportunity_qualified_date: "this quarter"
#       , opportunity.type: "New Business, Marketplace, Resell"
#     ]
#
#     sort: {
#       field: stage_2_count
#       desc: yes
#     }
#   }
# }
