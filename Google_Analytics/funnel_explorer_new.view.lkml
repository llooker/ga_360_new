view: funnel_explorer_new {
 derived_table: {
   sql: SELECT event1.full_visitor_id as full_vistor_id,
               event1.hit_sequence_number as event1_hit_sequence_number, event1.hit_time as event1_hit_time, event1.event_action as event1_action, event1.hit_id as event1_hit_id,
               event2.hit_sequence_number as event2_hit_sequence_number, event2.hit_time as event2_time, event2.event_action as event2_action, event2.hit_id as event2_hit_id,
               event3.hit_sequence_number as event3_hit_sequence_number, event3.hit_time as event3_time, event3.event_action as event3_action,event3.hit_id as event3_hit_id,
               event4.hit_sequence_number as event4_hit_sequence_number, event4.hit_time as event4_time, event4.event_action as event4_action,event4.hit_id as event4_hit_id,
               event5.hit_sequence_number as event5_hit_sequence_number, event5.hit_time as event5_time, event5.event_action as event5_action,event5.hit_id as event5_hit_id,
               event6.hit_sequence_number as event6_hit_sequence_number, event6.hit_time as event6_time, event6.event_action as event6_action,event6.hit_id as event6_hit_id
        FROM ${hit_facts.SQL_TABLE_NAME} event1
        LEFT JOIN ${hit_facts.SQL_TABLE_NAME} event2
        ON event1.full_visitor_id = event2.full_visitor_id AND event1.hit_sequence_number + 1 = event2.hit_sequence_number
         LEFT JOIN ${hit_facts.SQL_TABLE_NAME} event3
        ON event1.full_visitor_id = event3.full_visitor_id AND event1.hit_sequence_number + 2 = event3.hit_sequence_number
         LEFT JOIN ${hit_facts.SQL_TABLE_NAME} event4
        ON event1.full_visitor_id = event4.full_visitor_id AND event1.hit_sequence_number + 3 = event4.hit_sequence_number
         LEFT JOIN ${hit_facts.SQL_TABLE_NAME} event5
        ON event1.full_visitor_id = event5.full_visitor_id AND event1.hit_sequence_number + 4 = event5.hit_sequence_number
         LEFT JOIN ${hit_facts.SQL_TABLE_NAME} event6
        ON event1.full_visitor_id = event6.full_visitor_id AND event1.hit_sequence_number + 5 = event6.hit_sequence_number
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

  dimension: full_vistor_id {
    type: string
    sql: ${TABLE}.full_vistor_id ;;
  }

  dimension: event1_hit_sequence_number {
    type: number
    sql: ${TABLE}.event1_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: event1_hit_time {
    type: time
    sql: ${TABLE}.event1_hit_time ;;
    hidden: yes
  }

  dimension: event1_action {
    type: string
    sql: ${TABLE}.event1_action ;;
    hidden: yes
  }

  dimension: event1_hit_id {
    type: string
    sql: ${TABLE}.event1_hit_id ;;
    hidden: yes
  }

  dimension: event2_hit_sequence_number {
    type: number
    sql: ${TABLE}.event2_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: event2_time {
    type: time
    sql: ${TABLE}.event2_time ;;
    hidden: yes
  }

  dimension: event2_action {
    type: string
    sql: ${TABLE}.event2_action ;;
    hidden: yes
  }

  dimension: event2_hit_id {
    type: string
    sql: ${TABLE}.event2_hit_id ;;
    hidden: yes
  }

  dimension: event3_hit_sequence_number {
    type: number
    sql: ${TABLE}.event3_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: event3_time {
    type: time
    sql: ${TABLE}.event3_time ;;
    hidden: yes
  }

  dimension: event3_action {
    type: string
    sql: ${TABLE}.event3_action ;;
    hidden: yes
  }

  dimension: event3_hit_id {
    type: string
    sql: ${TABLE}.event3_hit_id ;;
    hidden: yes
  }

  dimension: event4_hit_sequence_number {
    type: number
    sql: ${TABLE}.event4_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: event4_time {
    type: time
    sql: ${TABLE}.event4_time ;;
    hidden: yes
  }

  dimension: event4_action {
    type: string
    sql: ${TABLE}.event4_action ;;
    hidden: yes
  }

  dimension: event4_hit_id {
    type: string
    sql: ${TABLE}.event4_hit_id ;;
    hidden: yes
  }

  dimension: event5_hit_sequence_number {
    type: number
    sql: ${TABLE}.event5_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: event5_time {
    type: time
    sql: ${TABLE}.event5_time ;;
    hidden: yes
  }

  dimension: event5_action {
    type: string
    sql: ${TABLE}.event5_action ;;
    hidden: yes
  }

  dimension: event5_hit_id {
    type: string
    sql: ${TABLE}.event5_hit_id ;;
    hidden: yes
  }

  dimension: event6_hit_sequence_number {
    type: number
    sql: ${TABLE}.event6_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: event6_time {
    type: time
    sql: ${TABLE}.event6_time ;;
    hidden: yes
  }

  dimension: event6_action {
    type: string
    sql: ${TABLE}.event6_action ;;
    hidden: yes
  }

  dimension: event6_hit_id {
    type: string
    sql: ${TABLE}.event6_hit_id ;;
    hidden: yes
  }



  dimension: event1_hit_time_tagged {
    sql: CASE WHEN {% condition event_1 %} ${event1_action} {% endcondition %} THEN ${event1_hit_time_raw}
              ELSE NULL END ;;
    hidden: yes
  }

  dimension: event2_hit_time_tagged {
    sql: CASE WHEN {% condition event_2 %} ${event2_action} {% endcondition %} THEN ${event2_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event3_hit_time_tagged {
    sql: CASE WHEN {% condition event_3 %} ${event3_action} {% endcondition %} THEN ${event3_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event4_hit_time_tagged {
    sql: CASE WHEN {% condition event_4 %} ${event4_action} {% endcondition %} THEN ${event4_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event5_hit_time_tagged {
    sql: CASE WHEN {% condition event_5 %} ${event5_action} {% endcondition %} THEN ${event5_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event6_hit_time_tagged {
    sql: CASE WHEN {% condition event_6 %} ${event6_action} {% endcondition %} THEN ${event6_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }


  dimension: event1_hit_id_tagged {
    sql:  {% if event_2._in_query %}
           CASE WHEN {% condition event_1 %} ${event1_action} {% endcondition %} AND (${event1_hit_time_tagged} < ${event2_hit_time_tagged} OR ${event2_hit_time_tagged} is NULL ) THEN ${event1_hit_id}
          {% else %}
          CASE WHEN {% condition event_1 %} ${event1_action} {% endcondition %}  THEN ${event1_hit_id}
          {% endif %}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event2_hit_id_tagged {
    sql:  {% if event_3._in_query %}
           CASE WHEN {% condition event_2 %} ${event2_action} {% endcondition %} AND (${event2_hit_time_tagged} < ${event3_hit_time_tagged} OR ${event3_hit_time_tagged} is NULL ) THEN ${event2_hit_id}
          {% else %}
          CASE WHEN {% condition event_2 %} ${event2_action} {% endcondition %}  THEN ${event2_hit_id}
          {% endif %}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event3_hit_id_tagged {
    sql:  {% if event_4._in_query %}
           CASE WHEN {% condition event_3 %} ${event3_action} {% endcondition %} AND ( ${event3_hit_time_tagged} < ${event4_hit_time_tagged} OR ${event4_hit_time_tagged} is NULL ) THEN ${event3_hit_id}
          {% else %}
          CASE WHEN {% condition event_3 %} ${event3_action} {% endcondition %}  THEN ${event3_hit_id}
          {% endif %}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event4_hit_id_tagged {
    sql:  {% if event_5._in_query %}
           CASE WHEN {% condition event_4 %} ${event4_action} {% endcondition %} AND (${event4_hit_time_tagged} < ${event5_hit_time_tagged} OR ${event5_hit_time_tagged} is NULL ) THEN ${event4_hit_id}
          {% else %}
          CASE WHEN {% condition event_4 %} ${event4_action} {% endcondition %}  THEN ${event4_hit_id}
          {% endif %}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event5_hit_id_tagged {
    sql:  {% if event_6._in_query %}
           CASE WHEN {% condition event_5 %} ${event5_action} {% endcondition %} AND (${event5_hit_time_tagged} < ${event6_hit_time_tagged} OR ${event6_hit_time_tagged} is NULL ) THEN ${event5_hit_id}
          {% else %}
          CASE WHEN {% condition event_5 %} ${event5_action} {% endcondition %}  THEN ${event5_hit_id}
          {% endif %}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event6_hit_id_tagged {
    sql:  CASE WHEN {% condition event_6 %} ${event6_action} {% endcondition %}  THEN ${event6_hit_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  measure: count_of_event_1 {
    type: count_distinct
    sql: ${event1_hit_id_tagged} ;;
  }

  measure: count_of_event_2 {
    type: count_distinct
    sql: ${event2_hit_id_tagged} ;;
  }

  measure: count_of_event_3 {
    type: count_distinct
    sql: ${event3_hit_id_tagged} ;;
  }

  measure: count_of_event_4 {
    type: count_distinct
    sql: ${event4_hit_id_tagged} ;;
  }

  measure: count_of_event_5 {
    type: count_distinct
    sql: ${event5_hit_id_tagged} ;;
  }

  measure: count_of_event_6 {
    type: count_distinct
    sql: ${event6_hit_id_tagged} ;;
  }


}
