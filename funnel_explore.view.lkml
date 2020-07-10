view: funnel_explore {
  derived_table: {
    sql: SELECT CONCAT(session_id, CAST(hits_hit_number as string), CAST(ga_sessions_full_visitor_id as string))
        ,   CASE WHEN
              {% condition event_1 %} event_type {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END
            AS event_1
        ,   CASE WHEN
              {% condition event_2 %} event_type {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END
            ) AS event_2
        , CASE WHEN
              {% condition event_3 %} event_type {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END
            AS event_3
        ,   CASE WHEN
              {% condition event_4 %} event_type {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END
             AS event_4
        ,   CASE WHEN
              {% condition event_4 %} event_type {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END
            AS event_5
        ,   CASE WHEN
              {% condition event_4 %} event_type {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END
             AS event_6
    FROM (SELECT
        ROW_NUMBER() OVER (PARTITION BY ga_sessions.fullVisitorId ORDER BY TIMESTAMP_MILLIS(ga_sessions.visitStarttime*1000 + hits.time) ASC) as hit_sequence_number,
        hits.hitNumber  AS hits_hit_number,
        TIMESTAMP_MILLIS(ga_sessions.visitStarttime*1000 + hits.time) AS hits_time ,
        ga_sessions.fullVisitorId  AS ga_sessions_full_visitor_id,
        hits.eventInfo.eventAction as event_type,
        CONCAT(
                CAST(fullvisitorid AS STRING)
                , '|'
                , COALESCE(CAST(visitid AS STRING),'')
                , '|'
                , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
              )  as session_id
      FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`  AS ga_sessions
      LEFT JOIN UNNEST(ga_sessions.hits) AS hits
      GROUP BY 2,3,4,5,6,  ga_sessions.visitStarttime, hits.time
      ORDER BY 3 ASC
      )
      GROUP BY 1
       ;;
  }


  filter: event_1 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
  }

  filter: event_2 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
  }

  filter: event_3 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
  }

  filter: event_4 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
  }

  filter: event_5 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
  }

  filter: event_6 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
  }

  dimension: event1_before_event2 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_1} + 1  = ${event_2} ;;
  }

  dimension: event2_before_event3 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_2} + 1  ${event_3} ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hit_sequence_number {
    type: number
    sql: ${TABLE}.hit_sequence_number ;;
  }

  dimension: hits_hit_number {
    type: number
    sql: ${TABLE}.hits_hit_number ;;
  }

  dimension_group: hits_time {
    type: time
    sql: ${TABLE}.hits_time ;;
  }

  dimension: ga_sessions_full_visitor_id {
    type: string
    sql: ${TABLE}.ga_sessions_full_visitor_id ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  set: detail {
    fields: [
      hit_sequence_number,
      hits_hit_number,
      hits_time_time,
      ga_sessions_full_visitor_id,
      event_type,
      session_id
    ]
  }
}
