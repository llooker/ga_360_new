#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Connor Sparkman
# Created: May 2020
# Purpose: A derived table that returns the first visit date for a web page. Used to calculate asset age. Asset and Page are the same in this context.
#############################################################################################################

view: asset_facts{
  view_label: "Behavior"
  derived_table: {
    persist_for: "1 hour"
    sql: SELECT
          SPLIT(hits.page.pagePath, '?')[OFFSET(0)] as page
         , MIN(TIMESTAMP_SECONDS(ga_sessions.visitStarttime)) as first_visit
        FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`  AS ga_sessions
        LEFT JOIN UNNEST(ga_sessions.hits) as hits
        WHERE hits.type = 'PAGE'
        GROUP BY page
       ;;
  }

  ########## PRIMARY KEYS #########

  dimension: page {
    primary_key: yes
    hidden: yes
    description: "Web Page used to JOIN back to Google Analytics data"
    type: string
    sql: ${TABLE}.page ;;
  }

  ########## DIMENSIONS #########

  dimension: asset_age {
    label: "Asset Age (Days)"
    description: "Days that the page/asset has been available on looker.com domain."
    type: number
    sql: DATE_DIFF(CURRENT_DATE(), ${first_visit_date}, DAY);;
  }

  dimension: asset_age_range {
    description: "Age that the page/asset has been available on looker.com domain broken into brackets."
    type: string
    case: {
      when: {
        label: "1-30 days"
        sql: ${asset_age} <= 30 ;;
      }
      when: {
        label: "30-90 days"
        sql: ${asset_age} <= 90 ;;
      }
      when: {
        label: "3-6 months"
        sql: ${asset_age} <= 180 ;;
      }
      when: {
        label: "6-12 months"
        sql: ${asset_age} <= 365 ;;
      }
      when: {
        label: "1-2 years"
        sql: ${asset_age} <= 730  ;;
      }
      when: {
        label: ">2 years"
        sql: ${asset_age} > 730  ;;
      }
    }
  }


  dimension_group: first_visit {
    description: "Timestamp of the first visit to the specified page, which is used to calculate the Asset Age."
    type: time
    timeframes: [
      raw,
      date,
      quarter,
      week,
      month,
      year,
      week_of_year
    ]
    sql: ${TABLE}.first_visit;;
    convert_tz: no
  }
}
