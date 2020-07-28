view: event_action_facts {
  derived_table: {
    explore_source: ga_sessions {
      column: hit_number { field: hits.hit_number }
      column: hit_time { field: hits.hit_time }
      column: full_visitor_id {}
      column: id {}
      column: event_action { field: hits.event_action }
      derived_column: hit_sequence_Number {sql:  ROW_NUMBER() OVER (PARTITION BY full_visitor_id ORDER BY hit_time ASC) ;;}
      derived_column: hit_id {sql:CONCAT(id,'|',FORMAT('%05d',hit_number));;}
      derived_column: next_event_hit_number {sql: LEAD(hit_number) OVER (PARTITION BY id ORDER BY hit_time ASC) ;;}
      derived_column: current_event_minus_1 {sql: LAG(event_action) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_2 {sql: LAG(event_action,2) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_3 {sql: LAG(event_action,3) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_4 {sql: LAG(event_action,4) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_5 {sql: LAG(event_action,5) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      derived_column: current_event_minus_6 {sql: LAG(event_action,6) OVER (PARTITION BY id ORDER BY hit_time) ;;}
      filters: [hits.event_action: "-NULL", ga_sessions.partition_date: "@{PARTITION_DATE_PDT_FILTER}"]
    }
    persist_for: "24 hours"
  }
  dimension: hit_number {
    description: "The sequenced hit number. For the first hit of each session, this is set to 1."
    type: number
    hidden: yes
  }
  dimension: hit_time {
    type: date_time
    hidden: yes
  }
  dimension: full_visitor_id {
    label: "Session Full User ID"
    description: "The unique visitor ID (also known as client ID)."
    hidden: yes
  }
  dimension: session_id {
    label: "Session User/Session ID"
    description: "Unique ID for Session: Full User ID | Session ID | Session Start Date"
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: hit_id {
    type: number
    hidden: yes

  }

  dimension: next_event_hit_number {
    hidden: yes
  }

  dimension: event_action {
    label: "Goal Event"
  }

  dimension: hit_sequence_number {
    type: number
    hidden: yes
  }

  dimension: current_event_minus_1  {}
  dimension: current_event_minus_2  {}
  dimension: current_event_minus_3  {}
  dimension: current_event_minus_4  {}
  dimension: current_event_minus_5  {}
  dimension: current_event_minus_6  {}



}
