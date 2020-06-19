view: funnel_explorer {
  # In this query, we retrieve, for each session, the first and last instance of each event in our sequence. If,
  # for each event, its first instance occurs before the last instance of the next event in the sequence, then
  # that is considered a completion of the sequence.
  derived_table: {
    sql: SELECT session_id
        , user_id
        , session_date
        , MIN(
            CASE WHEN
              {% condition event_1 %} event_type {% endcondition %}
              THEN session_time
              ELSE NULL END
            ) AS event_1
        , MIN(
            CASE WHEN
              {% condition event_2 %} event_type {% endcondition %}
              THEN session_time
              ELSE NULL END
            ) AS event_2
        , MIN(
            CASE WHEN
              {% condition event_3 %} event_type {% endcondition %}
              THEN session_time
              ELSE NULL END
            ) AS event_3
        , MIN(
            CASE WHEN
              {% condition event_4 %} event_type {% endcondition %}
              THEN session_time
              ELSE NULL END
            ) AS event_4
      FROM (
        SELECT CONCAT(
          CAST(fullvisitorid AS STRING)
          , '|'
          , COALESCE(CAST(visitid AS STRING),'')
          , '|'
          , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
        )  as session_id
        , sessions.userid as user_id
        , sessions.date AS session_date
        , TIMESTAMP_MILLIS(visitStarttime*1000 + time) as session_time
        , hits.eventInfo.eventAction as event_type
        , hits.hitnumber as event_sequence_number
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` AS sessions
        LEFT JOIN UNNEST(hits) as hits
        WHERE {% condition sessions_date %} _TABLE_SUFFIX {% endcondition %}
        GROUP BY 1,2,3,4,5,6
      )
      GROUP BY 1,2,3
       ;;
      persist_for: "24 hours"
  }

  filter: sessions_date {
    type: date
  }


  filter: event_1 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
  }

  filter: event_2 {
    group_label: "Funnel Events"
    suggest_explore: ga_sessions
    suggest_dimension: hits.event_action
  }

  filter: event_3 {
    group_label: "Funnel Events"
    suggest_dimension: event_type
  }

  filter: event_4 {
    group_label: "Funnel Events"
    suggest_dimension: event_type
  }

  dimension: session_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_id {
    type: string
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension_group: session_date {
    type: time
    hidden: yes
    datatype: date
    timeframes: [date, week, month, year, raw]
    sql: ${TABLE}.session_date ;;
  }

  dimension_group: event_1 {
    group_label: "Funnel Events"
    description: "First occurrence of event 1"
    type: time
    convert_tz: no
    timeframes: [time]
#     hidden: yes
    sql: ${TABLE}.event_1 ;;
  }

  dimension_group: event_2 {
    group_label: "Funnel Events"
    description: "First occurrence of event 2"
    type: time
    convert_tz: no
    timeframes: [time]
#     hidden: yes
    sql: ${TABLE}.event_2 ;;
  }


  dimension_group: event_3 {
    group_label: "Funnel Events"
    description: "First occurrence of event 3"
    type: time
    convert_tz: no
    timeframes: [time]
#     hidden: yes
    sql: ${TABLE}.event_3 ;;
  }

  dimension_group: event_4 {
    group_label: "Funnel Events"
    description: "First occurrence of event 4"
    type: time
    convert_tz: no
    timeframes: [time]
#     hidden: yes
    sql: ${TABLE}.event_4 ;;
  }

  dimension: event1_before_event2 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_1_time} < ${event_2_time} ;;
  }

  dimension: event1_before_event3 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_1_time} < ${event_3_time} ;;
  }

  dimension: event1_before_event4 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_1_time} < ${event_4_time} ;;
  }

  dimension: event2_before_event3 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_2_time} < ${event_3_time};;
  }

  dimension: event2_before_event4 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_2_time} < ${event_4_time} ;;
  }

  dimension: event3_before_event4 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_3_time} < ${event_4_time} ;;
  }

  dimension: reached_event_1 {
    hidden: yes
    type: yesno
    sql: (${event_1_time} IS NOT NULL)
      ;;
  }

  dimension: reached_event_2 {
    hidden: yes
    type: yesno
    sql: (${event_1_time} IS NOT NULL AND ${event_2_time} IS NOT NULL AND ${event_1_time} < ${event_2_time})
      ;;
  }

  dimension: reached_event_3 {
    hidden: yes
    type: yesno
    sql: (${event_1_time} IS NOT NULL AND ${event_2_time} IS NOT NULL AND ${event_3_time}  IS NOT NULL
      AND ${event_1_time} < ${event_2_time} AND ${event_1_time} < ${event_3_time} AND ${event_2_time} < ${event_3_time})
       ;;
  }

  dimension: reached_event_4 {
    hidden: yes
    type: yesno
    sql: (${event_1_time} IS NOT NULL AND ${event_2_time} IS NOT NULL AND ${event_3_time}  IS NOT NULL AND ${event_4_time} IS NOT NULL
      AND ${event_1_time} < ${event_2_time} AND ${event_1_time} < ${event_3_time} AND ${event_1_time} < ${event_4_time} AND ${event_2_time} < ${event_3_time} AND ${event_2_time} < ${event_4_time} AND ${event_3_time} < ${event_4_time})
 ;;
  }

  dimension: furthest_step {
    group_label: "Funnel Events"
    label: "Furthest Funnel Step Reached"
    case: {
      when: {
        sql: ${reached_event_4} = true ;;
        label: "4th"
      }
      when: {
        sql: ${reached_event_3} = true ;;
        label: "3rd"
      }
      when: {
        sql: ${reached_event_2} = true ;;
        label: "2nd"
      }
      when: {
        sql: ${reached_event_1} = true ;;
        label: "1st"
      }
      else: "no"
    }
  }

  dimension: event_1_before_event_2 {
    hidden: yes
    description: "Count of events 1 before 2"
    group_label: "Funnel Events"
    type: number
  }

  dimension: count_event_2 {
    hidden: yes
    type: number
  }

  dimension: event_1_ratio_event_2 {
    hidden: yes
    type: number
    sql: ${event_1_before_event_2}/${count_event_2} ;;
    value_format_name: decimal_2
  }

  measure: avg_ratio_1_to_2 {
    description: "Average of the ratio of events (where event 1 happened before event 2)"
    type: average
    sql: ${event_1_ratio_event_2} ;;
    value_format_name: decimal_2
  }

  measure: median_ratio_1_to_2 {
    description: "Median of the ratio of events (where event 1 happened before event 2)"
    type: median
    sql: ${event_1_ratio_event_2} ;;
    value_format_name: decimal_2
  }

  measure: sum_event_1_before_event_2 {
    label: "Total Events 1 Before 2"
    description: "Counts how many Event 1 occurrences there were before Event 2"
    group_label: "Funnel Events"
    type: sum
    sql: ${event_1_before_event_2} ;;
    drill_fields: [sessions.user_identifier,session_date_date,event_1_before_event_2]
  }

  measure: count_sessions_event1 {
    group_label: "Funnel Events"
    label: "Event 1"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: {
      field: furthest_step
      value: "1st,2nd,3rd,4th"
    }
  }

  measure: count_sessions_event12 {
    group_label: "Funnel Events"
    label: "Event 2"
    description: "Only includes sessions which also completed event 1"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: {
      field: furthest_step
      value: "2nd,3rd,4th"
    }
  }

  measure: count_sessions_event123 {
    group_label: "Funnel Events"
    label: "Event 3"
    description: "Only includes sessions which also completed events 1 and 2"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: {
      field: furthest_step
      value: "3rd, 4th"
    }
  }

  measure: count_sessions_event1234 {
    group_label: "Funnel Events"
    label: "Event 4"
    description: "Only includes sessions which also completed events 1, 2 and 3"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: {
      field: furthest_step
      value: "4th"
    }
  }

  measure: count {
    type: count
  }

  set: detail {
    fields: [sessions.user_identifier
      , sessions.session_index
      , session_date_date
      , event_1_time
      , event_2_time
      , event_3_time
      , event_4_time]
  }
}
