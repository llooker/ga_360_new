include: "ga_sessions.view.lkml"

  view: +ga_sessions {
  # # TODO: CUSTOMIZE GOALS HERE ####

  # # Goals measure how well your site or app fulfills your target objectives. A goal represents a completed activity,
  # # called a conversion, that contributes to the success of your business. Examples of goals include making a purchase
  # # (for an ecommerce site), completing a game level (for a mobile gaming app), or submitting a contact information
  # # form (for a marketing or lead generation site).

  # # Find more information here: https://support.google.com/analytics/answer/1012040?hl=en&ref_topic=6150889

  # # "Selected_goal_conversions", "selected_goal_conversion_rate", and "selected_goal_conversion_value" are the
  # # measures used in the application interface. Make sure that these measures contain all of the possible goals.
  # # The goal will be selected using a filter in the Application UI.

    # goal definitions

    dimension: demo_goal_hit {
      type: yesno
      sql: (SELECT h.page.pagePath FROM UNNEST(${ga_sessions.hits}) h
        WHERE h.page.pagePath = "/asearch.html" LIMIT 1) IS NOT NULL ;;
    }

    # dimension: company_goal_hit {
    #   type: yesno
    #   sql: (SELECT h.page.pagePath FROM UNNEST(${ga_sessions.hits}) h
    #     WHERE h.page.pagePath = "/company" LIMIT 1) IS NOT NULL ;;
    # }

    # dimension: team_goal_hit {
    #   type: yesno
    #   sql: (SELECT h.page.pagePath FROM UNNEST(${ga_sessions.hits}) h
    #     WHERE h.page.pagePath = "/team" LIMIT 1) IS NOT NULL ;;
    # }


    # dimension: home_page_goal {
    #   type: yesno
    #   sql: (SELECT h.page.pagePath FROM UNNEST(${ga_sessions.hits}) h
    #     WHERE h.page.pagePath = "/goal" LIMIT 1) IS NOT NULL ;;
    # }

    # dimension: about_page_goal {
    #   type: yesno
    #   sql: (SELECT h.page.pagePath FROM UNNEST(${ga_sessions.hits}) h
    #     WHERE h.page.pagePath = "/about" LIMIT 1) IS NOT NULL ;;
    # }

    # dimension: conversion_value {
    #   sql: 100 ;;
    # }


    # value of goal

    # dimension: value_of_conversion {
    #   type: number
    #   hidden: yes
    #   sql: 100 ;;
    #   value_format_name: usd
    # }

    # # filter for goal completion to mark as converted

    # measure: demo_goal_conversions {
    #   group_label: "Goals"
    #   type: count
    #   filters: {
    #     field: demo_goal_hit
    #     value: "Yes"
    #   }
    # }

    # measure: company_goal_conversions {
    #   group_label: "Goals"
    #   type: count
    #   filters: {
    #     field: company_goal_hit
    #     value: "Yes"
    #   }
    # }

    # define conversion rate

    # measure: demo_goal_conversion_rate {
    #   description: "URL hits / Sessions"
    #   group_label: "Goals"
    #   type: number
    #   sql: 1.0 * (${demo_goal_conversions}/NULLIF(${ga_sessions.visits_total},0));;
    #   value_format_name: percent_2
    # }

    # measure: company_goal_conversion_rate {
    #   description: "URL hits / Sessions"
    #   group_label: "Goals"
    #   type: number
    #   sql: 1.0 * (${company_goal_conversions}/NULLIF(${ga_sessions.visits_total},0));;
    #   value_format_name: percent_2
    # }

    # measure: demo_goal_conversion_value {
    #   description: "URL Conversions * Value"
    #   group_label: "Goals"
    #   type: number
    #   sql: 1.0 * (${demo_goal_conversions}) * (${value_of_conversion});;
    #   value_format_name: usd
    # }

    # measure: company_goal_conversion_value {
    #   description: "URL Conversions * Value"
    #   group_label: "Goals"
    #   type: number
    #   sql: 1.0 * (${company_goal_conversions}) * (${value_of_conversion});;
    #   value_format_name: usd
    # }

    # TODO: you need to add all the goals here as well

    # parameter: goal_selection {
    #   type: string
    #   suggestions: ["No Selection","Demo","Company"]
    #   allowed_value: {value: "No Selection"}
    #   allowed_value: {value: "Demo"}
    #   allowed_value: {value: "Company"}
    #   default_value: "'No Selection'"
    # }

    # measure: selected_goal_conversions {
    #   type: number
    #   sql: {% if goal_selection._parameter_value == "'Demo'" %}${demo_goal_conversions}
    #         {% elsif goal_selection._parameter_value == "'Company'" %}${company_goal_conversions}
    #         {% elsif goal_selection._parameter_value == "'No Selection'" %}NULL
    #         {% endif %} ;;
    #   label_from_parameter: goal_selection
    #   value_format_name: decimal_0
    # }

    # measure: selected_goal_conversion_rate {
    #   type: number
    #   sql: {% if goal_selection._parameter_value == "'Demo'" %}${demo_goal_conversion_rate}
    #       {% elsif goal_selection._parameter_value == "'Company'" %}${company_goal_conversion_rate}
    #       {% elsif goal_selection._parameter_value == "'No Selection'" %}NULL
    #         {% endif %} ;;
    #   label_from_parameter: goal_selection
    #   value_format_name: percent_2
    # }

    # measure: selected_goal_conversion_value {
    #   type: number
    #   sql: {% if goal_selection._parameter_value == "'Demo'" %}${demo_goal_conversion_value}
    #       {% elsif goal_selection._parameter_value == "'Company'" %}${company_goal_conversion_value}
    #       {% elsif goal_selection._parameter_value == "'No Selection'" %}NULL
    #         {% endif %} ;;
    #   label_from_parameter: goal_selection
    #   value_format_name: usd
    # }
  }
