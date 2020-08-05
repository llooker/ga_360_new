include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/Custom_Views/event_action_facts.view.lkml"

view: event_action_facts {
  extends: [event_action_facts_config]
}

view: event_action_facts_core {
  extension: required
  derived_table: {
    explore_source: ga_sessions {
      column: hit_number { field: hits.hit_number }
      column: hit_time { field: hits.hit_time }
      column: full_visitor_id {}
      column: id {}
      column: event_action { field: hits.event_action }
      derived_column: event_sequence_Number {sql:  ROW_NUMBER() OVER (PARTITION BY id ORDER BY hit_time ASC) ;;}
      derived_column: hit_id {sql:CONCAT(id,'|',FORMAT('%05d',hit_number));;}
      derived_column: next_event_hit_number {sql: LEAD(hit_number) OVER (PARTITION BY id ORDER BY hit_time ASC) ;;}
      derived_column: current_event_minus_1 {sql: LAG(event_action) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_2 {sql: LAG(event_action,2) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_3 {sql: LAG(event_action,3) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_4 {sql: LAG(event_action,4) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_5 {sql: LAG(event_action,5) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_6 {sql: LAG(event_action,6) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_plus_1 {sql: LEAD(event_action) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_plus_2 {sql: LEAD(event_action,2) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_plus_3 {sql: LEAD(event_action,3) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_plus_4 {sql: LEAD(event_action,4) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_plus_5 {sql: LEAD(event_action,5) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_plus_6 {sql: LEAD(event_action,6) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      filters: [hits.event_action: "-NULL", ga_sessions.partition_date: "@{PDT_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }


  ########## PRIMARY KEY ##########

  dimension: hit_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.hit_id ;;
  }

  ########## FOREIGN KEY ##########

  dimension: full_visitor_id {
    label: "Session Full User ID"
    description: "The unique visitor ID (also known as client ID)."
    hidden: yes
    sql: ${TABLE}.full_visitor_id ;;
  }
  dimension: session_id {
    label: "Session User/Session ID"
    description: "Unique ID for Session: Full User ID | Session ID | Session Start Date"
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  ########## DIMENSIONS ##########

  dimension: hit_number {
    description: "The sequenced hit number. For the first hit of each session, this is set to 1."
    type: number
    hidden: yes
    sql: ${TABLE}.hit_number ;;
  }
  dimension_group: hit_time {
    description: "The time at which the hit occurred"
    type: time
    hidden: yes
    datatype: datetime
    sql: ${TABLE}.hit_time ;;
  }

  dimension: next_event_hit_number {
    hidden: yes
  }

  dimension: event_action {
    label: "Goal Event"
  }

  dimension: event_sequence_number {
    type: number
    hidden: yes

  }

  dimension: current_event_minus_1  {
    type: string
    sql: ${TABLE}.current_event_minus_1 ;;
    group_label: "Reverse Event Flow"
  }
  dimension: current_event_minus_2  {
    type: string
    sql: ${TABLE}.current_event_minus_2 ;;
    group_label: "Reverse Event Flow"
  }
  dimension: current_event_minus_3  {
    type: string
    sql: ${TABLE}.current_event_minus_3 ;;
    group_label: "Reverse Event Flow"
  }
  dimension: current_event_minus_4  {
    type: string
    sql: ${TABLE}.current_event_minus_4 ;;
    group_label: "Reverse Event Flow"
  }
  dimension: current_event_minus_5  {
    type: string
    sql: ${TABLE}.current_event_minus_5 ;;
    group_label: "Reverse Event Flow"
  }
  dimension: current_event_minus_6  {
    type: string
    sql: ${TABLE}.current_event_minus_6 ;;
    group_label: "Reverse Event Flow"
  }

  dimension: current_event_plus_1  {
    type: string
    sql: ${TABLE}.current_event_plus_1 ;;
    group_label: "Event Flow"
  }

  dimension: current_event_plus_2  {
    type: string
    sql: ${TABLE}.current_event_plus_2 ;;
    group_label: "Event Flow"
  }


  dimension: current_event_plus_3  {
    type: string
    sql: ${TABLE}.current_event_plus_3 ;;
    group_label: "Event Flow"
  }


  dimension: current_event_plus_4  {
    type: string
    sql: ${TABLE}.current_event_plus_4 ;;
    group_label: "Event Flow"
  }


  dimension: current_event_plus_5  {
    type: string
    sql: ${TABLE}.current_event_plus_5 ;;
    group_label: "Event Flow"
  }


  dimension: current_event_plus_6  {
    type: string
    sql: ${TABLE}.current_event_plus_6 ;;
    group_label: "Event Flow"
  }


}
