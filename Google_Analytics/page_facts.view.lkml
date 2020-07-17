view: page_facts {
  derived_table: {
    explore_source: ga_sessions {
      column: hit_number { field: hits.hit_number }
      column: hit_time { field: hits.hit_time }
      column: full_visitor_id {}
      column: id {}
      column: page_path { field: hits.page_path_formatted }
      derived_column: hit_sequence_Number {sql:  ROW_NUMBER() OVER (PARTITION BY full_visitor_id ORDER BY hit_time ASC) ;;}
      derived_column: hit_id {sql:CONCAT(${id},'|',FORMAT('%05d',${hit_number}));;}
      filters: [hits.type: "PAGE"]
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
}
