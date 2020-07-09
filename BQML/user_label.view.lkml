view: user_label {
  derived_table: {
    sql: SELECT fullvisitorId, max(case when totals.transactions = 1 then 1 else 0 end) as label, min(case when totals.transactions = 1 then visitStartTime end) as event_session
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`
        WHERE TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d')))  BETWEEN {% date_start date_range_filter %} AND {% date_end date_range_filter %} AND geoNetwork.Country="United States"
        GROUP BY fullvisitorId
        ;;
      # sql_trigger_value: SELECT CURRENT_DATE ;;
      publish_as_db_view: yes
    }


    filter: date_range_filter {
      type: date
      default_value: "2017-02-01 12:00:00 to
      2018-07-01 14:00:00"
    }

    dimension: fullvisitorId {
      primary_key: yes
    }
    dimension: label {}

    dimension: event_session_seconds {
      type: number
      hidden: yes
      sql:${TABLE}.event_session;;
    }
    dimension_group: event_session {
      type: time
      timeframes: [
        date,
        week,
        month,
        year,
        time,
        raw
      ]
      sql: TIMESTAMP_SECONDS(${event_session_seconds}) ;;
    }
    measure: count_of_converted_users {
      type: sum
      sql: label ;;
    }


    measure: total_visits {
      type: count_distinct
      sql: ${fullvisitorId} ;;
    }

    measure: conversion_rate {
      type: number
      sql: 1.0 * ${count_of_converted_users}/nullif(${total_visits},0) ;;
      value_format_name: percent_2
    }
  }
