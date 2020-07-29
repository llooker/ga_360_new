include: "../../marketing.model.lkml"

view: days_in_period {
  derived_table: {
    explore_source: ga_sessions {
      column: partition_date {}

#       derived_column: days_in_period {
#         sql: DATE_DIFF(
#               MAX(CAST(${partition_date} AS DATE)) OVER()
#               , MIN(CAST(${partition_date} AS DATE)) OVER()
#               , DAY
#             ) + 1;;
#       }
#
#       derived_column: period_start_date {
#         sql: MIN(CAST(${partition_date} AS DATE));;
#       }
      bind_all_filters: yes
    }
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
