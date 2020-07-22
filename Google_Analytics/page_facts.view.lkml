explore: page_facts {
  hidden: no
}

view: page_facts {
  derived_table: {
    explore_source: ga_sessions {
      column: hit_number { field: hits.hit_number }
      column: hit_time { field: hits.hit_time }
      column: full_visitor_id {}
      column: id {}
      column: page_path { field: hits.page_path_formatted }
      derived_column: hit_sequence_Number {sql:  ROW_NUMBER() OVER (PARTITION BY full_visitor_id ORDER BY hit_time ASC) ;;}
      derived_column: hit_id {sql:CONCAT(id,'|',FORMAT('%05d',hit_number));;}
      derived_column: current_page_minus_1 {sql: LAG(page_path) OVER (PARTITION BY id ORDER BY hit_time DESC) ;;}
      derived_column: current_page_minus_2 {sql: LAG(page_path,2) OVER (PARTITION BY id ORDER BY hit_time DESC) ;;}
      derived_column: current_page_minus_3 {sql: LAG(page_path,3) OVER (PARTITION BY id ORDER BY hit_time DESC) ;;}
      derived_column: current_page_minus_4 {sql: LAG(page_path,4) OVER (PARTITION BY id ORDER BY hit_time DESC) ;;}
      derived_column: current_page_minus_5 {sql: LAG(page_path,5) OVER (PARTITION BY id ORDER BY hit_time DESC) ;;}
      derived_column: current_page_minus_6 {sql: LAG(page_path,6) OVER (PARTITION BY id ORDER BY hit_time DESC) ;;}
      filters: [hits.type: "PAGE", ga_sessions.partition_date: "@{PARTITION_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }
  dimension: hit_number {
    description: "The sequenced hit number. For the first hit of each session, this is set to 1."
    type: number
  }
  dimension: hit_time {
    type: date_time
  }
  dimension: full_visitor_id {
    label: "Session Full User ID"
    description: "The unique visitor ID (also known as client ID)."
  }
  dimension: id {
    label: "Session User/Session ID"
    description: "Unique ID for Session: Full User ID | Session ID | Session Start Date"
  }

  dimension: hit_id {
    type: number

  }

  dimension: page_path {
    label: "Page"
    description: "The url of the page."
  }

  dimension: hit_sequence_number {
    type: number
  }

  dimension: current_page_minus_1 {}
  dimension: current_page_minus_2 {}
  dimension: current_page_minus_3 {}
  dimension: current_page_minus_4 {}
  dimension: current_page_minus_5 {}
  dimension: current_page_minus_6 {}


}
