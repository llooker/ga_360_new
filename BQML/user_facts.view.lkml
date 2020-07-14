view: user_facts {
  derived_table: {
    sql: WITH filtered_base AS (
        SELECT * FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`
        WHERE TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d')))  BETWEEN START_DATE AND END_DATE),

    user_label AS (
      SELECT fullvisitorId, max(case when totals.transactions >= 1 then 1 else 0 end) as label, min(case when totals.transactions >= 1 then visitStartTime end) as event_session
        FROM filtered_base
        GROUP BY fullvisitorId),

    unique_hour_of_day AS(
      (SELECT   ga_sessions_visit_start_hour_of_day, fullVisitorId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY fullVisitorId ORDER BY   pageviews) as row_number, fullVisitorId, ga_sessions_visit_start_hour_of_day
      FROM (SELECT ga_sessions.fullVisitorId as fullvisitorid, EXTRACT(HOUR FROM TIMESTAMP_SECONDS(ga_sessions.visitStarttime)) AS ga_sessions_visit_start_hour_of_day, SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions  LEFT JOIN user_label ON ga_sessions.fullvisitorid = user_label.fullvisitorid  @{QUERY_FILTER_2}  GROUP BY 1,2)) WHERE row_number = 1)),


      unique_dma AS(
      (SELECT   metro, fullVisitorId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY fullVisitorId ORDER BY   pageviews) as row_number, fullVisitorId, metro
      FROM (SELECT ga_sessions.fullVisitorId as fullvisitorid, ga_sessions.geoNetwork.metro as metro , SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.fullvisitorid = user_label.fullvisitorid @{QUERY_FILTER_2}  GROUP BY 1,2)) WHERE row_number = 1)),

      unique_day_of_week AS(
      (SELECT   ga_sessions_visit_start_day_of_week, fullVisitorId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY fullVisitorId ORDER BY   pageviews) as row_number, fullVisitorId, ga_sessions_visit_start_day_of_week
      FROM (SELECT ga_sessions.fullVisitorId as fullvisitorid, FORMAT_TIMESTAMP('%A', TIMESTAMP_SECONDS(ga_sessions.visitStarttime)) AS ga_sessions_visit_start_day_of_week  , SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.fullvisitorid = user_label.fullvisitorid  @{QUERY_FILTER_2} GROUP BY 1,2)) WHERE row_number = 1)),

      unique_browser AS(
      (SELECT   ga_sessions_browser, fullVisitorId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY fullVisitorId ORDER BY   pageviews) as row_number, fullVisitorId, ga_sessions_browser
      FROM (SELECT ga_sessions.fullVisitorId as fullvisitorid, ga_sessions.device.browser  AS ga_sessions_browser , SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.fullvisitorid = user_label.fullvisitorid  @{QUERY_FILTER_2}  GROUP BY 1,2)) WHERE row_number = 1)),

      unique_traffic_source AS(
      (SELECT   ga_sessions_source, fullVisitorId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY fullVisitorId ORDER BY   pageviews) as row_number, fullVisitorId, ga_sessions_source
      FROM (SELECT ga_sessions.fullVisitorId as fullvisitorid, ga_sessions.trafficsource.medium  AS ga_sessions_source, SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.fullvisitorid = user_label.fullvisitorid  @{QUERY_FILTER_2}  GROUP BY 1,2)) WHERE row_number = 1)),

      agg_metrics AS (  SELECT  ga_sessions.fullvisitorid, count(distinct visitId) as total_sessions,
        sum(totals.pageviews) as pageviews,
        count(totals.bounces)/count(distinct VisitID) as bounce_rate,
        sum(totals.pageviews) / count(distinct VisitID) as avg_session_depth,
        count(distinct geoNetwork.metro) as distinct_dmas,
        count(distinct EXTRACT(DAYOFWEEK FROM PARSE_DATE('%Y%m%d', date))) as num_diff_days_visited,

        sum(case when trafficSource.medium = '(none)' then 1 else 0 end) as visits_traffic_source_none,
    sum(case when trafficSource.medium = 'organic' then 1 else 0 end) as visits_traffic_source_organic,
    sum(case when trafficSource.medium = 'cpc' then 1 else 0 end) as visits_traffic_source_cpc,
    sum(case when trafficSource.medium = 'cpm' then 1 else 0 end) as visits_traffic_source_cpm,
    sum(case when trafficSource.medium = 'affiliate' then 1 else 0 end) as visits_traffic_source_affiliate,
    sum(case when trafficSource.medium = 'referral' then 1 else 0 end) as visits_traffic_source_referral
        FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`  AS ga_sessions LEFT JOIN user_label ON ga_sessions.fullvisitorid = user_label.fullvisitorid
        @{QUERY_FILTER_2}   GROUP BY 1 )


      SELECT user_label.fullvisitorid, label,ga_sessions_visit_start_hour_of_day, metro, ga_sessions_visit_start_day_of_week,ga_sessions_browser, ga_sessions_source,
      total_sessions, pageviews, bounce_rate, avg_session_depth, visits_traffic_source_none, visits_traffic_source_organic, visits_traffic_source_cpc,  visits_traffic_source_cpm, visits_traffic_source_affiliate,
      visits_traffic_source_referral, distinct_dmas
      FROM agg_metrics
      LEFT JOIN unique_hour_of_day ON agg_metrics.fullvisitorid = unique_hour_of_day.fullvisitorid
      LEFT JOIN unique_dma ON agg_metrics.fullvisitorid = unique_dma.fullvisitorid
      LEFT JOIN unique_day_of_week ON agg_metrics.fullvisitorid = unique_day_of_week.fullvisitorid
      LEFT JOIN unique_browser ON agg_metrics.fullvisitorid = unique_browser.fullvisitorid
      LEFT JOIN unique_traffic_source ON unique_traffic_source.fullvisitorid = agg_metrics.fullvisitorid
      LEFT JOIN user_label ON agg_metrics.fullvisitorid = user_label.fullvisitorid
       ;;
      persist_for: "24 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: date_range_filter {
    type: date
    default_value: "2017-02-01 12:00:00 to
    2018-07-01 14:00:00"
  }


  # dimension: partition_date {
  #   type: date_time
  #   sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d')))  ;;
  # }

  dimension: fullvisitorid {
    type: string
    sql: ${TABLE}.fullvisitorid ;;
  }

  dimension: label {
    type: number
    sql: ${TABLE}.label ;;
  }

  dimension: ga_sessions_visit_start_hour_of_day {
    type: number
    sql: ${TABLE}.ga_sessions_visit_start_hour_of_day ;;
  }

  dimension: metro {
    type: string
    sql: ${TABLE}.metro ;;
  }

  dimension: ga_sessions_visit_start_day_of_week {
    type: string
    sql: ${TABLE}.ga_sessions_visit_start_day_of_week ;;
  }

  dimension: ga_sessions_browser {
    type: string
    sql: ${TABLE}.ga_sessions_browser ;;
    hidden: yes
  }

  dimension: is_safari {
    type: yesno
    sql: ${ga_sessions_browser} = 'Safari' ;;
  }

  dimension: is_chrome {
    type: yesno
    sql: ${ga_sessions_browser} = 'Chrome' ;;
  }

  dimension: is_other_browser {
    type: yesno
    sql: ${ga_sessions_browser} != 'Chrome' AND ${ga_sessions_browser} != 'Safari' ;;
  }

  dimension: ga_sessions_source {
    type: string
    sql: ${TABLE}.ga_sessions_source ;;
  }

  dimension: total_sessions {
    type: number
    sql: ${TABLE}.total_sessions ;;
  }

  dimension: pageviews {
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  dimension: bounce_rate {
    type: number
    sql: ${TABLE}.bounce_rate ;;
  }

  dimension: avg_session_depth {
    type: number
    sql: ${TABLE}.avg_session_depth ;;
  }

  dimension:  visits_traffic_source_none{
    type: number
    sql: ${TABLE}.visits_traffic_source_none ;;
  }

  dimension: visits_traffic_source_organic {
    type: number
    sql: ${TABLE}.visits_traffic_source_organic ;;
  }

  dimension: visits_traffic_source_cpc {
    type: number
    sql: ${TABLE}.visits_traffic_source_cpc ;;
  }

  dimension: visits_traffic_source_cpm {
    type: number
    sql: ${TABLE}.visits_traffic_source_cpm ;;
  }

  dimension: visits_traffic_source_affiliate {
    type: number
    sql: ${TABLE}.visits_traffic_source_affiliate ;;
  }

  dimension: visits_traffic_source_referral {
    type: number
    sql: ${TABLE}.visits_traffic_source_referral ;;
  }

  dimension: distinct_dmas {
    type: number
    sql: ${TABLE}.distinct_dmas ;;
  }

  set: detail {
    fields: [
      fullvisitorid,
      label,
      ga_sessions_visit_start_hour_of_day,
      metro,
      ga_sessions_visit_start_day_of_week,
      ga_sessions_browser,
      ga_sessions_source,
      total_sessions,
      pageviews,
      bounce_rate,
      avg_session_depth
    ]
  }
}
