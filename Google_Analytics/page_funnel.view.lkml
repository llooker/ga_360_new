view: page_funnel {
 derived_table: {
   sql: SELECT event1.full_visitor_id as full_vistor_id,
               event1.hit_sequence_number as event1_hit_sequence_number, event1.hit_time as event1_hit_time, event1.page_path as event1_page, event1.hit_id as event1_hit_id, event1.id as event1_session_id,
               event2.hit_sequence_number as event2_hit_sequence_number, event2.hit_time as event2_time, event2.page_path as event2_page, event2.hit_id as event2_hit_id, event2.id as event2_session_id,
               event3.hit_sequence_number as event3_hit_sequence_number, event3.hit_time as event3_time, event3.page_path as event3_page,event3.hit_id as event3_hit_id, event3.id as event3_session_id,
               event4.hit_sequence_number as event4_hit_sequence_number, event4.hit_time as event4_time, event4.page_path as event4_page,event4.hit_id as event4_hit_id, event4.id as event4_session_id,
               event5.hit_sequence_number as event5_hit_sequence_number, event5.hit_time as event5_time, event5.page_path as event5_page,event5.hit_id as event5_hit_id, event5.id as event5_session_id,
               event6.hit_sequence_number as event6_hit_sequence_number, event6.hit_time as event6_time, event6.page_path as event6_page,event6.hit_id as event6_hit_id, event6.id as event6_session_id
        FROM ${page_facts.SQL_TABLE_NAME} event1
        LEFT JOIN ${page_facts.SQL_TABLE_NAME} event2
        ON event1.full_visitor_id = event2.full_visitor_id AND event1.hit_sequence_number + 1 = event2.hit_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} event3
        ON event1.full_visitor_id = event3.full_visitor_id AND event1.hit_sequence_number + 2 = event3.hit_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} event4
        ON event1.full_visitor_id = event4.full_visitor_id AND event1.hit_sequence_number + 3 = event4.hit_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} event5
        ON event1.full_visitor_id = event5.full_visitor_id AND event1.hit_sequence_number + 4 = event5.hit_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} event6
        ON event1.full_visitor_id = event6.full_visitor_id AND event1.hit_sequence_number + 5 = event6.hit_sequence_number
        ;;
        persist_for: "24 hours"
 }

  filter: page_1 {
    group_label: "Funnel Events"
    suggest_explore: top_pages
    suggest_dimension: top_pages.page_path
  }

  filter: page_2 {
    group_label: "Funnel Events"
   suggest_explore: top_pages
    suggest_dimension: top_pages.page_path
  }

  filter: page_3 {
    group_label: "Funnel Events"
   suggest_explore: top_pages
    suggest_dimension: top_pages.page_path
  }

  filter: page_4 {
    group_label: "Funnel Events"
    suggest_explore: top_pages
    suggest_dimension: top_pages.page_path
  }

  filter: page_5 {
    group_label: "Funnel Events"
   suggest_explore: top_pages
    suggest_dimension: top_pages.page_path
  }

  filter: page_6 {
    group_label: "Funnel Events"
    suggest_explore: top_pages
    suggest_dimension: top_pages.page_path
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

  dimension: event1_page {
    type: string
    sql: ${TABLE}.event1_page ;;
    hidden: yes
  }

  dimension: event1_hit_id {
    type: string
    sql: ${TABLE}.event1_hit_id ;;
    hidden: yes
  }

  dimension: event1_session_id {
    type: string
    sql: ${TABLE}.event1_session_id ;;
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

  dimension: event2_page {
    type: string
    sql: ${TABLE}.event2_page ;;
    hidden: yes
  }

  dimension: event2_hit_id {
    type: string
    sql: ${TABLE}.event2_hit_id ;;
    hidden: yes
  }

  dimension: event2_session_id {
    type: string
    sql: ${TABLE}.event2_session_id ;;
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

  dimension: event3_page {
    type: string
    sql: ${TABLE}.event3_page ;;
    hidden: yes
  }

  dimension: event3_hit_id {
    type: string
    sql: ${TABLE}.event3_hit_id ;;
    hidden: yes
  }

  dimension: event3_session_id {
    type: string
    sql: ${TABLE}.event3_session_id ;;
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

  dimension: event4_page {
    type: string
    sql: ${TABLE}.event4_page ;;
    hidden: yes
  }

  dimension: event4_hit_id {
    type: string
    sql: ${TABLE}.event4_hit_id ;;
    hidden: yes
  }

  dimension: event4_session_id {
    type: string
    sql: ${TABLE}.event4_session_id ;;
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

  dimension: event5_page {
    type: string
    sql: ${TABLE}.event5_page ;;
    hidden: yes
  }

  dimension: event5_hit_id {
    type: string
    sql: ${TABLE}.event5_hit_id ;;
    hidden: yes
  }

  dimension: event5_session_id {
    type: string
    sql: ${TABLE}.event5_session_id ;;
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

  dimension: event6_page {
    type: string
    sql: ${TABLE}.event6_page ;;
    hidden: yes
  }

  dimension: event6_hit_id {
    type: string
    sql: ${TABLE}.event6_hit_id ;;
    hidden: yes
  }

  dimension: event6_session_id {
    type: string
    sql: ${TABLE}.event6_session_id ;;
    hidden: yes
  }



  dimension: event1_hit_time_tagged {
    sql: CASE WHEN {% condition page_1 %} ${event1_page} {% endcondition %} THEN ${event1_hit_time_raw}
              ELSE NULL END ;;
    hidden: yes
  }

  dimension: event2_hit_time_tagged {
    sql: CASE WHEN {% condition page_2 %} ${event2_page} {% endcondition %} THEN ${event2_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event3_hit_time_tagged {
    sql: CASE WHEN {% condition page_3 %} ${event3_page} {% endcondition %} THEN ${event3_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event4_hit_time_tagged {
    sql: CASE WHEN {% condition page_4 %} ${event4_page} {% endcondition %} THEN ${event4_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event5_hit_time_tagged {
    sql: CASE WHEN {% condition page_5 %} ${event5_page} {% endcondition %} THEN ${event5_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: event6_hit_time_tagged {
    sql: CASE WHEN {% condition page_6 %} ${event6_page} {% endcondition %} THEN ${event6_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }


  dimension: event1_session_id_tagged {
    sql:  CASE WHEN {% condition page_1 %} ${event1_page} {% endcondition %}  THEN ${event1_session_id}
              ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event2_session_id_tagged {
    sql:
          CASE WHEN {% condition page_2 %} ${event2_page} {% endcondition %}  AND ${event1_hit_time_tagged} < ${event2_hit_time_tagged} THEN ${event2_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event3_session_id_tagged {
    sql:  CASE WHEN {% condition page_3 %} ${event3_page} {% endcondition %}  AND ${event1_hit_time_tagged} < ${event3_hit_time_tagged} AND ${event2_hit_time_tagged} < ${event3_hit_time_tagged} THEN ${event3_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event4_session_id_tagged {
    sql:  CASE WHEN {% condition page_4 %} ${event4_page} {% endcondition %} AND ${event1_hit_time_tagged} < ${event4_hit_time_tagged} AND ${event2_hit_time_tagged} < ${event4_hit_time_tagged} AND ${event3_hit_time_tagged} < ${event4_hit_time_tagged} THEN ${event4_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event5_session_id_tagged {
    sql:  CASE WHEN {% condition page_5 %} ${event5_page} {% endcondition %}  AND ${event1_hit_time_tagged} < ${event5_hit_time_tagged} AND ${event2_hit_time_tagged} < ${event5_hit_time_tagged} AND ${event3_hit_time_tagged} < ${event5_hit_time_tagged}  AND ${event4_hit_time_tagged} < ${event5_hit_time_tagged} THEN ${event5_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: event6_session_id_tagged {
    sql:  CASE WHEN {% condition page_6 %} ${event6_page} {% endcondition %} AND ${event1_hit_time_tagged} < ${event6_hit_time_tagged} AND ${event2_hit_time_tagged} < ${event6_hit_time_tagged} AND ${event3_hit_time_tagged} < ${event6_hit_time_tagged}  AND ${event4_hit_time_tagged} < ${event6_hit_time_tagged} AND ${event5_hit_time_tagged} < ${event6_hit_time_tagged} THEN ${event6_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  measure: count_of_event_1 {
    type: count_distinct
    sql: ${event1_session_id_tagged} ;;
    label: "Number of sessions with {{_filters['page_funnel.page_1']}}"
    link: {
      label: "Event Dashboard"
      url: "https://googlemarscisandbox.cloud.looker.com/dashboards/28?Page={{_filters['page_funnel.page_1']}}"
    }
  }

  measure: count_of_event_2 {
    type: count_distinct
    sql: ${event2_session_id_tagged} ;;
  }

  measure: count_of_event_3 {
    type: count_distinct
    sql: ${event3_session_id_tagged} ;;
  }

  measure: count_of_event_4 {
    type: count_distinct
    sql: ${event4_session_id_tagged} ;;
  }

  measure: count_of_event_5 {
    type: count_distinct
    sql: ${event5_session_id_tagged} ;;
  }

  measure: count_of_event_6 {
    type: count_distinct
    sql: ${event6_session_id_tagged} ;;
  }


}
