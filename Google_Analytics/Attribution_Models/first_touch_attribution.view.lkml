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

  measure: first_touch {
    label: "First Touch Visitors"
    view_label: "Attribution Models"
    group_label: "First Touch"
    description: "Counts unique first touch visitors."
    type: count_distinct
    sql: ${full_visitor_id};;

    filters: {
      field: is_first_touch
      value: "yes"
    }
  }

  measure: first_touch_sessions {
    label: "First Touch Sessions"
    view_label: "Attribution Models"
    group_label: "First Touch"
    description: "Counts unique first touch sessions."
    type: count_distinct
    sql: ${id};;

    filters: {
      field: is_first_touch
      value: "yes"
    }
  }

  measure: first_touch_transactions {
    label: "First Touch Transactions"
    view_label: "Attribution Models"
    group_label: "First Touch"
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

  measure: first_touch_sessions_pct {
    label: "First Touch Sessions % of Total"
    view_label: "Attribution Models"
    group_label: "First Touch"
    description: "Counts unique first touch sessions."
    type: percent_of_total
    sql: ${first_touch_sessions};;
  }
}
