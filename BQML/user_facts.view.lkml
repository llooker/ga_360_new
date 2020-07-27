view: user_facts {
  derived_table: {
    sql:
        --Limiting the table scans to the date ranges identified in the predictions table
        WITH filtered_base AS (
        SELECT * FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`
        WHERE TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d')))  BETWEEN ((TIMESTAMP_ADD(TIMESTAMP_TRUNC( CURRENT_TIMESTAMP(), DAY), INTERVAL -DAYS_BACK DAY))) AND ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -DAYS_BACK DAY), INTERVAL DAYS_FROM DAY)))),
      -- labeling customers who have made a purchase as a 1 and customers who have not made a purchas as a 0
    user_label AS (
      SELECT clientId, max(case when totals.transactions >= 1 then 1 else 0 end) as label, max(case when totals.transactions >= 1 then visitStartTime end) as event_session
        FROM filtered_base
        GROUP BY clientId),
      -- finding the most common hour of day for each user within the time period
    unique_hour_of_day AS(
      (SELECT   ga_sessions_visit_start_hour_of_day, clientId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY clientId ORDER BY   pageviews) as row_number, clientId, ga_sessions_visit_start_hour_of_day
      FROM (SELECT ga_sessions.clientId as clientId, EXTRACT(HOUR FROM TIMESTAMP_SECONDS(ga_sessions.visitStarttime)) AS ga_sessions_visit_start_hour_of_day, SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions  LEFT JOIN user_label ON ga_sessions.clientId = user_label.clientId  @{QUERY_FILTER}  GROUP BY 1,2)) WHERE row_number = 1)),
      -- findiing the most common metro for the user within the time period
      unique_dma AS(
      (SELECT   metro, clientId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY clientId ORDER BY   pageviews) as row_number, clientId, metro
      FROM (SELECT ga_sessions.clientId as clientId, ga_sessions.geoNetwork.metro as metro , SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.clientId = user_label.clientId @{QUERY_FILTER}  GROUP BY 1,2)) WHERE row_number = 1)),
      -- finding the most common day of week for the user within the time period
      unique_day_of_week AS(
      (SELECT   ga_sessions_visit_start_day_of_week, clientId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY clientId ORDER BY   pageviews) as row_number, clientId, ga_sessions_visit_start_day_of_week
      FROM (SELECT ga_sessions.clientId as clientId, FORMAT_TIMESTAMP('%A', TIMESTAMP_SECONDS(ga_sessions.visitStarttime)) AS ga_sessions_visit_start_day_of_week  , SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.clientId = user_label.clientId  @{QUERY_FILTER} GROUP BY 1,2)) WHERE row_number = 1)),
    -- finding the most common traffic source for the user
      unique_traffic_source AS(
      (SELECT   ga_sessions_source, clientId FROM (SELECT ROW_NUMBER () OVER(PARTITION BY clientId ORDER BY   pageviews) as row_number, clientId, ga_sessions_source
      FROM (SELECT ga_sessions.clientId as clientId, ga_sessions.trafficsource.medium  AS ga_sessions_source, SUM(ga_sessions.totals.pageviews) as pageviews
      FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.clientId = user_label.clientId  @{QUERY_FILTER}  GROUP BY 1,2)) WHERE row_number = 1)),

      agg_metrics AS (  SELECT  ga_sessions.clientId, count(distinct visitId) as total_sessions,
        sum(totals.pageviews) as pageviews,
        count(totals.bounces)/count(distinct VisitID) as bounce_rate,
        sum(totals.pageviews) / count(distinct VisitID) as avg_session_depth,
        count(distinct geoNetwork.metro) as distinct_dmas,
        count(distinct EXTRACT(DAYOFWEEK FROM PARSE_DATE('%Y%m%d', date))) as num_diff_days_visited,
  max(case when device.isMobile is True then 1 else 0 end) as mobile,
   max(case when device.browser = 'Chrome' then 1 else 0 end) as chrome,
   max(case when device.browser like  '%Safari%' then 1 else 0 end) as safari,
   max(case when device.browser <> 'Chrome' and device.browser not like '%Safari%' then 1 else 0 end) as browser_other,
        sum(case when trafficSource.medium = '(none)' then 1 else 0 end) as visits_traffic_source_none,
    sum(case when trafficSource.medium = 'organic' then 1 else 0 end) as visits_traffic_source_organic,
    sum(case when trafficSource.medium = 'cpc' then 1 else 0 end) as visits_traffic_source_cpc,
    sum(case when trafficSource.medium = 'cpm' then 1 else 0 end) as visits_traffic_source_cpm,
    sum(case when trafficSource.medium = 'affiliate' then 1 else 0 end) as visits_traffic_source_affiliate,
    sum(case when trafficSource.medium = 'referral' then 1 else 0 end) as visits_traffic_source_referral
        FROM filtered_base  AS ga_sessions LEFT JOIN user_label ON ga_sessions.clientId = user_label.clientId
        @{QUERY_FILTER}   GROUP BY 1 )


      SELECT user_label.clientId, label,ga_sessions_visit_start_hour_of_day, metro, ga_sessions_visit_start_day_of_week, ga_sessions_source,
      total_sessions, pageviews, bounce_rate, avg_session_depth, visits_traffic_source_none, visits_traffic_source_organic, visits_traffic_source_cpc,  visits_traffic_source_cpm, visits_traffic_source_affiliate,
      visits_traffic_source_referral, distinct_dmas, mobile, chrome, safari, browser_other
      FROM user_label
      LEFT JOIN unique_hour_of_day ON user_label.clientId = unique_hour_of_day.clientId
      LEFT JOIN unique_dma ON user_label.clientId = unique_dma.clientId
      LEFT JOIN unique_day_of_week ON user_label.clientId = unique_day_of_week.clientId
      LEFT JOIN unique_traffic_source ON unique_traffic_source.clientId = user_label.clientId
      LEFT JOIN agg_metrics ON agg_metrics.clientId = user_label.clientId
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

  dimension: clientId {
    type: string
    sql: ${TABLE}.clientId ;;
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
      clientId,
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