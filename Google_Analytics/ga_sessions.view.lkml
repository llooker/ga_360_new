#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Paola Renteria
# Created: September 2019
# Purpose: Surfaces event data from Google Analytics
#############################################################################################################
include: "geonetwork.view.lkml"
include: "totals.view.lkml"
include: "traffic_source.view.lkml"
include: "device.view.lkml"

view: ga_sessions {
  view_label: "Session"
  sql_table_name: `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` ;;
  extends: [geonetwork, totals, traffic_source, device]

  ########## PRIMARY KEYS ##########
  dimension: id {
    primary_key: yes
    label: "User/Session ID"
    group_label: "ID"
    description: "Unique ID for Session: Full User ID | Session ID | Session Start Date"
    sql: CONCAT(
          CAST(${full_visitor_id} AS STRING)
          , '|'
          , COALESCE(CAST(${visit_id} AS STRING),'')
          , '|'
          , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
        ) ;;
  }

  ########## FOREIGN KEYS ##########
  dimension: full_visitor_id {
    label: "Full User ID"
    group_label: "ID"
    description: "The unique visitor ID (also known as client ID)."
    sql: ${TABLE}.fullVisitorId ;;
  }

  dimension: user_id {
    hidden: yes
    label: "User ID"
    sql: ${TABLE}.userid ;;
  }

  dimension: visit_id {
    label: "Session ID"
    group_label: "ID"
    description: "An identifier for this session. This is part of the value usually stored as the _utmb cookie. This is only unique to the user. For a completely unique ID, you should use User/Session ID"
    type: number
    sql: ${TABLE}.visitId ;;
  }

  dimension: visitor_id {
    hidden: yes
    label: "User ID"
    sql: ${TABLE}.visitorId ;;
  }

  ########## DIMENSIONS ############
  dimension: channel_grouping {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    label: "Default Channel"
    description: "The Channel Group associated with an end user's session for this View (defined by the View's Channel Groupings)."
    sql: ${TABLE}.channelGrouping ;;
  }

  dimension: client_id {
    view_label: "Audience"
    group_label: "User"
    description: "Unique ID given to a user that we capture within Salesforce. A user can have multiple Client IDs"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 20) ;;
  }

  dimension: company_name {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "The name of the company (custom dimension index 3)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 3) ;;
  }

  dimension: company_type {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "Type of company e.g. non-profit, education, private, government (custom dimension index 11)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 11) ;;
  }

  dimension: domain {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "Company's domain (custom dimension index 12)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 12) ;;
  }

  dimension: employees_range {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "The range of number of employees (custom dimension index 4)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 4) ;;
  }

  dimension: hits {
    description: "Is used for unnesting the hits struct, should not be used as a standalone dimension"
    hidden: yes
    sql: ${TABLE}.hits ;;
  }

  dimension: industry {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "The industry that the company falls into (custom dimension index 8)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 8) ;;
  }

  dimension: industry_group {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "The industry group (custom dimension index 9)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 9) ;;
  }

  dimension: industry_tags {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "Tags that label the company's industry (custom dimension index 5)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 5) ;;
  }

  dimension: intellimize {
    description: "Intellimize (custom dimension index 19)"
    view_label: "Audience"
    group_label: "User"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=19) ;;
  }

  dimension: is_first_time_visitor {
    hidden: yes
    type: yesno
    sql: ${visit_number} = 1 ;;
  }

  dimension: is_weekend {
    view_label: "Session"
    group_label: "Time"
    description: "Use this field to exclude Saturday and Sundays from analysis"
    type: yesno
    sql: ${visit_start_day_of_week} IN ('Saturday', 'Sunday') ;;
  }

  # Investigate performance impact below (tech debt)
  dimension: landing_page {
    view_label: "Behavior"
    group_label: "Pages (with Parameters)"
    label: "Landing Page"
    description: "Landing page for session."
    sql: (
          SELECT
            MAX(
              CASE
                WHEN hits.isEntrance AND hits.type = 'PAGE'
                  THEN hits.page.pagePath
              END
            ) as lp
          FROM UNNEST(${TABLE}.hits) as hits
        ) ;;
  }

  dimension: landing_page_formatted {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Landing Page"
    description: "Landing page for session without url parameters."
    type: string
    sql: SPLIT(${landing_page}, '?')[OFFSET(0)];;
  }

  dimension: landing_page_hostname {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Landing Page Hostname"
    description: "Landing page hostname for session."
    sql: (
          SELECT
            MAX(
              CASE
                WHEN hits.isEntrance AND hits.type = 'PAGE'
                  THEN hits.page.hostname
              END
            ) as lp
          FROM UNNEST(${TABLE}.hits) as hits
        ) ;;

    drill_fields: [landing_page_formatted]
  }

  dimension: landing_page_title {
    view_label: "Behavior"
    group_label: "Pages"
    description: "Landing page title for session."
    sql: (
          SELECT
            MAX(
              CASE
                WHEN hits.isEntrance AND hits.type = 'PAGE'
                  THEN hits.page.pageTitle
              END
            ) as lp
          FROM UNNEST(${TABLE}.hits) as hits
        ) ;;
  }

  dimension: partition_date {
    view_label: "Session"
    group_label: "Time"
    description: "Date that is parsed from the table name. Required as a filter to avoid accidental massive queries."
    type: date_time
    sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')))  ;;
    convert_tz: no
  }

  dimension: social_engagement_type {
    group_label: "Social Interactions"
    label: "Social Type"
    description: "Engagement type, either 'Socially Engaged' or 'Not Socially Engaged'."
    sql: ${TABLE}.socialEngagementType ;;
  }

  dimension: sub_industry {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "The sub-industry that the company falls into (custom dimension index 7)"
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 7) ;;
  }

  dimension: tech_stack {
    view_label: "Audience"
    group_label: "Clearbit"
    description: "Programming langugages, tools and frameworks used (custom dimension index 6)"
    type: string
    sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index = 6) ;;
  }

  dimension: visit_number {
    type: number
    view_label: "Audience"
    group_label: "User"
    label: "Session Number"
    description: "The session index for a user. Each session from a unique user will get its own incremental index starting from 1 for the first session. Subsequent sessions do not change previous session indices. For example, if a user has 4 sessions to the website, sessionCount for that user will have 4 distinct values of '1' through '4'."
    sql: ${TABLE}.visitNumber ;;
  }

  dimension: user_type {
    view_label: "Audience"
    group_label: "User"
    label: "User Type"
    description: "Either New User or Returning User, indicating if the users are new or returning."
    sql: CASE
          WHEN ${visit_number} = 1 THEN 'New User'
          ELSE 'Returning User'
         END;;

    drill_fields: [visit_number]
  }

  dimension: visit_number_tier {
    view_label: "Audience"
    group_label: "User"
    label: "Session Number Tier"
    description: "Session Number dimension grouped in tiers between 1-100. See 'Session Number' for full description."
    type: tier
    tiers: [1,2,5,10,15,20,50,100]
    style: integer
    sql: ${visit_number} ;;
  }

  dimension: visit_start_seconds {
    label: "Visit Start Seconds"
    type: number
    sql: ${TABLE}.visitStarttime ;;
    hidden: yes
  }

  dimension_group: visit_start {
    label: "Session Start"
    description: "Timestamp of the start of the Session. References visitStartTime field. Value potentially differs from 'Partition Date'"
    type: time
    timeframes: [
      raw,
      hour_of_day,
      date,
      day_of_week,
      fiscal_quarter,
      week,
      month,
      year,
      month_name,
      month_num,
      week_of_year
    ]
    sql: TIMESTAMP_SECONDS(${TABLE}.visitStarttime);;
    convert_tz: no
  }

  ########## MEASURES ##############

  measure: total_conversions {
    view_label: "Conversions"
    group_label: "Goal Conversions"
    label: "Total Conversions"
    description: "Hits URL /confirmation/."
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [full_visitor_id, visit_number]

    filters: {
      field: hits.has_completed_goal
      value: "Yes"
    }
  }

  measure: total_conversions_conversion_rate {
    view_label: "Conversions"
    group_label: "Goal Conversions"
    label: "Total Conversions: Conversion Rate"
    description: "Percentage of sessions resulting in a conversion to the requested goal number."
    type: number
    sql: (1.0*${total_conversions})/NULLIF(${visits_total}, 0) ;;
    value_format_name: percent_1
  }

  measure: first_time_sessions {
    group_label: "Session"
    label: "New Sessions"
    description: "The total number of uessions for the requested time period where the visitNumber equals 1."
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: visit_number
      value: "1"
    }
  }

  measure: first_time_visitors {
    view_label: "Audience"
    group_label: "User"
    label: "New Users"
    description: "The total number of users for the requested time period where the visitNumber equals 1."
    type: count_distinct
    sql: ${full_visitor_id} ;;
    filters: {
      field: visit_number
      value: "1"
    }
  }

  measure: percent_new_sessions {
    view_label: "Audience"
    group_label: "User"
    label: "% New Sessions"
    description: "The percentage of sessions by users who had never visited the property before."
    type: number
    sql: ${first_time_visitors}/NULLIF(${visits_total}, 0) ;;
    value_format_name: percent_1
  }

  measure: returning_visitors {
    view_label: "Audience"
    group_label: "User"
    label: "Returning Users"
    description: "The total number of users for the requested time period where the visitNumber is not 1."
    type: count_distinct
    sql: ${full_visitor_id};;
    filters: {
      field: visit_number
      value: "<> 1"
    }
  }

  measure: sessions_per_user {
    alias: [average_sessions_per_visitor]
    view_label: "Audience"
    group_label: "User"
    label: "Average Sessions per User"
    description: "(Total Sessions / Unique Visitors). Should only be used at the session-level."
    type: number
    sql: ${visits_total}/NULLIF(${unique_visitors}, 0) ;;
    value_format_name: decimal_2
  }

  measure: unique_visitors {
    view_label: "Audience"
    group_label: "User"
    label: "Users"
    description: "The total number of users for the requested time period."
    type: count_distinct
    sql: ${full_visitor_id} ;;
    drill_fields: [person.person_id, account.id, visit_number, hits_total, page_views_total, time_on_site_total]
  }

