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
    label: "First Touch Sessions % of Total"
    view_label: "Attribution Models"
    group_label: "First Touch % of Total"
    description: "Calculates % of total first touch sessions based on dimension grouping."
    type: percent_of_total
    sql: ${first_touch_sessions};;
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
    label: "First Touch Transactions % of Total"
    view_label: "Attribution Models"
    group_label: "First Touch % of Total"
    description: "Calculates % of total first touch transactions based on dimension grouping."
    type: percent_of_total
    sql: ${first_touch_transactions};;
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
    label: "First Touch Visitors % of Total"
    view_label: "Attribution Models"
    group_label: "First Touch % of Total"
    description: "Calculates % of total first touch Visitor based on dimension grouping."
    type: percent_of_total
    sql: ${first_touch_transactions};;
  }
}
