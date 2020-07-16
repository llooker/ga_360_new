view: calendar {
  view_label: "Session"
  extension: required

  dimension_group: current {
    description: "Current Timestamp reference field"
    type: time
    timeframes: [
      raw,
      hour_of_day,
      date,
      day_of_week,
      day_of_week_index,
      fiscal_quarter,
      fiscal_quarter_of_year,
      week,
      month,
      month_name,
      month_num,
      quarter,
      quarter_of_year,
      week_of_year,
      year
    ]
    sql: CURRENT_TIMESTAMP();;
  }

  dimension: current_day_of_quarter {
    group_label: "Current Date"
    description: "The current day of the quarter calculated as: Current Quarter Start Date - Current Date"
    type: number
    sql: DATE_DIFF(
          ${current_date}
          , DATE_TRUNC(${current_date}, QUARTER)
          , DAY
        ) ;;
  }

  dimension: current_quarter_start_date {
    group_label: "Current Date"
    type: date
    sql: DATE_TRUNC(${current_date}, QUARTER);;
    convert_tz: no
  }

  dimension: current_quarter_end_date {
    group_label: "Current Date"
    type: date
    sql: DATE_SUB(
          DATE_ADD(
            DATE_TRUNC(
              ${current_date}
              , QUARTER
            )
            , INTERVAL 3 MONTH
          )
          , INTERVAL 1 DAY
        );;
    convert_tz: no
  }

  dimension: is_current_quarter {
    group_label: "Date"
    type: yesno
    sql: ${visit_start_quarter} = ${current_quarter} ;;
  }

  dimension: is_weekend {
    view_label: "Session"
    group_label: "Date"
    description: "Use this field to exclude Saturday and Sundays from analysis"
    type: yesno
    sql: ${visit_start_day_of_week} IN ('Saturday', 'Sunday') ;;
  }

  dimension: day_of_quarter {
    group_label: "Session Start Date"
    type: number
    sql: DATE_DIFF(
          ${visit_start_date}
          , DATE_TRUNC(${visit_start_date}, QUARTER)
          , DAY
        );;
  }

  dimension: quarter_start_date {
    group_label: "Session Start Date"
    description: "First Day of each Calendar Quarter"
    type: date
    sql: DATE_TRUNC(${visit_start_date}, QUARTER) ;;
    convert_tz: no
  }

  dimension: quarter_end_date {
    group_label: "Session Start Date"
    description: "Last day of each Calendar Quarter"
    type: date
    sql: DATE_SUB(
          DATE_ADD(
            DATE_TRUNC(
              ${visit_start_date}
              , QUARTER
            )
            , INTERVAL 3 MONTH
          )
          , INTERVAL 1 DAY
        );;
    convert_tz: no
  }
}
