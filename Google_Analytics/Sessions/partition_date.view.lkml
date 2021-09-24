#############################################################################################################
# Purpose: Use the field definitions in this view to determine a date partition scenario to use.
# Scenario 1 is used by default. To use other scenarios add them to the `refinements.lkml` file as a refinement.
#  For example, scenario 3 would look like:
#
#   view +ga_sessions_partition_date {
#     sql_table_name: `{{ _user_attributes['ga_360_schema'] }}.@{GA360_TABLE_NAME} ;;
#   }
#
#############################################################################################################

include: "ga_sessions.view.lkml"

view: ga_sessions_partition_date {
  extension: required

  ############################################################
  #                 Scenario 1 (S1): START                   #
  ############################################################

  # Scenario 1 (S1): You are viewing a single GA 360 property
  # Single property
    sql_table_name: `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}` ;;

    dimension_group: partition {
      # Date that is parsed from the table name. Required as a filter to avoid accidental massive queries
      label: ""
      view_label: "Session"
      description: "Date based on the day the session was added to the database. Matches date in Google Analytics UI, but may not match 'Session Start Date'."
      type: time
      timeframes: [
        date,
        day_of_week,
        day_of_week_index,
        day_of_month,
        day_of_year,
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
      sql: TIMESTAMP(
              PARSE_DATE(
                '%Y%m%d'
                  , REGEXP_EXTRACT(
                    _TABLE_SUFFIX
                      , r'^\d\d\d\d\d\d\d\d'
                  )
              )
            );;
      convert_tz: no
    }
  ############################################################
  #                 Scenario 1 (S1): END                     #
  ############################################################

  ############################################################
  #                 Scenario 2 (S2): START                   #
  ############################################################

  # # Scenario 2 (S2): You are viewing Multiple  GA 360 properties in the same BQ project and are leveraging analytics across multiple properties
  # #   TODO: update the always_filter in the model
  # #   TODO: Uncomment the sql_table_name and update the FROM statement and property nickname
  #   sql_table_name:
  #   (
  #     SELECT *, 'Property1' as property, TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) AS partition_date
  #     FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`
  #     WHERE {% condition partition_filter %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %}
  #     UNION ALL
  #     SELECT *, 'Property2' as property, TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) AS partition_date
  #     FROM `@{SCHEMA_NAME}.@{GA360_TABLE_NAME}`
  #     WHERE {% condition partition_filter %} TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'^\d\d\d\d\d\d\d\d'))) {% endcondition %}
  #   );;


  # # S2 TODO: Uncomment field
  #   filter: partition_filter {
  #     type: date
  #     default_value: "@{EXPLORE_DATE_FILTER}"
  #   }

  # # S2 TODO: Uncomment field and comment out the partition date above
  #   dimension_group: partition {
  #     # Date that is parsed from the table name. Required as a filter to avoid accidental massive queries
  #     label: ""
  #     view_label: "Session"
  #     description: "Date based on the day the session was added to the database. Matches date in Google Analytics UI, but may not match 'Session Start Date'."
  #     type: time
  #     timeframes: [
  #       date,
  #       day_of_week,
  #       day_of_week_index,
  #       day_of_month,
  #       day_of_year,
  #       fiscal_quarter,
  #       fiscal_quarter_of_year,
  #       week,
  #       month,
  #       month_name,
  #       month_num,
  #       quarter,
  #       quarter_of_year,
  #       week_of_year,
  #       year
  #     ]
  #     sql: ${TABLE}.partition_date ;;
  #     # can_filter: no
  #     convert_tz: no
  #   }

  # # S2 TODO: Uncomment out the field and update the property and website names
  #   dimension: property {
  #     hidden: yes
  #     suggestions: ["Website1","Website2"]
  #     sql: CASE
  #           WHEN ${TABLE}.property = "Property1" THEN "Website1"
  #           WHEN ${TABLE}.property = "Property2" THEN "Website2"
  #           ELSE NULL
  #         END
  #         ;;
  #   }

  ############################################################
  #                 Scenario 2 (S2): END                     #
  ############################################################

  ############################################################
  #                 Scenario 3 (S3): START                   #
  ############################################################
  # #Scenario 3 (S3): Multiple properties but allow specific users to view their own properties

  # # S3 TODO: Create a user attribute ga_360_schema and assign values for each user.
          # Uncomment out the sql_table_name below

  # # Single property
    # sql_table_name: `{{ _user_attributes['ga_360_schema'] }}.@{GA360_TABLE_NAME} ;;

  ############################################################
  #                 Scenario 3 (S3): END                     #
  ############################################################

}
