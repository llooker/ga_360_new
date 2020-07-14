explore: gazer {}

view: gazer {
 derived_table: {
   sql:


WITH user_labeled AS(
       SELECT fullvisitorId, max(case when totals.transactions = 1 then 1 else 0 end) as label, min(case when totals.transactions = 1 then visitStartTime end) as event_session
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`
        WHERE TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d')))  BETWEEN {% date_start date_range_filter %} AND {% date_end date_range_filter %}
        GROUP BY fullvisitorId),


trafficSource_medium AS ( SELECT count(distinct CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, count(distinct CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, trafficSource_medium AS trafficSource_medium, 'trafficSource_medium' AS type
FROM ( SELECT a.fullvisitorId, trafficSource.medium AS trafficSource_medium, label FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a, unnest (hits) as hits LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid
@{QUERY_FILTER} GROUP BY 1,2,3)
GROUP BY trafficSource_medium),

dma_staging AS ( SELECT a.fullvisitorId, geoNetwork.metro AS metro, label, COUNT(*) AS visits
FROM`@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid    @{QUERY_FILTER}
GROUP BY 1,2,3),
--- Finds the dma with the most visits for each user. If it's a tie, arbitrarily picks one.

visitor_dma AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, metro AS dma, 'dma' AS type
FROM ( SELECT fullvisitorId, metro, label, ROW_NUMBER() OVER (PARTITION BY fullvisitorId ORDER BY visits DESC) AS row_num FROM dma_staging)
WHERE row_num = 1 GROUP BY metro, type),

distinct_dma AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, distinct_dma AS distinct_dma, 'distinct_dma' AS type
FROM ( SELECT COUNT(DISTINCT metro) as distinct_dma, fullvisitorId, label FROM dma_staging GROUP BY fullvisitorId, label) GROUP BY distinct_dma),

-- Finds the daypart with the most pageviews for each user; adjusts for timezones and daylight savings time, loosely

visitor_common_daypart AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, 'day_part' AS type, daypart
FROM ( SELECT fullvisitorId, daypart, label, ROW_NUMBER() OVER (PARTITION BY fullvisitorId ORDER BY pageviews DESC) AS row_num
    FROM ( SELECT fullvisitorId, label, CASE WHEN hour_of_day >= 1 AND hour_of_day < 6 THEN '1_night_1_6' WHEN hour_of_day >= 6 AND hour_of_day < 11 THEN '2_morning_6_11' WHEN hour_of_day >= 11 AND hour_of_day < 14 THEN '3_lunch_11_14' WHEN hour_of_day >= 14 AND hour_of_day < 17 THEN '4_afternoon_14_17' WHEN hour_of_day >= 17 AND hour_of_day < 19 THEN '5_dinner_17_19' WHEN hour_of_day >= 19 AND hour_of_day < 22 THEN '6_evening_19_23' WHEN hour_of_day >= 22 OR hour_of_day = 0 THEN '7_latenight_23_1' END AS daypart,
          SUM(pageviews) AS pageviews
                FROM ( SELECT a.fullvisitorId, b.label, EXTRACT(HOUR FROM TIMESTAMP_SECONDS(visitStartTime)) AS hour_of_day, totals.pageviews AS pageviews
                    FROM`@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid   @{QUERY_FILTER}  ) GROUP BY 1,2,3) ) WHERE row_num = 1 GROUP BY type, daypart),

-- Finds the most common day based on pageviews

visitor_common_day AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, 'DoW' AS type, case when day = 1 then "1_Sunday" when day = 2 then "2_Monday" when day = 3 then "3_Tuesday" when day = 4 then "4_Wednesday" when day = 5 then "5_Thursday" when day = 6 then "6_Friday" when day = 7 then "7_Saturday" end as day
              FROM ( SELECT fullvisitorId, day, label, ROW_NUMBER() OVER (PARTITION BY fullvisitorId ORDER BY pages_viewed DESC) AS row_num
                    FROM ( SELECT a.fullvisitorId, EXTRACT(DAYOFWEEK FROM PARSE_DATE('%Y%m%d',date)) AS day, SUM(totals.pageviews) AS pages_viewed, b.label
                          FROM`@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid    @{QUERY_FILTER} GROUP BY 1,2,4 ) ) WHERE row_num = 1 GROUP BY type, day),

technology AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, deviceCategory AS deviceCategory, browser AS browser, 'technology' AS type
        FROM ( SELECT fullvisitorId, deviceCategory, browser, label, ROW_NUMBER() OVER (PARTITION BY fullvisitorId ORDER BY visits DESC) AS row_num
              FROM ( SELECT a.fullvisitorId, device.deviceCategory AS deviceCategory, CASE WHEN device.browser LIKE 'Chrome%' THEN device.browser WHEN device.browser LIKE 'Safari%' THEN device.browser ELSE 'Other browser' END AS browser, b.label, COUNT(*) AS visits
                    FROM`@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid    @{QUERY_FILTER} GROUP BY 1,2,3,4)) WHERE row_num = 1 GROUP BY deviceCategory,browser,type),

PPL1 AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, PPL1 AS PPL1, 'PPL1' AS type
      FROM ( SELECT a.fullvisitorId, hits.page.pagePathLevel1 AS PPL1, b.label FROM`@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a, unnest (hits) as hits LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid   @{QUERY_FILTER} GROUP BY 1,2,3) GROUP BY PPL1),

