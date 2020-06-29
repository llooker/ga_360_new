# Created by: Connor Sparkman 2020-06-20
# Last Updated: June 2020
# Point of Contact: Connor Sparkman

view: last_touch_attribution {
  extension: required

########### DIMENSIONS ###########

  dimension: is_last_touch {
    view_label: "Attribution Models"
    group_label: "Type"
    description: "Flags last web visit based on Full Visitor ID."
    type: yesno
    sql: ${TABLE}.is_last_touch;;
  }

########### MEASURES ###########

  measure: last_touch_visitors {
    label: "Last Touch Visitors"
    view_label: "Attribution Models"
    description: "Counts unique last touch visitors."
    type: count_distinct
    sql: ${full_visitor_id};;

    filters: {
      field: is_last_touch
      value: "yes"
    }
  }

  measure:last_touch_sessions {
    label: "Last Touch Sessions"
    view_label: "Attribution Models"
    description: "Counts unique last touch sessions."
    type: count_distinct
    sql: ${visit_id};;

    filters: {
      field: is_last_touch
      value: "yes"
    }
  }
}
