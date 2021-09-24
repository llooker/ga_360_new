#############################################################################################################
# Purpose: Defines the fields within the totals struct in google analytics. Is extending into ga_sessions.view.lkml
#          and should not be joined into GA sessions explore as an independent view file.
#############################################################################################################


view: totals {
  extension: required
  ########## DIMENSIONS ############

  dimension: time_on_screen_total_unique {
    label: "Time On Screen Total"
    hidden: yes
    type: number
    sql: ${TABLE}.totals.timeOnScreen ;;
  }

  dimension: time_on_site {
    hidden: yes
    sql: ${TABLE}.totals.timeonsite ;;
  }

  dimension: time_on_site_tier {
    label: "Session Duration Tiers"
    description: "The length (returned as a string) of a session measured in seconds and reported in second increments."
    type: tier
    sql: ${time_on_site} ;;
    tiers: [10,30,60,120,180,240,300,600]
    style: integer
  }

  dimension: has_transaction {
    view_label: "Goals"
    group_label: "Transactions"
    description: "True if at least one transaction was completed in session."
    type: yesno
    sql: ${TABLE}.totals.transactions >= 1 ;;
  }

  ########## MEASURES ############

  measure: bounce_rate {
    group_label: "Session"
    type:  number
    sql: 1.0 * ${bounces_total} / NULLIF(${visits_total},0) ;;

    value_format_name: percent_2
  }

  measure: bounces_total {
    group_label: "Session"
    label: "Bounces"
    type: sum
    sql: ${TABLE}.totals.bounces ;;

    value_format_name: formatted_number
  }

  measure: hits_per_session {
    group_label: "Session"
    label: "Hits / Session"
    description: "The average number of hits per session. Includes both PAGE and EVENT hits."
    type: number
    sql: ${hits_total} / NULLIF(${visits_total},0);;

    value_format_name: decimal_2
  }

  measure: hits_total {
    hidden: yes
    label: "Hits"
    description: "Session-level rollup of Hits."
    type: sum
    sql: ${TABLE}.totals.hits ;;
    drill_fields: [hits.detail*]
  }

  measure: page_views_session {
    group_label: "Session"
    label: "Pages / Session"
    description: "The average number of pages viewed during a session, including repeated views of a single page."
    type: number
    sql: 1.0 * ${page_views_total} / NULLIF(${visits_total},0) ;;

    value_format_name: decimal_2
  }

  measure: page_views_total {
    hidden: yes
    description: "Session-level rollup of pageviews."
    label: "Page Views"
    type: sum
    sql: ${TABLE}.totals.pageviews ;;
  }

  measure: screen_views_total {
    # Unhide if you have mobile site
    hidden: yes
    view_label: "Behavior"
    group_label: "Screens"
    type: sum
    sql: ${TABLE}.totals.screenViews ;;

    value_format_name: formatted_number
  }

  measure: time_on_site_total {
    hidden: yes
    label: "Time On Site"
    type: sum
    sql: ${time_on_site};;
  }

  measure: timeonsite_total_formatted {
    group_label: "Session"
    label: "Time On Site"
    description: "Total duration of users' sessions."
    type: sum
    sql: ${time_on_site} / 86400;;

    value_format_name: hour_format
  }

  measure: timeonsite_average_per_session {
    group_label: "Session"
    label: "Avg. Session Duration"
    description: "Total duration of users' sessions."
    type: number
    sql: (${timeonsite_total_formatted} / NULLIF(${visits_total},0));;

    value_format_name: hour_format
  }

  measure: time_on_screen_total{
    # Unhide if you have mobile site
    hidden: yes
    view_label: "Behavior"
    group_label: "Screens"
    label: "Total Time on Page"
    description: "Time (in seconds) users spent on a particular page, calculated by subtracting the initial view time for a particular page from the initial view time for a subsequent page. This metric does not apply to exit pages of the property."
    type: sum
    sql: ${TABLE}.totals.timeOnScreen ;;
  }

  measure: transactions_count {
    view_label: "Goals"
    group_label: "Transactions"
    label: "Transactions"
    description: "Total number of ecommerce transactions within the session."
    type: sum
    sql: ${TABLE}.totals.transactions ;;

    value_format_name: formatted_number
  }

  measure: transaction_conversion_rate {
    view_label: "Goals"
    group_label: "Transactions"
    type: number
    sql: 1.0 * (${transactions_count}/NULLIF(${visits_total},0)) ;;

    value_format_name: percent_2
  }

  measure: transaction_revenue_total {
    label: "Transaction Revenue Total"
    view_label: "Goals"
    group_label: "Transactions"
    description: "Total transaction revenue, expressed as the value passed to Analytics multiplied by 10^6 (e.g., 2.40 would be given as 2400000)."
    type: sum
    sql: (${TABLE}.totals.totalTransactionRevenue/1000000) ;;

    value_format_name: usd_0
    drill_fields: [transactions_count, transaction_revenue_total]
  }

  measure: transaction_revenue_per_user {
    label: "Transaction Revenue Per User"
    view_label: "Goals"
    group_label: "Transactions"
    description: "Total transaction revenue, expressed as the value passed to Analytics multiplied by 10^6 (e.g., 2.40 would be given as 2400000), per unique visitor ID."
    type: number
    sql: ${transaction_revenue_total}/NULLIF(${ga_sessions.unique_visitors},0);;

    value_format_name: usd_0
    drill_fields: [transactions_count, transaction_revenue_total, transaction_revenue_per_user]
  }

  measure: unique_screen_views_total {
    # Unhide if you have mobile site
    hidden: yes
    view_label: "Behavior"
    group_label: "Screens"
    type: sum
    sql: ${TABLE}.totals.uniqueScreenViews ;;
  }

  measure: visits_total {
    group_label: "Session"
    label: "Sessions"
    description: "Session-level rollup of Sessions."
    type: sum
    sql: ${TABLE}.totals.visits;;

    value_format_name: formatted_number
    drill_fields: [source_medium, visits_total, new_visits_total, hits.page_count, bounces_rate, timeonsite_average_per_session]
  }
}
