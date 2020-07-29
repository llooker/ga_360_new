include: "../../marketing.model.lkml"

view: period_over_period {
  derived_table: {
    sql:
      WITH days_in_period AS (
        SELECT
          {% date_start ga_sessions.partition_date %} AS period_start
          , {% date_end ga_sessions.partition_date %} as period_end
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` as ga_sessions
        WHERE
          TIMESTAMP(
            PARSE_DATE(
              '%Y%m%d'
              , REGEXP_EXTRACT(
                _TABLE_SUFFIX
                , r'^\d\d\d\d\d\d\d\d'
              )
            )
          ) BETWEEN {% date_start ga_sessions.partition_date %} AND {% date_end ga_sessions.partition_date %}
      )
      SELECT
        CAST(
          TIMESTAMP(
            PARSE_DATE(
              '%Y%m%d'
              , REGEXP_EXTRACT(
                _TABLE_SUFFIX
                , r'^\d\d\d\d\d\d\d\d'
              )
            )
          ) AS DATE
        ) AS partition_date,
      FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` as ga_sessions
      JOIN days_in_period ON 1=1
      WHERE TIMESTAMP(
          PARSE_DATE(
            '%Y%m%d'
            , REGEXP_EXTRACT(
              _TABLE_SUFFIX
              , r'^\d\d\d\d\d\d\d\d'
            )
          ) BETWEEN days_in_period.period_start
            AND
            DATE_ADD(
              period_end
              , INTERVAL (DATE_DIFF(period_end, period_start, DAY) + 1) DAY
          )
      ;;
  }
   dimension: visits_total {
    label: "Sessions"
    description: "Session-level rollup of Sessions."
    type: number
  }
  dimension: unique_visitors {
    label: "Users"
    description: "The total number of users for the requested time period."
    type: number
  }

  dimension: days_in_period {
    type: number
  }

  dimension: partition_date {
    label: "Date"
    description: "Date based on the day the session was added to the database. Matches date in Google Analytics UI, but may not match 'Session Start Date'."
    type: date
    convert_tz: no
  }
}
