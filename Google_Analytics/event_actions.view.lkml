# Purpose of file is to generate distinct values from nested fields to be used in filter fields

include: "ga_sessions.view.lkml"

explore: event_actions {
  hidden: yes
}
view: event_actions {
  derived_table: {
    explore_source: ga_sessions {
      column: event_action { field: hits.event_action }

      filters: [ga_sessions.partition_date: "@{PARTITION_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }

  dimension: event_action {
  }
}

explore: event_labels {
  hidden: yes
}
view: event_labels {
  derived_table: {
    explore_source: ga_sessions {
      column: event_label { field: hits.event_label }

      filters: [ga_sessions.partition_date: "@{PARTITION_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }

  dimension: event_label {
  }
}


explore: event_categories {
  hidden: yes
}
view: event_categories {
  derived_table: {
    explore_source: ga_sessions {
      column: event_category { field: hits.event_category }

      filters: [ga_sessions.partition_date: "@{PARTITION_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }

  dimension: event_category {
  }
}


explore: top_pages {
  hidden: yes
}

view: top_pages {
  derived_table: {
    explore_source: ga_sessions {
      column: page_path { field: hits.page_path_formatted }
      column: page_count { field: hits.page_count }

      filters: [ga_sessions.partition_date: "@{PARTITION_DATE_FILTER}"]
      sorts: [hits.page_count: desc]
      limit: 50
    }
    persist_for: "24 hours"
  }

  dimension: page_path {
  }
}