##################################### GA360 BQML fields ########################
  parameter: prediction_window_days {
    type: number
  }

  dimension: x_days_future_purchases {
    type: number
    sql: (SELECT COALESCE(SUM(totals.transactions),0)
          FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` as subquery_table
          LEFT JOIN UNNEST([subquery_table.totals]) as totals
          WHERE subquery_table.fullvisitorid = ${TABLE}.fullvisitorid
            AND subquery_table.visitStarttime > ${TABLE}.visitStarttime
            AND subquery_table.visitStarttime - ${TABLE}.visitStarttime < {% parameter prediction_window_days %}*24*60*60 --X days, in seconds
           ) ;;
  }

  dimension: will_purchase_in_future {
    type: number
    sql: IF(${x_days_future_purchases} >0,1,0) ;;
  }
##################################### END - GA360 BQML fields ########################

### CUSTOM

# dimension: date {
#   hidden: yes
#   view_label: "Session"
#   group_label: "Time"
#   label: "Date"
#   description: "The date of the session formatted as YYYYMMDD."
# }
#
# dimension: date_hour_and_minute {
#   view_label: "Session"
#   group_label: "Time"
#   description: "Combined values of ga:date, ga:hour and ga:minute formated as YYYYMMDDHHMM."
#   type: string
#   sql: CASE
#            WHEN LENGTH(CAST(${hits.minute} AS STRING)) = 1
#               THEN CONCAT(${hour_of_day},'0', CAST(${hits.minute} AS STRING))
#            ELSE CONCAT(${hour_of_day},CAST(${hits.minute} AS STRING))
#          END;;
# }
#
# dimension: hour_of_day {
#   view_label: "Session"
#   group_label: "Time"
#   description: "Combined values of ga:date and ga:hour formated as YYYYMMDDHH."
#   type: string
#   sql: CONCAT(${date}, CAST(${hits.hour} AS STRING)) ;;
# }

# measure: adwords_lp_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "AdWords LP: Completions"
#   description: "Hits URL with tyvmflds. Tyvmflds is a random string of letters that we apply to ppc confirmation pages to track for goals/conversions in adwords & GA."
#   type: count_distinct
#   sql: ${id} ;;
#   drill_fields: [full_visitor_id, visit_number, transactions_count, transaction_revenue_total]
#   filters: {
#     field: hits.is_adwords_completion
#     value: "Yes"
#   }
# }
#
# measure: adwords_lp_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "AdWords LP: Conversion Rate"
#   description: "Percentage of sessions resulting in a conversion to the requested goal number."
#   type: number
#   sql: (1.0*${adwords_lp_completions})/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_1
# }
#
# # Tech debt: Connor to discuss with SME why these values are hardcoded and if there's a way to make this dynamic.
# measure: adwords_lp_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "AdWords LP: Value"
#   description: "The total numeric value for the requested goal number."
#   type: number
#   sql: ${adwords_lp_completions}+5 ;;
# }
#
# # Tech debt: Connor to discuss with SME why these values are hardcoded and if there's a way to make this dynamic.
# measure: all_confirmations_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "All Confirmations: Value"
#   description: "The total numeric value for the requested goal number."
#   type: number
#   sql: ${all_confirmation_completions}+100 ;;
# }
#
# measure: blog_subscribe_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Blog Subscribes: Completions"
#   description: "The total number of completions for the requested goal number."
#   type: count_distinct
#   sql: ${id} ;;
#   drill_fields: [full_visitor_id, visit_number, transactions_count, transaction_revenue_total]
#   filters: {
#     field: hits.is_subscribed_to_blog
#     value: "Yes"
#   }
# }
#
# measure: blog_subscribe_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Blog Subscribes: Conversion Rate"
#   description: "Percentage of sessions resulting in a conversion to the requested goal number."
#   type: number
#   sql: (1.0*${blog_subscribe_completions})/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_1
# }
#
# measure: blog_subscribe_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Blog Subscribes: Value"
#   description: "The total numeric value for the requested goal number."
#   type: number
#   sql: ${discover_lp_completions}+140 ;;
# }
#
# measure: dashboard_demo_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Dashboard Demo: Completions"
#   description: "The total number of completions for the requested goal number."
#   type: count_distinct
#   sql: ${id} ;;
#   drill_fields: [full_visitor_id, visit_number, transactions_count, transaction_revenue_total]
#   filters: {
#     field: hits.has_completed_dashboard_demo
#     value: "Yes"
#   }
# }
#
# measure: dashboard_demo_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Dashboard Demo: Conversion Rate"
#   description: "Percentage of sessions resulting in a conversion to the requested goal number."
#   type: number
#   sql: (1.0*${dashboard_demo_completions})/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_1
# }
#
# measure: data_topic_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Data Topics: Completions"
#   description: "The total number of completions for the requested goal number."
#   type: count_distinct
#   sql: ${id} ;;
#   drill_fields: [full_visitor_id, visit_number, totals.transactions_count, totals.transaction_revenue_total]
#   filters: {
#     field: hits.is_data_topic
#     value: "Yes"
#   }
# }
#
# measure: data_topic_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Data Topics: Conversion Rate"
#   description: "Percentage of sessions resulting in a conversion to the requested goal number."
#   type: number
#   sql: (1.0*${data_topic_completions})/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_1
# }
#
# measure: demo_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Demo: Completions"
#   description: "The total number of completions for the requested goal number."
#   type: count_distinct
#   sql: ${id} ;;
#   filters: {
#     field: hits.has_seen_demo_confirmation_page
#     value: "Yes"
#   }
# }
#
# measure: demo_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Demo: Conversion Rate"
#   description: "Percentage of sessions resulting in a conversion to the requested goal number."
#   type: number
#   sql: CAST(${demo_completions} AS FLOAT64)/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_2
# }
#
# # Tech debt: Connor to discuss with SME why these values are hardcoded and if there's a way to make this dynamic.
# measure: demo_conversion_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Demo: Value"
#   description: "The total numeric value for the requested goal number."
#   type: number
#   sql: ${demo_completions}+400 ;;
# }
#
# measure: discover_lp_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Discover LP: Completions"
#   description: "Hits URL SmartInsights-5StepsKPIs-Conf.html"
#   type: count_distinct
#   sql: ${id} ;;
#   drill_fields: [full_visitor_id, visit_number, transactions_count, transaction_revenue_total]
#   filters: {
#     field: hits.has_completed_discover_lp
#     value: "Yes"
#   }
# }
#
# measure: discover_lp_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Discover LP: Conversion Rate"
#   description: "Percentage of sessions resulting in a conversion to the requested goal number."
#   type: number
#   sql: (1.0*${discover_lp_completions})/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_1
# }
#
# measure: discover_lp_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Discover LP: Value"
#   description: "The total numeric value for the requested goal number."
#   type: number
#   sql: ${discover_lp_completions}+100 ;;
# }
#
#
# measure: free_trial_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Free Trial: Completions"
#   description: "The total number of completions for the requested goal number."
#   type: count_distinct
#   sql: ${id} ;;
#   drill_fields: [full_visitor_id, visit_number, transactions_count, transaction_revenue_total]
#   filters: {
#     field: hits.has_completed_free_trial
#     value: "Yes"
#   }
# }
#
# measure: free_trial_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Free Trial: Conversion Rate"
#   description: "Percentage of sessions resulting in a conversion to the requested goal number."
#   type: number
#   sql: (1.0*${free_trial_completions})/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_1
# }
#
# # Tech debt: Connor to discuss with SME why these values are hardcoded and if there's a way to make this dynamic.
# measure: free_trial_completion_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   label: "Free Trial: Value"
#   description: "The total numeric value for the requested goal number."
#   type: number
#   sql: ${free_trial_completions}+220 ;;
# }
#
# measure: goal_completions {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   description: "Total number of completions for all goals defined in the profile."
#   type: count_distinct
#   sql: ${id};;
#
#   filters: [hits.has_goal_completed: "Yes"]
# }
#
# measure: goal_conversion_rate {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   description: "The percentage of sessions which resulted in a conversion to at least one of the goals."
#   type: number
#   sql: (1.0*${goal_completions})/NULLIF(${visits_total}, 0) ;;
#   value_format_name: percent_1
# }
#
# measure: goal_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   description: "Total numeric value for all goals defined in the profile."
#   type: number
#   sql: ${demo_conversion_value} + ${discover_lp_value} + ${blog_subscribe_value}
#             + ${free_trial_completion_value} + ${adwords_lp_value}
#             + ${all_confirmations_value};;
# }
#
# measure: per_session_goal_value {
#   view_label: "Conversions"
#   group_label: "Goal Conversions"
#   description: "The average goal value of a session."
#   type: number
#   sql: ${goal_value}/NULLIF(${visits_total}, 0) ;;
# }
# dimension: is_cust_ed_resource_hostname {
#   view_label: "Behavior"
#   group_label: "Page Filters"
#   label: "Is Customer Education Host"
#   description: "Flags pages where the hostname is related to Customer Education content."
#   type: yesno
#   sql: ${hits.host_name} IN ("docs.looker.com", "help.looker.com","training.looker.com", "discourse.looker.com")
#     OR (${hits.host_name} = "looker.com" AND ${hits.page_path} LIKE "%/guide%");;
# }
# dimension: is_user_guide_host {
#   view_label: "Behavior"
#   group_label: "Page Filters"
#   description: "Flags pages where the hostname is related to User Guide content."
#   type: yesno
#   sql: ${hits.host_name} = "looker.com" AND ${hits.page_path} LIKE "%/guide%" ;;
# }
}