ecomm_action AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, CASE WHEN ecomm_action = '1' THEN '1_Click product list' WHEN ecomm_action = '2' THEN '2_Product detail view' WHEN ecomm_action = '3' THEN '3_Add to cart' WHEN ecomm_action = '4' THEN '4_Remove from cart' WHEN ecomm_action = '5' THEN '5_Start checkout' WHEN ecomm_action = '6' THEN '6_Checkout complete' WHEN ecomm_action = '7' THEN '7_Refund' WHEN ecomm_action = '8' THEN '8_Checkout options' ELSE '9_No_ecomm_action' END AS ecomm_action, 'ecomm_action' AS type
      FROM ( SELECT a.fullvisitorId, hits.eCommerceAction.action_type AS ecomm_action, b.label FROM`@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a, unnest (hits) as hits LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid   @{QUERY_FILTER} GROUP BY 1,2,3) GROUP BY ecomm_action),

prod_cat AS ( SELECT COUNT(DISTINCT CASE WHEN label = 1 THEN fullvisitorId END) AS count_1_users, COUNT(DISTINCT CASE WHEN label = 0 THEN fullvisitorId END) AS count_0_users, prod_cat AS prod_cat, 'prod_cat' AS type
      FROM ( SELECT a.fullvisitorId, prod.v2ProductCategory AS prod_cat, b.label FROM`@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a, unnest (hits) as hits, UNNEST (hits.product) AS prod LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid   @{QUERY_FILTER} GROUP BY 1,2,3) GROUP BY prod_cat),

agg_metrics AS ( SELECT a.fullvisitorId, CASE WHEN label IS NULL then 0 else label end as label, count(distinct visitId) as total_sessions, sum(totals.pageviews) as pageviews, count(totals.bounces)/count(distinct VisitID) as bounce_rate, sum(totals.timeonSite)/sum(totals.pageviews) as time_per_page, sum(totals.pageviews) / count(distinct VisitID) as avg_session_depth
      FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` a LEFT JOIN user_labeled b ON a.fullvisitorid = b.fullvisitorid  @{QUERY_FILTER} GROUP BY 1,2 ),
Agg_sessions AS ( SELECT fullvisitorId, label, total_sessions FROM agg_metrics),
Agg_pageviews AS ( SELECT fullvisitorId, label, pageviews FROM agg_metrics),
Agg_time_per_page AS ( SELECT fullvisitorId, label, time_per_page FROM agg_metrics),

Agg_avg_session_depth AS ( SELECT fullvisitorId, label, avg_session_depth FROM agg_metrics)


        SELECT *, count_1_users/(count_1_users+count_0_users) as conv_rate
        FROM trafficSource_medium
        FULL OUTER JOIN visitor_dma USING (type,count_1_users,count_0_users)
        FULL OUTER JOIN distinct_dma USING (type,count_1_users,count_0_users)
        FULL OUTER JOIN visitor_common_daypart USING (type,count_1_users,count_0_users)
        FULL OUTER JOIN visitor_common_day USING (type,count_1_users,count_0_users)
        FULL OUTER JOIN technology USING (type,count_1_users,count_0_users)
        FULL OUTER JOIN PPL1 USING (type,count_1_users,count_0_users)
        FULL OUTER JOIN ecomm_action USING (type,count_1_users,count_0_users)
        FULL OUTER JOIN prod_cat USING (type,count_1_users,count_0_users)
         ;;
 }

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: type {
  type: string
  sql: ${TABLE}.type ;;
}

dimension: count_1_users {
  type: number
  sql: ${TABLE}.count_1_users ;;
}

dimension: count_0_users {
  type: number
  sql: ${TABLE}.count_0_users ;;
}

dimension: traffic_source_medium {
  type: string
  sql: ${TABLE}.trafficSource_medium ;;
}

dimension: dma {
  type: string
  sql: ${TABLE}.dma ;;
}

dimension: distinct_dma {
  type: number
  sql: ${TABLE}.distinct_dma ;;
}

dimension: daypart {
  type: string
  sql: ${TABLE}.daypart ;;
}

dimension: day {
  type: string
  sql: ${TABLE}.day ;;
}

dimension: device_category {
  type: string
  sql: ${TABLE}.deviceCategory ;;
}

dimension: browser {
  type: string
  sql: ${TABLE}.browser ;;
}

dimension: ppl1 {
  type: string
  sql: ${TABLE}.PPL1 ;;
}

dimension: ecomm_action {
  type: string
  sql: ${TABLE}.ecomm_action ;;
}

dimension: prod_cat {
  type: string
  sql: ${TABLE}.prod_cat ;;
}

dimension: conv_rate {
  type: number
  sql: ${TABLE}.conv_rate ;;
}

set: detail {
  fields: [
    type,
    count_1_users,
    count_0_users,
    traffic_source_medium,
    dma,
    distinct_dma,
    daypart,
    day,
    device_category,
    browser,
    ppl1,
    ecomm_action,
    prod_cat,
    conv_rate
  ]

}

  filter: date_range_filter {
    type: date
    default_value: "2017-02-01 12:00:00 to
    2018-07-01 14:00:00"
  }
}
