#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Paola Renteria
# Created: September 2019
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

  dimension: time_on_site_tier {
    label: "Session Duration Tiers"
    description: "The length (returned as a string) of a session measured in seconds and reported in second increments."
    type: tier
    sql: ${TABLE}.totals.timeonsite ;;
    tiers: [0,15,30,60,120,180,240,300,600]
    style: integer
  }

  dimension: has_transaction {
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
    type: sum_distinct
    sql_distinct_key: ${id} ;;
    sql: ${TABLE}.totals.bounces ;;
  }

  measure: hits_average_per_session {
    group_label: "Session"
    label: "Average Hits per Session"
    description: "(Total Hits) / (Total Sessions)"
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

  measure: new_visits_total {
    hidden: yes
    type: sum
    sql: ${TABLE}.totals.newVisits ;;
  }

  measure: page_views_total {
    hidden: yes
    description: "Session-level rollup of pageviews."
    label: "Page Views"
    type: sum
    sql: ${TABLE}.totals.pageviews ;;
  }

  measure: page_views_session {
    group_label: "Session"
    label: "Pages / Session"
    description: "The average number of pages viewed during a session, including repeated views of a single page."
    type: number
    sql: 1.0 * ${page_views_total} / NULLIF(${visits_total},0) ;;
    value_format_name: decimal_2
  }

  measure: screen_views_total {
    hidden: yes
    type: sum
    sql: ${TABLE}.totals.screenViews ;;
  }

  measure: time_on_site_total {
    hidden: yes
    label: "Time On Site"
    type: sum
    sql: ${TABLE}.totals.timeonsite ;;
  }

  measure: timeonsite_total_formatted {
    group_label: "Session"
    label: "Time On Site"
    description: "Total duration of users' sessions."
    type: sum
    sql: ${TABLE}.totals.timeOnSite / 86400;;
    value_format: "[h]:mm:ss"
  }

  measure: timeonsite_average_per_session {
    group_label: "Session"
    label: "Avg. Session Duration"
    description: "Total duration of users' sessions."
    type: number
    sql: ROUND(${time_on_site_total} / NULLIF(${visits_total},0), 0);;
    # Ideal situation would use value_format: "[h]:mm:ss" as I did above, but it was not rendering correctly.
    # Used logic from: https://app.getguru.com/card/TBbG5zac/Converting-seconds-to-mmss-format to build liquid format below.
    html:
      {% assign seconds=value | modulo: 60 %}
      {% assign minutes=value | divided_by: 60 | modulo: 60 | floor %}
      {% assign hour=value | divided_by: 3600 | floor %}
      {{ hour }}:{% if minutes < 10 %}0{% endif %}{{ minutes }}:{% if seconds < 10 %}0{% endif %}{{ seconds }} ;;
  }

  measure: time_on_screen_total{
    group_label: "Pages"
    label: "Total Time on Page"
    description: "Time (in seconds) users spent on a particular page, calculated by subtracting the initial view time for a particular page from the initial view time for a subsequent page. This metric does not apply to exit pages of the property."
    hidden: yes
    type: sum
    sql: ${TABLE}.totals.timeOnScreen ;;
  }

  measure: transactions_count {
    group_label: "Session"
    label: "Transactions"
    description: "Total number of ecommerce transactions within the session."
    type: sum_distinct
    sql_distinct_key: ${id};;
    sql: ${TABLE}.totals.transactions ;;
  }

  measure: transaction_conversion_rate {
    type: number
    group_label: "Rates"
    sql: 1.0 * (${transactions_count}/NULLIF(${visits_total},0)) ;;
    value_format_name: percent_2
  }

  measure: transaction_revenue_total {
    group_label: "Session"
    label: "Transaction Revenue Total"
    description: "Total transaction revenue, expressed as the value passed to Analytics multiplied by 10^6 (e.g., 2.40 would be given as 2400000)."
    type: sum
    sql: (${TABLE}.totals.totalTransactionRevenue/1000000) ;;
    value_format_name: usd_0
    drill_fields: [transactions_count, transaction_revenue_total]
  }

  measure: visits_total {
    group_label: "Session"
    label: "Sessions"
    description: "Session-level rollup of Sessions."
    type: sum
    sql: ${TABLE}.totals.visits;;

    drill_fields: [source_medium, country, visits_total, new_visits_total, hits.page_count, bounces_rate, timeonsite_average_per_session]
  }

  measure: unique_screen_views_total {
    group_label: "Pages"
    hidden: yes
    type: sum
    sql: ${TABLE}.totals.uniqueScreenViews ;;
  }
}
