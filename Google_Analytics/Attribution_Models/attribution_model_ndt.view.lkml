# Created by: Connor Sparkman 2020-06-23
# Last Updated: 2020-06-23
# Point of Contact: Connor Sparkman
include: "first_touch_attribution.view.lkml"
include: "last_touch_attribution.view.lkml"
view: attribution_model_ndt {
  extends: [
    first_touch_attribution
    , last_touch_attribution
  ]
  derived_table: {
    sql:
      SELECT
        , CONCAT(
            CAST(ga_sessions.fullVisitorId AS STRING)
            , '|'
            , COALESCE(CAST(ga_sessions.visitId AS STRING),'')
            , '|'
            , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
          )  AS ga_sessions_id
        , fullVisitorId
        , TIMESTAMP_SECONDS(ga_sessions.visitStarttime)
        , CASE
            WHEN visit_number = 1
              THEN True
            ELSE False
          END as is_first_touch
        , FIRST_VALUE(
            CASE
              WHEN ga_sessions.totals.transactions >= 1
                THEN
            END IGNORE NULLS
          ) OVER (
            PARTITION BY fullVisitorId
            ORDER BY TIMESTAMP_SECONDS(ga_sessions.visitStarttime) ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
          ) = THEN True
            ELSE False
          END
      FROM ${ga_sessions.SQL_TABLE_NAME}  AS ga_sessions;;
#     explore_source: ga_sessions {
#       column: id {}
#       column: visit_id {}
#       column: full_visitor_id {}
#       column: visit_start_date {}
#       column: visit_number {}
#
#
#       ### Attribution Models ###
#       derived_column: is_first_touch {
#         sql: CASE
#               WHEN visit_number = 1
#                 THEN True
#               ELSE False
#             END;;
#       }
#
#       derived_column: is_last_touch {
#         sql: CASE
#               WHEN
#                 THEN True
#               ELSE False
#             END;;
#       }
#     }
#     persist_for: "1 hour"
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

  dimension: visit_id {
    hidden: yes
    label: "Session ID"
    description: "The unique session ID."
    sql: ${TABLE}.visit_id ;;
  }
}
