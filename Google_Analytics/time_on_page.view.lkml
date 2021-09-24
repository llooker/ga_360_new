#############################################################################################################
# Purpose: A derived table that calculates the time on a page for a given hit ID
# Numbers will not match Google Analytics UI because the PDT calculates Time on Page for Exit pages, which GA does not.
# - Time on the final page of a session is calculated by the difference between start of the final page visit and the last EVENT recorded on the page.
#############################################################################################################


view: time_on_page {
  
  derived_table: {
    persist_for: "1 hour"
    sql:
      WITH raw_hit_data AS (
        SELECT
          CONCAT(
            CAST(fullVisitorId AS STRING), '|'
            , COALESCE(CAST(visitId AS STRING),''), '|'
            , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
          ) AS session_id
          , fullVisitorId as full_visitor_id
          , visitStartTime as visit_start_time
          , hits.hitNumber as hit_number
          , hits.type as hit_type
          , hits.isExit as is_exit
          , hits.time AS hit_time
          , MAX(
              IF(
                hits.type = "EVENT"
                , hits.time
                , 0
              )
            ) OVER (PARTITION BY fullVisitorId, visitStartTime) AS last_event
        FROM ${ga_sessions.SQL_TABLE_NAME} AS ga_sessions
        LEFT JOIN UNNEST(ga_sessions.hits) AS hits
        WHERE {% condition ga_sessions.partition_date %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %}
      )
      , pages AS (
          SELECT
            *
            , CONCAT(session_id,'|',FORMAT('%05d', hit_number)) AS hit_id
          FROM raw_hit_data
          WHERE hit_type = 'PAGE'
        )
      , next_pageview AS (
          SELECT
            *
            , LEAD(hit_time) OVER (PARTITION BY full_visitor_id, visit_start_time ORDER BY hit_time) AS next_pageview_time
            , IF(last_event > hit_time, true, false) as last_event_after_page_start
          FROM pages
        )
      SELECT
        hit_id
        , last_event
        -- Calculate time on page
        , CASE
            -- Calculate time between pages when it is not the last page
            WHEN is_exit IS NULL
              THEN (next_pageview_time - hit_time)
            -- Calculate time on last page as long as last Event happened on that page
            WHEN last_event_after_page_start
              THEN (last_event - hit_time)
            -- Calculate time on page in Days to  value_format
          END / 1000.0 / 86400.0 AS time_on_page
      FROM next_pageview ;;
  }

  ########## PRIMARY KEYS ##########

  dimension: hit_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.hit_id ;;
  }

  ########## DIMENSIONS ##########

  dimension: has_time_on_page {
    hidden: yes
    type: yesno
    sql: ${TABLE}.time_on_page IS NOT NULL ;;
  }

  dimension: last_event {
    hidden: yes
    group_label: "Time on Page"
    description: "Last event hit found during web session."
    type: number
    sql: ${TABLE}.last_event;;
  }

  dimension: time_on_page {
    group_label: "Time on Page"
    description: "Time user spent on page. If it was the last page they visited before exiting, then time from when they entered and their last event on the page"
    type: number
    sql: ${TABLE}.time_on_page;;
    value_format_name: hour_format
  }

  ########## MEASURES ##########

  measure: average_time_on_page {
    label: "Avg Time on Page"
    group_label: "Pages"
    description: "Avg time a user spent on a specific page."
    type: number
    sql: (${total_time_on_page} / NULLIF(${total_pages_with_time}, 0));;
    value_format_name: hour_format
  }

  measure: total_time_on_page {
    group_label: "Pages"
    description: "Total Time spent on page."
    type: sum
    sql: ${time_on_page};;
    value_format_name: hour_format
  }

  measure: total_pages_with_time {
    hidden: yes
    description: "Total pages with a time on page calculated"
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${hit_id};;

    filters: [has_time_on_page: "yes"]
  }
}
