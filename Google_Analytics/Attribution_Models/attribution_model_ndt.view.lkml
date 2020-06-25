# Created by: Connor Sparkman 2020-06-23
# Last Updated: 2020-06-23
# Point of Contact: Connor Sparkman
include: "first_touch_attribution.view.lkml"
view: attribution_model_ndt {
  extends: [first_touch_attribution]
  derived_table: {
    explore_source: ga_sessions {
      column: id {}
      column: visit_id {}
      column: full_visitor_id {}
      column: visit_start_date {}

      ### Attribution Models ###
      derived_column: is_first_touch {
        sql: CASE
              WHEN FIRST_VALUE(id)
                OVER (
                  PARTITION BY full_visitor_id
                  ORDER BY visit_start_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) = id
                THEN True
              ELSE False
            END;;
      }
    }
    persist_for: "1 hour"
  }


########## PRIMARY KEY ##########
  dimension: id {
    hidden: yes
    primary_key: yes
    label: "User/Session ID"
    description: "Unique ID for Session: Full User ID | Session ID | Session Start Date"
    sql: ${TABLE}.id ;;
  }

########## FOREIGN KEYS ##########
  dimension: full_visitor_id {
    hidden: yes
    label: "Full User ID"
    description: "The unique visitor ID."
    sql: ${TABLE}.full_visitor_id ;;
  }
}
