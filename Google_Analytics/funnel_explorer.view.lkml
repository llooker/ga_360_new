view: funnel_explorer {
  # In this query, we retrieve, for each session, the first and last instance of each event in our sequence. If,
  # for each event, its first instance occurs before the last instance of the next event in the sequence, then
  # that is considered a completion of the sequence.
  derived_table: {
    sql: SELECT session_id
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
        , MIN(
            CASE WHEN
              {% condition event_4 %} event_type {% endcondition %}
              THEN session_time
              ELSE NULL END
            ) AS event_5
        , MIN(
            CASE WHEN
              {% condition event_4 %} event_type {% endcondition %}
              THEN session_time
              ELSE NULL END
            ) AS event_6
      FROM (
        SELECT CONCAT(
          CAST(fullvisitorid AS STRING)
          , '|'
          , COALESCE(CAST(visitid AS STRING),'')
          , '|'
          , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
        )  as session_id
        , TIMESTAMP_MILLIS(visitStarttime*1000 + time) as session_time
        , hits.eventInfo.eventAction as event_type
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` AS sessions
        LEFT JOIN UNNEST(hits) as hits
        GROUP BY 1,2,3
      )
      GROUP BY 1
       ;;
      persist_for: "24 hours"
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

  dimension: session_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.session_id ;;
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

  dimension_group: event_5 {
    group_label: "Funnel Events"
    description: "First occurrence of event 5"
    type: time
    convert_tz: no
    timeframes: [time]
#     hidden: yes
    sql: ${TABLE}.event_4 ;;
  }

  dimension_group: event_6 {
    group_label: "Funnel Events"
    description: "First occurrence of event 6"
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

  dimension: event1_before_event5 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_1_time} < ${event_5_time} ;;
  }

  dimension: event1_before_event6 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_1_time} < ${event_6_time} ;;
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

  dimension: event2_before_event5 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_2_time} < ${event_5_time} ;;
  }

  dimension: event2_before_event6 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_2_time} < ${event_6_time} ;;
  }

  dimension: event3_before_event4 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_3_time} < ${event_4_time} ;;
  }

  dimension: event3_before_event5 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_3_time} < ${event_5_time} ;;
  }

  dimension: event3_before_event6 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_3_time} < ${event_6_time} ;;
  }

  dimension: event4_before_event5 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_4_time} < ${event_5_time} ;;
  }

  dimension: event4_before_event6 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_4_time} < ${event_6_time} ;;
  }

  dimension: event5_before_event6 {
    group_label: "Order of Events"
    type: yesno
    hidden: yes
    sql: ${event_5_time} < ${event_6_time} ;;
  }



  measure: count_sessions_event1 {
    group_label: "Funnel Events"
    label: "Event 1"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: [event_1_time: "NOT NULL"]
  }

  measure: count_sessions_event12 {
    group_label: "Funnel Events"
    label: "Event 2"
    description: "Only includes sessions which also completed event 1"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: [event_1_time: "NOT NULL", event_2_time: "NOT NULL", event1_before_event2: "yes"]
  }

  measure: count_sessions_event123 {
    group_label: "Funnel Events"
    label: "Event 3"
    description: "Only includes sessions which also completed events 1 and 2"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: [event_1_time: "NOT NULL", event_2_time: "NOT NULL", event_3_time: "NOT NULL", event1_before_event2: "yes", event1_before_event3: "yes", event2_before_event3: "yes"]
  }

  measure: count_sessions_event1234 {
    group_label: "Funnel Events"
    label: "Event 4"
    description: "Only includes sessions which also completed events 1, 2 and 3"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: [event_1_time: "NOT NULL", event_2_time: "NOT NULL", event_3_time: "NOT NULL", event_4_time: "NOT NULL",
              event1_before_event2: "yes", event1_before_event3: "yes", event1_before_event4: "yes", event2_before_event3: "yes", event2_before_event4: "yes", event3_before_event4: "yes"]
  }

  measure: count_sessions_event12345 {
    group_label: "Funnel Events"
    label: "Event 5"
    description: "Only includes sessions which also completed events 1, 2 3, and 4"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: [event_1_time: "NOT NULL", event_2_time: "NOT NULL", event_3_time: "NOT NULL", event_4_time: "NOT NULL", event_5_time: "NOT NULL",
      event1_before_event2: "yes", event1_before_event3: "yes", event1_before_event4: "yes", event1_before_event5: "yes", event2_before_event3: "yes", event2_before_event4: "yes", event2_before_event5: "yes", event3_before_event4: "yes", event3_before_event5: "yes", event4_before_event5: "yes"]
  }

  measure: count_sessions_event123456 {
    group_label: "Funnel Events"
    label: "Event 6"
    description: "Only includes sessions which also completed events 1, 2 3, 4, and 5"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
    filters: [event_1_time: "NOT NULL", event_2_time: "NOT NULL", event_3_time: "NOT NULL", event_4_time: "NOT NULL", event_5_time: "NOT NULL", event_6_time: "NOT NULL",
      event1_before_event2: "yes", event1_before_event3: "yes", event1_before_event4: "yes", event1_before_event5: "yes", event1_before_event6: "yes", event2_before_event3: "yes", event2_before_event4: "yes", event2_before_event5: "yes", event2_before_event6: "yes", event3_before_event4: "yes", event3_before_event5: "yes", event3_before_event6: "yes", event4_before_event5: "yes", event4_before_event6: "yes", event5_before_event6: "yes"]
  }

  measure: count {
    type: count
  }

  set: detail {
    fields: [session_id]
  }
}
