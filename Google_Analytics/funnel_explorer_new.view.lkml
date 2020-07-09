view: funnel_explorer_new {
 derived_table: {
   sql: SELECT CONCAT(id, CAST(hit_number as string), CAST(full_visitor_id as string)) as hit_id
        ,   CASE WHEN
              {% condition event_1 %} event_action {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END AS hit_sequence_number, 'event1' as event_number, full_visitor_id, hit_time, event_action FROM ${hit_facts.SQL_TABLE_NAME}
        UNION ALL
        SELECT CONCAT(id, CAST(hit_number as string), CAST(full_visitor_id as string)) as hit_id
        ,   CASE WHEN
              {% condition event_2 %} event_action {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END AS hit_sequence_number, 'event2' as event_number, full_visitor_id, hit_time, event_action FROM ${hit_facts.SQL_TABLE_NAME}
        UNION ALL
        SELECT CONCAT(id, CAST(hit_number as string), CAST(full_visitor_id as string)) as hit_id
        ,   CASE WHEN
              {% condition event_3 %} event_action {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END AS hit_sequence_number, 'event3' as event_number, full_visitor_id, hit_time, event_action FROM ${hit_facts.SQL_TABLE_NAME}
        UNION ALL
        SELECT CONCAT(id, CAST(hit_number as string), CAST(full_visitor_id as string)) as hit_id
        ,   CASE WHEN
              {% condition event_4 %} event_action {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END AS hit_sequence_number, 'event4' as event_number, full_visitor_id, hit_time, event_action FROM ${hit_facts.SQL_TABLE_NAME}
        UNION ALL
        SELECT CONCAT(id, CAST(hit_number as string), CAST(full_visitor_id as string)) as hit_id
        ,   CASE WHEN
              {% condition event_5 %} event_action {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END AS hit_sequence_number, 'event5' as event_number, full_visitor_id, hit_time, event_action FROM ${hit_facts.SQL_TABLE_NAME}
        UNION ALL
        SELECT CONCAT(id, CAST(hit_number as string), CAST(full_visitor_id as string)) as hit_id
        ,   CASE WHEN
              {% condition event_6 %} event_action {% endcondition %}
              THEN hit_sequence_number
              ELSE NULL END AS hit_sequence_number, 'event6' as event_number, full_visitor_id, hit_time, event_action FROM ${hit_facts.SQL_TABLE_NAME} ;;
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

  dimension: hit_id {

  }

  dimension: hit_sequence_number {
    hidden: yes
  }

  dimension: hit_sequence_number_event_1 {
    type: number
    label: "Hit Sequence Number"
    group_label: "Event 1"
    sql: CASE WHEN ${event_number} = 'event1' THEN ${hit_sequence_number}
              ELSE NULL END;;
    hidden: yes
  }

  dimension: hit_sequence_number_event_2 {
    type: number
    label: "Hit Sequence Number"
    group_label: "Event 2"
    sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
      ELSE NULL  END;;
    hidden: yes
  }

  dimension: hit_sequence_number_event_3 {
    type: number
    label: "Hit Sequence Number"
    group_label: "Event 3"
    sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
      ELSE  NULL END;;
    hidden: yes
  }

  dimension: hit_sequence_number_event_4 {
    type: number
    label: "Hit Sequence Number"
    group_label: "Event 4"
    sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
      ELSE  NULL END;;
    hidden: yes
  }

  dimension: hit_sequence_number_event_5 {
    type: number
    label: "Hit Sequence Number"
    group_label: "Event 5"
    sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
      ELSE  NULL END;;
    hidden: yes
  }

  dimension: hit_sequence_number_event_6 {
    type: number
    label: "Hit Sequence Number"
    group_label: "Event 6"
    sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
      ELSE  NULL END;;
      hidden: yes
  }

  dimension: event1_before_event2 {
    type: yesno
    sql: ${hit_sequence_number_event_1} + 1 = ${hit_sequence_number_event_2} ;;
  }


  dimension: event_number {
    hidden: yes
  }

  dimension: full_visitor_id {}

  dimension: hit_time {
    hidden: yes
  }

  dimension: hit_time_event_1 {
    type: date_time
    label: "Hit Time"
    group_label: "Event 1"
    sql: CASE WHEN ${event_number} = 'event1' THEN ${hit_time}
              ELSE NULL END;;
    hidden: yes
  }

  dimension: hit_time_event_2 {
    type: date_time
    label: "Hit Time"
    group_label: "Event 2"
    sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_time}
      ELSE NULL END;;
    hidden: yes
  }

  dimension: hit_time_event_3 {
    type: date_time
    label: "Hit Time"
    group_label: "Event 3"
    sql: CASE WHEN ${event_number} = 'event3' THEN ${hit_time}
      ELSE NULL END;;
    hidden: yes
  }

  dimension: hit_time_event_4 {
    type: date_time
    label: "Hit Time"
    group_label: "Event 4"
    sql: CASE WHEN ${event_number} = 'event4' THEN ${hit_time}
      ELSE NULL END;;
    hidden: yes
  }

  dimension: hit_time_event_5 {
    type: date_time
    label: "Hit Time"
    group_label: "Event 5"
    sql: CASE WHEN ${event_number} = 'event5' THEN ${hit_time}
      ELSE NULL END;;
    hidden: yes
  }

  dimension: hit_time_event_6 {
    type: date_time
    label: "Hit Time"
    group_label: "Event 6"
    sql: CASE WHEN ${event_number} = 'event6' THEN ${hit_time}
      ELSE NULL END;;
    hidden: yes
  }

  dimension: event_action {}

}
