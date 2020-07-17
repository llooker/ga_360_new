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
include: "calendar.view.lkml"

view: ga_sessions {
  view_label: "Session"
  sql_table_name: `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` ;;
  extends: [calendar, geonetwork, totals, traffic_source, device]

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


  dimension_group: partition {
    view_label: "Session"
    description: "Date that is parsed from the table name. Required as a filter to avoid accidental massive queries."
    type: time
    sql: PARSE_DATE(
          '%Y%m%d'
          , REGEXP_EXTRACT(
            _TABLE_SUFFIX
            , r'^\d\d\d\d\d\d\d\d'
          )
        );;
    datatype: date
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
      day_of_week_index,
      day_of_month,
      day_of_year,
      fiscal_quarter,
      fiscal_quarter_of_year,
      week,
      month,
      month_name,
      month_num,
      quarter,
      quarter_of_year,
      week_of_year,
      year
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
}
