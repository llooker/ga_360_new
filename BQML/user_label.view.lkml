view: user_label {
  derived_table: {
    sql: SELECT fullvisitorId, max(case when totals.transactions = 1 then 1 else 0 end) as label, min(case when totals.transactions = 1 then visitStartTime end) as event_session
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`
        GROUP BY fullvisitorId
        ;;
      sql_trigger_value: SELECT CURRENT_DATE ;;

    }




    dimension: fullvisitorId {
      primary_key: yes
    }
    dimension: label {
      type: number
      sql: ${TABLE}.label ;;
      hidden: yes
    }

    dimension: made_purchase {
      type: yesno
      sql: label = 1 ;;
    }

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
