explore: event_actions {
  hidden: no
}
view: event_actions {
  derived_table: {
    explore_source: ga_sessions {
      column: event_action { field: hits.event_action }

    # TECH DEBT: DELETE
      filters: {
        field: ga_sessions.partition_date
        value: "6 years"
      }
    }
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

    # TECH DEBT: DELETE
      filters: {
        field: ga_sessions.partition_date
        value: "6 years"
      }
    }
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

      # TECH DEBT: DELETE
      filters: {
        field: ga_sessions.partition_date
        value: "6 years"
      }
    }
  }

  dimension: event_category {
  }
}


explore: top_pages {
  hidden: no
}

view: top_pages {
  derived_table: {
    explore_source: ga_sessions {
      column: page_path { field: hits.page_path_formatted }
      column: page_count { field: hits.page_count }

      sorts: [hits.page_count: desc]

      # TECH DEBT: DELETE
      filters: {
        field: ga_sessions.partition_date
        value: "6 years"
      }
    }
  }
  dimension: page_path {
  }
}
