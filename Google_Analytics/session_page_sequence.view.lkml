#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Paola Renteria
# Created: September 2019
# Purpose: A derived table that returns the page sequence on a given day
#############################################################################################################

view: session_page_sequence {
  derived_table: {
    sql: SELECT
          CONCAT(
            CAST(ga_sessions.fullVisitorId AS STRING)
            , '|'
            , COALESCE(CAST(ga_sessions.visitId AS STRING),'')
            , '|'
            , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
          ) AS ga_sessions_id
         , ga_sessions.fullVisitorId AS ga_sessions_fullvisitorid
         , ga_sessions.visitId AS ga_sessions_visitid
         , hits.page.pageTitle AS hits_page_pagetitle
         , hits.page.pagePath AS hits_page_pagepath
         , CONCAT(
            hits.page.hostName
            , CASE
                WHEN STRPOS(hits.page.pagePath,'?') > 0
                  THEN SUBSTR(hits.page.pagePath, 0, STRPOS(hits.page.pagePath,'?')-1)
                ELSE hits.page.pagePath
              END
          ) AS hits_page_path
         , ga_sessions.date
         , hits.hour
         , hits.minute
         , hits.time
         , ROW_NUMBER() OVER (PARTITION BY fullVisitorId, visitId ORDER BY ga_sessions.date, hits.hour, hits.minute, hits.time) AS page_sequence
         , STRING_AGG(
            hits.page.pageTitle
            , " --> "
          ) OVER (
            PARTITION BY fullVisitorId, visitId
            ORDER BY ga_sessions.date, hits.hour, hits.minute, hits.time
          ) AS cumulative_page_title
         , STRING_AGG(
            CASE
              WHEN STRPOS(hits.page.pagePath,'?') > 0
                THEN SUBSTR(hits.page.pagePath, 0, STRPOS(hits.page.pagePath,'?')-1)
              ELSE hits.page.pagePath
            END
            , " --> "
          ) OVER (
            PARTITION BY fullVisitorId, visitId
            ORDER BY ga_sessions.date, hits.hour, hits.minute, hits.time
          ) AS cumulative_page_path
         , LAG(
            CASE
                WHEN STRPOS(hits.page.pagePath,'?') > 0
                  THEN SUBSTR(hits.page.pagePath, 0, STRPOS(hits.page.pagePath,'?')-1)
                ELSE hits.page.pagePath
              END
          ) OVER (
            PARTITION BY fullVisitorId, visitId
            ORDER BY ga_sessions.date, hits.hour, hits.minute, hits.time
          ) AS previous_page
        , LAG(hits.page.pageTitle)
          OVER (
            PARTITION BY fullVisitorId, visitId
            ORDER BY ga_sessions.date, hits.hour, hits.minute, hits.time
          ) AS previous_page_title
         , LEAD(
            CASE
              WHEN STRPOS(hits.page.pagePath,'?') > 0
                THEN SUBSTR(hits.page.pagePath, 0, STRPOS(hits.page.pagePath,'?')-1)
              ELSE hits.page.pagePath
            END
          ) OVER (
            PARTITION BY fullVisitorId, visitId
            ORDER BY ga_sessions.date, hits.hour, hits.minute, hits.time
          ) AS subsequent_page
          , LEAD(hits.page.pageTitle)
          OVER (
            PARTITION BY fullVisitorId, visitId
            ORDER BY ga_sessions.date, hits.hour, hits.minute, hits.time
          ) AS subsequent_page_title
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`  AS ga_sessions
        LEFT JOIN UNNEST(ga_sessions.hits) as hits
        WHERE {% condition ga_sessions.partition_date %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %} AND (hits.type = 'PAGE')
        GROUP BY 1,2,3,4,5,6,7,8,9,10
       ;;
  }

  ########## PRIMARY KEYS #########

  dimension: pk {
    hidden: yes
    type: string
    primary_key: yes
    sql: CONCAT(${ga_sessions_id}, CAST(${page_sequence} AS STRING)) ;;
  }

  ########## FOREIGN KEYS #########

  dimension: ga_sessions_id {
    description: "The combination the full visitor ID, the visit ID and partition date"
    hidden: yes
    type: string
    sql: ${TABLE}.ga_sessions_id ;;
  }

  dimension: full_visitor_id {
    description: "The unique visitor ID (also known as client ID)"
    hidden: yes
    type: string
    sql: ${TABLE}.ga_sessions_fullvisitorid ;;
  }

  dimension: visit_id {
    description: "An identifier for this session. This is part of the value usually stored as the _utmb cookie. This is only unique to the user. For a completely unique ID, you should use User/Session ID"
    hidden: yes
    type: string
    sql: ${TABLE}.ga_sessions_visitid;;
  }

  ########## DIMENSIONS ##########

  dimension: cumulative_navigation_path {
    view_label: "Session"
    group_label: "Pages Visited"
    description: "Cumulative page path to reach current page."
    type: string
    sql: ${TABLE}.cumulative_page_path ;;
  }

  dimension: cumulative_navigation_path_title {
    view_label: "Session"
    group_label: "Pages Visited"
    description: "Cumulative page path to reach current page (displays Page Titles)."
    type: string
    sql: ${TABLE}.cumulative_page_title ;;
  }

  dimension: date {
    description: "Date that page was viewed"
    hidden: yes
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: hour {
    description: "Hour that the page was viewed"
    hidden: yes
    type: number
    sql: ${TABLE}.hour ;;
  }

  dimension: minute {
    description: "Minute that the page was viewed"
    hidden: yes
    type: number
    sql: ${TABLE}.minute ;;
  }

  dimension: page_path {
    description: "Path of the page viewed"
    hidden: yes
    type: string
    sql: ${TABLE}.hits_page_path ;;
  }

  dimension: page_sequence {
    view_label: "Behavior"
    group_label: "Page Flow"
    description: "Order number of the page visit in the session"
    type: number
    sql: ${TABLE}.page_sequence ;;
  }

  dimension: page_title {
    description: "Title of the page viewed"
    hidden: yes
    type: string
    sql: ${TABLE}.hits_page_pagetitle ;;
  }

  dimension: previous_page {
    view_label: "Behavior"
    group_label: "Page Flow"
    description: "Prior page visited"
    type: string
    sql: ${TABLE}.previous_page ;;
  }

  dimension: previous_page_title {
    view_label: "Behavior"
    group_label: "Page Flow"
    description: "Prior page visited"
    type: string
    sql: ${TABLE}.previous_page_title ;;
  }

  dimension: subsequent_page {
    view_label: "Behavior"
    group_label: "Page Flow"
    description: "Next Page Visited"
    type: string
    sql: ${TABLE}.subsequent_page ;;
  }

  dimension: subsequent_page_title {
    view_label: "Behavior"
    group_label: "Page Flow"
    description: "Next Page Visited"
    type: string
    sql: ${TABLE}.subsequent_page_title ;;
  }
  ########## MEASURES ##########

  measure: count {
    hidden: yes
    group_label: "Pages"
    description: "Count on unique page visits. Can be used in conjunction with the Page Sequence dimension"
    type: count
    drill_fields: [detail*]
  }

  ########## SETS ##########

  set: sequence_page_info {
    fields: [
      cumulative_navigation_path,
      previous_page,
      subsequent_page,

    ]
  }

  set: detail {
    fields: [
      date,
      hour,
      minute,
      page_sequence,
      sequence_page_info*
    ]
  }
}
