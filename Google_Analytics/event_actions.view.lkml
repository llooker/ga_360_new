explore: event_actions {
  hidden: yes
}
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

explore: top_pages {
  hidden: yes
}

view: top_pages {
  derived_table: {
    sql:SELECT
        SPLIT(hits.page.pagePath, '?')[OFFSET(0)] as page_path,  COUNT(DISTINCT CASE WHEN (hits.type = 'PAGE') THEN CONCAT((CONCAT(
          CAST(ga_sessions.fullVisitorId AS STRING)
          , '|'
          , COALESCE(CAST(ga_sessions.visitId AS STRING),'')
          , '|'
          , CAST(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d')) AS STRING)
        )),'|',FORMAT('%05d',hits.hitNumber))  ELSE NULL END) AS hits_page_count
      FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`  AS ga_sessions
      LEFT JOIN UNNEST(ga_sessions.hits) AS hits
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 20;;
      persist_for: "24 hours"
  }

  dimension: page_path {}
}
