view: event_actions {
  derived_table: {
    sql: SELECT
        hits.eventInfo.eventAction  AS hits_event_action
      FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`  AS ga_sessions
      LEFT JOIN UNNEST(ga_sessions.hits) AS hits

      GROUP BY 1
      ORDER BY 1
      LIMIT 500
       ;;
    persist_for: "24 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hits_event {
    type: string
    sql: ${TABLE}.hits_event_action ;;
  }

  set: detail {
    fields: [hits_event]
  }
}

explore: event_actions {}