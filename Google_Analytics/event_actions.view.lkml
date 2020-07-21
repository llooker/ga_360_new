include: "../marketing.model"
include: "ga_sessions.view.lkml"

explore: event_actions {
  hidden: yes
}
view: event_actions {
  derived_table: {
    explore_source: ga_sessions {
      column: event_action { field: hits.event_action }

      bind_filters: {
        from_field: event_actions.partition_date
        to_field: ga_sessions.partition_date
      }
    }
  }

  filter: partition_date {
    type: date
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

      bind_filters: {
        from_field: event_labels.partition_date
        to_field: ga_sessions.partition_date
      }
    }
  }

  filter: partition_date {
    type: date
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

      bind_filters: {
        from_field: event_categories.partition_date
        to_field: ga_sessions.partition_date
      }
    }
  }

  filter: partition_date {
    type: date
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
      limit: 50

      bind_filters: {
        from_field: top_pages.partition_date
        to_field: ga_sessions.partition_date
      }
    }
  }

  filter: partition_date {
    type: date
  }
  dimension: page_path {
  }
}
