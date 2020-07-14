view: funnel_explorer_new {
 derived_table: {
   sql: SELECT event1.full_visitor_id as full_vistor_id,
               event1.hit_sequence_number as event1_hit_number, event1.hit_time as event1_hit_time, event1.event_action as event1_action, event1.hit_id as event1_hit_id,
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
         WHERE event1.hit_time  BETWEEN '2017-02-01 12:00:00' AND '2017-07-01 14:00:00';;
        persist_for: "24 hours"
 }

  filter: event_1 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
    default_value: "Blank"
  }

  filter: event_2 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
    default_value: "Blank"
  }

  filter: event_3 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
    default_value: "Blank"
  }

  filter: event_4 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
    default_value: "Blank"
  }

  filter: event_5 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
    default_value: "Blank"
  }

  filter: event_6 {
    group_label: "Funnel Events"
    suggest_explore: event_actions
    suggest_dimension: event_actions.hits_event
    default_value: "Blank"
  }

  dimension: event1_hit_sequence_number {
    sql: event1.full_visitor_id ;;
  }

  dimension: event1_hit_id {
  }

  dimension: hit1_time {}

#   dimension: event1_action_hit_1_time {
#     sql: CASE WHEN {% condition event_1 %} event_1_action {% endcondition %} THEN ${hit1_time}
#               ELSE NULL END ;;
#   }
#
#
#   dimension: event_1_action_id {
#     sql: CASE WHEN {% condition event_1 %} event_1_action {% endcondition %} THEN ${event1_hit_id}
#             {% if filter_2 }
#             CASE WHEN {% condition event_1 %} event_1_action {% endcondition %} AND hit1_time hit2_time OR hit2_time is NULL THEN ${event1_hit_id}
#             ELSE NULL END;;
#   }
#
#   dimension: event_2_action_id {
#     sql: CASE WHEN {% condition event_2 %} event_2_action {% endcondition %} THEN ${event1_hit_id}
#     {% if filter_3 in query}
#     CASE WHEN {% condition event_2 %} event_2_action {% endcondition %} AND hit2_time hit3_time OR hit3_time is NULL THEN ${event1_hit_id}
#     ELSE NULL END
#   }
#
#   measure: count_event_1 {
#     type: count_distinct
#     sql: ${event_1_action_id} ;;
#   }
#
#   dimension: event2_hit_id {
#   }
#
#   dimension: event_2_action_id {
#     sql: CASE WHEN {% condition event_1 %} event_1_action {% endcondition %} THEN ${event2_hit_id}
#       ELSE NULL END;;
#   }

#   measure: count_event_2 {
#     type: count_distinct
#     sql: ${event_2_action_id} ;;
#   }
#
#   dimension: event2_hit_sequence_number {
#     sql: event2.full_visitor_id ;;
#   }

