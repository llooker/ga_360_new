

view: user_segment_filters {
  filter: user_segment_timeframe {
    type: date
  }
  filter: user_segment_page_path {
    type: string
    suggest_dimension: hits.page_path_formatted
  }
  filter: user_segment_landing_page {
    type: string
    suggest_explore: ga_sessions
    suggest_dimension: ga_sessions.landing_page
  }
}

view: user_segment {
  label: "User Segment Evolution"
  derived_table: {
    explore_source: ga_sessions {
      column: full_visitor_id { field: ga_sessions.full_visitor_id }
      column: visits { field: ga_sessions.visits_total }
      column: transaction_revenue { field: ga_sessions.transaction_revenue_total }
      column: transaction_count { field: ga_sessions.transactions_count }
      bind_filters: {
        from_field: user_segment.user_segment_timeframe
        to_field: ga_sessions.partition_date   #bind filters to filter the table when the view is created
      }
      bind_filters: {
        from_field: user_segment.user_segment_page_path
        to_field: hits.page_path_formatted
      }
      bind_filters: {
        from_field: user_segment.user_segment_landing_page
        to_field: ga_sessions.landing_page
      }
    }
  }
  extends: [user_segment_filters]
  dimension: full_visitor_id {hidden:yes primary_key:yes}
  dimension: visits {hidden:yes}
  dimension: transaction_revenue {hidden:yes}
  dimension: transaction_count {hidden:yes}

  measure: segment_users {
    group_label: "In Selected Timeframe"
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${full_visitor_id} ;;
  }

  measure: retention_rate {
    type: number
    sql: ${segment_users}/NULLIF(${ga_sessions.unique_visitors},0) ;;
    value_format_name: percent_1
  }

  measure: segment_sessions {
    group_label: "In Selected Timeframe"
    type: sum
    sql: ${visits} ;;
    value_format_name: decimal_0
  }

  measure: segment_transaction_revenue {
    group_label: "In Selected Timeframe"
    type: sum
    sql: ${transaction_revenue} ;;
    value_format_name: usd_0
  }

  measure: segment_transaction_revenue_per_user {
    group_label: "In Selected Timeframe"
    type: number
    sql: ${segment_transaction_revenue}/NULLIF(${segment_users},0) ;;
    value_format_name: usd
  }

  measure: segment_transaction_count {
    group_label: "In Selected Timeframe"
    type: sum
    sql: ${transaction_count} ;;
    value_format_name: decimal_0
  }

  measure: segment_transaction_conversion_rate {
    group_label: "In Selected Timeframe"
    type: number
    sql: ${segment_transaction_count}/NULLIF(${segment_sessions},0) ;;
    value_format_name: percent_1
  }
}
