# Created by: Connor Sparkman 2020-06-20
# Last Updated: June 2020
# Point of Contact: Connor Sparkman

view: first_touch_attribution {
  extension: required

########### DIMENSIONS ###########

  dimension: is_first_touch {
    view_label: "Attribution Models"
    group_label: "Type"
    description: "Flags first web visit based on Full Visitor ID."
    type: yesno
    sql: ${TABLE}.is_first_touch;;
  }

########### MEASURES ###########

  measure: first_touch_sessions {
    label: "First Touch Sessions"
    view_label: "Attribution Models"
    group_label: "First Touch Counts"
    description: "Counts unique first touch sessions (i.e. visitNumber = 1)."
    type: count_distinct
    sql: ${id};;

    filters: {
      field: is_first_touch
      value: "yes"
    }
  }

  measure: first_touch_sessions_pct {
    label: "First Touch % of Total Sessions"
    view_label: "Attribution Models"
    group_label: "First Touch % of Total"
    description: "Calculates % of total first touch sessions based on dimension grouping."
    type: number
    sql: 1.0 * ${first_touch_sessions} / NULLIF(${ga_sessions.visits_total},0) ;;
    value_format_name: percent_0
  }

  measure: first_touch_transactions {
    label: "First Touch Transactions"
    view_label: "Attribution Models"
    group_label: "First Touch Counts"
    description: "Counts unique first touch sessions with a transaction."
    type: count_distinct
    sql: ${id};;

    filters: {
      field: is_first_touch
      value: "yes"
    }

    filters: {
      field: ga_sessions.has_transaction
      value: "yes"
    }
  }

  measure: first_touch_transactions_pct {
    label: "First Touch % of Total Transactions"
    view_label: "Attribution Models"
    group_label: "First Touch % of Total"
    description: "Calculates % of total first touch transactions based on dimension grouping."
    type: number
    sql: 1.0 * ${first_touch_transactions} / NULLIF(${ga_sessions.transactions_count},0) ;;
    value_format_name: percent_0
  }

  measure: first_touch_visitors {
    label: "First Touch Visitors"
    view_label: "Attribution Models"
    group_label: "First Touch Counts"
    description: "Counts unique first touch visitors."
    type: count_distinct
    sql: ${full_visitor_id};;

    filters: {
      field: is_first_touch
      value: "yes"
    }
  }

  measure: first_touch_visitors_pct {
    label: "First Touch % of Total Visitors"
    view_label: "Attribution Models"
    group_label: "First Touch % of Total"
    description: "Calculates % of total first touch Visitor based on dimension grouping."
    type: number
    sql: 1.0 * ${first_touch_visitors} / NULLIF(${ga_sessions.unique_visitors},0) ;;
    value_format_name: percent_0

  }
}