#   dimension: hit_id {
#
#   }
#
#
#   dimension: hit_sequence_number {
#     hidden: no
#     type: number
#     sql: CAST(${TABLE}.hit_sequence_number as int64) ;;
#   }
#
#   dimension: hit_sequence_number_event_1 {
#     type: number
#     label: "Hit Sequence Number"
#     group_label: "Event 1"
#     sql: CASE WHEN ${event_number} = 'event1' THEN ${hit_sequence_number}
#               ELSE NULL END;;
#     hidden: no
#   }
#
#   dimension: hit_sequence_number_event_2 {
#     type: number
#     label: "Hit Sequence Number"
#     group_label: "Event 2"
#     sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
#       ELSE NULL  END;;
#     hidden: no
#   }
#
#   dimension: hit_sequence_number_event_3 {
#     type: number
#     label: "Hit Sequence Number"
#     group_label: "Event 3"
#     sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
#       ELSE  NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_sequence_number_event_4 {
#     type: number
#     label: "Hit Sequence Number"
#     group_label: "Event 4"
#     sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
#       ELSE  NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_sequence_number_event_5 {
#     type: number
#     label: "Hit Sequence Number"
#     group_label: "Event 5"
#     sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
#       ELSE  NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_sequence_number_event_6 {
#     type: number
#     label: "Hit Sequence Number"
#     group_label: "Event 6"
#     sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_sequence_number}
#       ELSE  NULL END;;
#       hidden: yes
#   }
#
#   dimension: event1_before_event2 {
#     type: yesno
#     sql: ${hit_sequence_number_event_1} + 1 = ${hit_sequence_number_event_2} ;;
#     hidden: yes
#   }
#
#   dimension: event2_before_event3 {
#     type: yesno
#     sql: ${hit_sequence_number_event_2} + 1 = ${hit_sequence_number_event_3} ;;
#     hidden: yes
#   }
#
#   dimension: event1_before_event3 {
#     type: yesno
#     sql: ${hit_sequence_number_event_1} + 2 = ${hit_sequence_number_event_3} ;;
#     hidden: yes
#   }
#
#   dimension: event3_before_event4 {
#     type: yesno
#     sql: ${hit_sequence_number_event_3} + 1 = ${hit_sequence_number_event_4} ;;
#     hidden: yes
#   }
#
#   dimension: event1_before_event4 {
#     type: yesno
#     sql: ${hit_sequence_number_event_1} + 3 = ${hit_sequence_number_event_4} ;;
#     hidden: yes
#   }
#
#   dimension: event2_before_event4 {
#     type: yesno
#     sql: ${hit_sequence_number_event_2} + 2 = ${hit_sequence_number_event_4} ;;
#     hidden: yes
#   }
#
#   dimension: event4_before_event5 {
#     type: yesno
#     sql: ${hit_sequence_number_event_4} + 1 = ${hit_sequence_number_event_5} ;;
#     hidden: yes
#   }
#
#   dimension: event1_before_event5 {
#     type: yesno
#     sql: ${hit_sequence_number_event_1} + 4 = ${hit_sequence_number_event_5} ;;
#     hidden: yes
#   }
#
#   dimension: event2_before_event5 {
#     type: yesno
#     sql: ${hit_sequence_number_event_2} + 3 = ${hit_sequence_number_event_5} ;;
#     hidden: yes
#   }
#
#   dimension: event3_before_event5 {
#     type: yesno
#     sql: ${hit_sequence_number_event_3} + 2 = ${hit_sequence_number_event_5} ;;
#     hidden: yes
#   }
#
#   dimension: event5_before_event6 {
#     type: yesno
#     sql: ${hit_sequence_number_event_5} + 1 = ${hit_sequence_number_event_6} ;;
#     hidden: yes
#   }
#
#   dimension: event1_before_event6 {
#     type: yesno
#     sql: ${hit_sequence_number_event_1} + 5 = ${hit_sequence_number_event_6} ;;
#     hidden: yes
#   }
#
#   dimension: event2_before_event6 {
#     type: yesno
#     sql: ${hit_sequence_number_event_2} + 4 = ${hit_sequence_number_event_6} ;;
#     hidden: yes
#   }
#
#   dimension: event3_before_event6 {
#     type: yesno
#     sql: ${hit_sequence_number_event_3} + 3 = ${hit_sequence_number_event_6} ;;
#     hidden: yes
#   }
#
#   dimension: event4_before_event6 {
#     type: yesno
#     sql: ${hit_sequence_number_event_4} + 2 = ${hit_sequence_number_event_6} ;;
#     hidden: yes
#   }
#
#
#
#
#
#   dimension: event_number {
#     hidden: no
#   }
#
#   dimension: full_visitor_id {}
#
#   dimension: hit_time {
#     hidden: yes
#   }
#
#   dimension: hit_time_event_1 {
#     type: date_time
#     label: "Hit Time"
#     group_label: "Event 1"
#     sql: CASE WHEN ${event_number} = 'event1' THEN ${hit_time}
#               ELSE NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_time_event_2 {
#     type: date_time
#     label: "Hit Time"
#     group_label: "Event 2"
#     sql: CASE WHEN ${event_number} = 'event2' THEN ${hit_time}
#       ELSE NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_time_event_3 {
#     type: date_time
#     label: "Hit Time"
#     group_label: "Event 3"
#     sql: CASE WHEN ${event_number} = 'event3' THEN ${hit_time}
#       ELSE NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_time_event_4 {
#     type: date_time
#     label: "Hit Time"
#     group_label: "Event 4"
#     sql: CASE WHEN ${event_number} = 'event4' THEN ${hit_time}
#       ELSE NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_time_event_5 {
#     type: date_time
#     label: "Hit Time"
#     group_label: "Event 5"
#     sql: CASE WHEN ${event_number} = 'event5' THEN ${hit_time}
#       ELSE NULL END;;
#     hidden: yes
#   }
#
#   dimension: hit_time_event_6 {
#     type: date_time
#     label: "Hit Time"
#     group_label: "Event 6"
#     sql: CASE WHEN ${event_number} = 'event6' THEN ${hit_time}
#       ELSE NULL END;;
#     hidden: yes
#   }
#
#   dimension: event_action {}
#
#
# ## Measures
#
#   measure: count_of_event_1 {
#     type: count_distinct
#     sql: ${hit_id} ;;
#
#   }
#
#   measure: count_of_event_2 {
#     type: count_distinct
#     sql: ${hit_id} ;;
#     filters: [event1_before_event2: "yes"]
#   }
#
#   measure: count_of_event_3 {
#     type: count_distinct
#     sql: ${hit_id} ;;
#     filters: [event1_before_event3: "yes", event2_before_event3: "yes"]
#   }
#
#   measure: count_of_event_4 {
#     type: count_distinct
#     sql: ${hit_id} ;;
#     filters: [event1_before_event4: "yes", event2_before_event4: "yes", event3_before_event4: "yes"]
#   }
#
#   measure: count_of_event_5 {
#     type: count_distinct
#     sql: ${hit_id} ;;
#     filters: [event1_before_event5: "yes", event2_before_event5: "yes", event3_before_event5: "yes", event4_before_event5: "yes"]
#   }
#
#   measure: count_of_event_6 {
#     type: count_distinct
#     sql: ${hit_id} ;;
#     filters: [event1_before_event6: "yes", event2_before_event6: "yes", event3_before_event6: "yes", event4_before_event6: "yes", event5_before_event6: "yes"]
#   }

}
