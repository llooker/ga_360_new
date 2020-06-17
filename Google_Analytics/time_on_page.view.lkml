#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Paola Renteria
# Created: September 2019
# Purpose: A derived table that calculates the time on a page for a given hit ID
#############################################################################################################

view: time_on_page {
  derived_table: {
    sql:
      WITH t1 AS (
        SELECT
          CONCAT(CAST(fullVisitorId AS STRING), '|', COALESCE(CAST(visitId AS STRING),''), '|', CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)) AS id
          , hits.hitNumber
          , hits.type
          , hits.isExit
          , hits.time / 1000 AS hit_time
          , MAX(IF(hits.isInteraction IS NOT NULL,hits.time / 1000,0))
              OVER (PARTITION BY CONCAT(CAST(fullVisitorId AS STRING), '|', COALESCE(CAST(visitId AS STRING),''), '|', CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)))
              AS last_interaction
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` AS ga_sessions
        LEFT JOIN UNNEST(ga_sessions.hits) AS hits
        WHERE {% condition ga_sessions.partition_date %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %}
        )
      , t2 AS (
        SELECT
          *
          , CONCAT(id,'|',FORMAT('%05d',hitNumber)) AS hit_id
        FROM t1
        WHERE type = 'PAGE'
        )
      , t3 AS (
        SELECT
          *
          , LEAD(hit_time) OVER (PARTITION BY id ORDER BY hit_time) AS next_pageview
        FROM t2
        )
      SELECT
        hit_id
        , CASE
            WHEN isExit IS NOT NULL
              THEN last_interaction - hit_time
            ELSE next_pageview - hit_time
          END AS time_on_page
      FROM t3 ;;
  }

  ########## PRIMARY KEYS ##########

  dimension: hit_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.hit_id ;;
  }

  ########## DIMENSIONS ##########

  dimension: time_on_page {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Page Timing"
    description: "Time user spent on page. If it was the last page they visited before exiting, then time from when they entered and their last interaction on the page"
    type: number
    sql: ${TABLE}.time_on_page / 86400;;
    value_format: "[h]:mm:ss"
  }

  ########## MEASURES ##########

  measure: average_time_on_page {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Avg Time on Page"
    description: "Avg time a user spent on a specific page."
    type: average
    sql: ${time_on_page};;
    value_format: "[h]:mm:ss"
  }
}
