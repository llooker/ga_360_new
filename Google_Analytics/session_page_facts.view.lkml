#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Paola Renteria
# Created: September 2019
# Purpose: A derived table that extracts the landing page, second page, third page and fourth page for a given visitor
#############################################################################################################

view: session_page_facts {
  derived_table: {
    sql: SELECT
           ga_sessions_fullvisitorid
           , ga_sessions_visitid
           , MAX(CASE WHEN page_sequence = 1 THEN hits_page_pagetitle ELSE NULL END) AS landing_page
           , MAX(CASE WHEN page_sequence = 1 THEN hits_page_path ELSE NULL END) AS landing_page_path
           , MAX(CASE WHEN page_sequence = 2 THEN hits_page_pagetitle ELSE NULL END) AS second_page
           , MAX(CASE WHEN page_sequence = 2 THEN hits_page_path ELSE NULL END) AS second_page_path
           , MAX(CASE WHEN page_sequence = 3 THEN hits_page_pagetitle ELSE NULL END) AS third_page
           , MAX(CASE WHEN page_sequence = 3 THEN hits_page_path ELSE NULL END) AS third_page_path
           , MAX(CASE WHEN page_sequence = 4 THEN hits_page_pagetitle ELSE NULL END) AS fourth_page
           , MAX(CASE WHEN page_sequence = 4 THEN hits_page_path ELSE NULL END) AS fourth_page_path
           , count(*) AS pages_visited
           , MAX(cumulative_page_path) AS full_page_path_history
           , MAX(cumulative_page_title) AS full_page_title_history
        FROM ${session_page_sequence.SQL_TABLE_NAME}
        GROUP BY 1,2
       ;;
  }

  ########## PRIMARY KEYS ##########

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${full_visitor_id},${visit_id}) ;;
  }

  ########## FOREIGN KEYS ##########

  dimension: full_visitor_id {
    hidden: yes
    type: string
    sql: ${TABLE}.ga_sessions_fullvisitorid ;;
  }

  dimension: visit_id {
    hidden: yes
    type: string
    sql: ${TABLE}.ga_sessions_visitid;;
  }

  ########## DIMENSIONS ##########

  dimension: fourth_page {
    view_label: "Page Flow"
    group_label: "Page Title"
    label: "4th Page Title"
    description: "Fourth Page Title Visited in Session"
    sql: ${TABLE}.fourth_page ;;
  }

  dimension: fourth_page_path {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "4th Page Path"
    description: "Fourth Page Path Visited in Session"
    sql: ${TABLE}.fourth_page_path ;;
  }

  dimension: full_page_history  {
    view_label: "Session"
    group_label: "Pages Visited"
    description: "Full Path of Pages Visited in Session"
    sql: ${TABLE}.full_page_path_history  ;;
  }

  dimension: full_page_title_history  {
    view_label: "Session"
    group_label: "Pages Visited"
    description: "Full Path of Pages Visited in Session"
    sql: ${TABLE}.full_page_title_history  ;;
  }

  dimension: landing_page {
    view_label: "Page Flow"
    group_label: "Page Title"
    label: "1st Page Title"
    description: "Landing Page Title in the Session"
    sql: ${TABLE}.landing_page ;;
  }

  dimension: landing_page_path {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "1st Page Path"
    description: "Landing Page Path in Session"
    sql: ${TABLE}.landing_page_path ;;
  }

  dimension: pages_visited {
    view_label: "Session"
    group_label: "Pages Visited"
    label: "Number of Pages Visited"
    description: "Total Pages Visited in Session"
    sql: ${TABLE}.pages_visited ;;
  }

  dimension: second_page {
    view_label: "Page Flow"
    group_label: "Page Title"
    label: "2nd Page Title"
    description: "Second Page Title Visited in Session"
    sql: ${TABLE}.second_page ;;
  }

  dimension: second_page_path {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "2nd Page Path"
    description: "Second Page Path Visited in Session"
    sql: ${TABLE}.second_page_path ;;
  }

  dimension: third_page {
    view_label: "Page Flow"
    group_label: "Page Title"
    label: "3rd Page Title"
    description: "Third Page Title Visited in Session"
    sql: ${TABLE}.third_page ;;
  }

  dimension: third_page_path {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "3rd Page Path"
    description: "Third Page Path Visited in Session"
    sql: ${TABLE}.third_page_path ;;
  }

}
