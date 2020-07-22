# Created by: Connor Sparkman 2020-06-23
# Last Updated: 2020-06-23
# Point of Contact: Connor Sparkman
include: "first_touch_attribution.view.lkml"
view: attribution_model_pdt {
  extends: [
    first_touch_attribution
  ]
  derived_table: {
    sql:
      SELECT
        CONCAT(
            CAST(ga_sessions.fullVisitorId AS STRING)
            , '|'
            , COALESCE(CAST(ga_sessions.visitId AS STRING),'')
            , '|'
            , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
          )  AS ga_sessions_id
        , fullVisitorId AS full_visitor_id
        , CASE
            WHEN visitNumber = 1
              THEN True
            ELSE False
          END as is_first_touch
      FROM ${ga_sessions.SQL_TABLE_NAME}  AS ga_sessions
       WHERE {% condition ga_sessions.partition_date %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %};;
    persist_for: "1 hour"
  }


########## PRIMARY KEY ##########
  dimension: id {
    hidden: yes
    primary_key: yes
    label: "User/Session ID"
    description: "Unique ID for Session: Full User ID | Session ID | Session Start Date"
    sql: ${TABLE}.ga_sessions_id ;;
  }

########## FOREIGN KEYS ##########
  dimension: full_visitor_id {
    hidden: yes
    label: "Full User ID"
    description: "The unique visitor ID."
    sql: ${TABLE}.full_visitor_id ;;
  }
}
