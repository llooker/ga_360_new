#############################################################################################################
# Owner: Marketing Analytics, Connor Sparkman
# Created by: Paola Renteria
# Created: September 2019
# Purpose: Defines the fields within the hits struct in google analytics. Is joined to the ga_sessions explore
#          by unnesting the values.
#############################################################################################################

view: hits {
  view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Hits"
  ########## PRIMARY KEYS ##########

  dimension: id {
    primary_key: yes
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Session"
    label: "Hit ID"
    group_label: "ID"
    description: "Unique Session ID | Hit Number"
    sql: CONCAT(${ga_sessions.id},'|',FORMAT('%05d',${hit_number})) ;;
  }

  ########## DIMENSIONS ##########

  dimension: custom_dimensions {
    description: "Used for unnesting the custom dimension struct in the table. This dimension should not be queried directly"
    hidden: yes
    sql: ${TABLE}.customdimensions ;;
  }

  dimension: custom_variables {
    description: "Used for unnesting the custom dimension struct in the table. This dimension should not be queried directly"
    hidden: yes
    sql: ${TABLE}.customvariables ;;
  }

  dimension: data_source {
    group_label: "Platform or Device"
    description: "The data source of a hit. By default, hits sent from analytics.js are reported as 'web' and hits sent from the mobile SDKs are reported as 'app'. These values can be overridden in the Measurement Protocol."
    type: string
    sql: ${TABLE}.dataSource ;;
  }

  dimension: event_action {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Event Tracking"
    description: "Action tied to event"
    type: string
    sql: ${TABLE}.eventInfo.eventAction ;;

    drill_fields: [event_category, event_label, event_value]
  }

  dimension: event_category {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Event Tracking"
    description: "The event category"
    type: string
    sql: ${TABLE}.eventInfo.eventCategory ;;

    drill_fields: [event_action, event_label, event_value]
  }

  dimension: event_label {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Event Tracking"
    description: "Label tied to event"
    type: string
    sql: ${TABLE}.eventInfo.eventLabel ;;

    drill_fields: [event_action, event_category, event_value]
  }
  dimension: event_value {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Event Tracking"
    description: "Total value of web events for the profile."
    type: number
    sql: ${TABLE}.eventInfo.eventValue ;;

    drill_fields: [event_action, event_category, event_label]
  }

  dimension: full_page_url {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Full Page URL"
    description: "The full URL including the hostname and path."
    type: string
    sql: CONCAT(${host_name}, ${page_path_formatted});;

    link: {
      label: "Go to Page"
      url: "https://{{ value }}"
    }
  }

  dimension: full_page_url_parameters {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages (with Parameters)"
    label: "Full Page URL"
    description: "The full URL including the hostname and path."
    type: string
    sql: CONCAT(${host_name}, ${page_path});;

    link: {
      label: "Go to Page"
      url: "https://{{ value }}"
    }
  }

  dimension: has_completed_discover_lp {
    hidden: yes
    description: "Did the visitor navigate to a Discover Landing Page?"
    type: yesno
    sql: REGEXP_CONTAINS(${page_path}, 'SmartInsights-5StepsKPIs-Conf.html') ;;
  }

  dimension: has_completed_dashboard_demo {
    description: "Did the visitor navigate to the Looker demo dashboard page?"
    hidden: yes
    type: yesno
    sql: (REGEXP_CONTAINS(${page_path}, 'looker.com/demo/looker-dashboard') AND ${event_category} = "formSubmissionSuccess") ;;
  }

  dimension: has_completed_free_trial {
    description: "Did the visitor complete the free trial form?"
    hidden: yes
    type: yesno
    sql: REGEXP_CONTAINS(${page_path}, '/confirmation/trial') ;;
  }

  dimension: has_goal_completed {
    hidden: yes
    description: "Did the visitor complete any of the targeted goals?"
    type: yesno
    sql: (${has_completed_dashboard_demo}
          OR ${has_completed_discover_lp}
          OR ${is_adwords_completion}
          OR ${is_data_topic}
          OR ${is_subscribed_to_blog}) ;;
  }

  dimension: has_seen_demo_confirmation_page {
    description: "Did the visitor navigate to the demo confirmation page?"
    hidden: yes
    type: yesno
    sql: REGEXP_CONTAINS(${page_path}, '/confirmation/demo') ;;
  }

  dimension: has_social_source_referral {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Acquisition"
    group_label: "Traffic Sources"
    description: "Indicates whether sessions to the property are from a social source."
    type: yesno
    sql: ${TABLE}.social.hasSocialSourceReferral = "Yes" ;;
  }

  dimension_group: hit {
    timeframes: [date,day_of_week,fiscal_quarter,week,month,year,month_name,month_num,week_of_year]
    type: time
    sql: TIMESTAMP_MILLIS(${ga_sessions.visit_start_seconds}*1000 + ${time}) ;;
    convert_tz: no
  }

  dimension: hit_number {
    description: "The sequenced hit number. For the first hit of each session, this is set to 1."
    type: number
    sql: ${TABLE}.hitNumber ;;
  }

  dimension: host_name {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Hostname"
    description: "The hostname from which the tracking request was made."
    sql: ${TABLE}.page.hostName ;;

    link: {
      label: "Go To Link"
      url: "https://{{ value }}"
    }
  }

  dimension: hour {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Session"
    group_label: "Time"
    description: "A two-digit hour of the day ranging from 00-23 in the timezone configured for the account. This value is also corrected for daylight savings time. If the timezone follows daylight savings time, there will be an apparent bump in the number of sessions during the changeover hour (e.g., between 1:00 and 2:00) for the day per year when that hour repeats. A corresponding hour with zero sessions will occur at the opposite changeover. (Google Analytics does not track user time more precisely than hours.)"
    type: number
    sql: ${TABLE}.hour ;;
  }

  dimension: is_adwords_completion {
    description: "A successful form-fill that resulted in reaching a success page on looker.com that contains tyvmflds, primarily used to track successful conversion from PPC campaigns."
    hidden: yes
    type: yesno
    sql: REGEXP_CONTAINS(${page_path}, 'tyvmflds') ;;
  }

  dimension: is_any_confirmation {
    description: "A successful form-fill that resulted in reaching a success page on looker.com in confirmation folder."
    hidden: yes
    type: yesno
    sql: REGEXP_CONTAINS(${page_path}, 'confirmation') ;;
  }

  dimension: is_data_topic {
    description: "A successful form-fill that occurred on looker.com pages in data-topics folder. These pages were originally built as LPs for organic search traffic."
    hidden: yes
    type: yesno
    sql: (REGEXP_CONTAINS(${page_path}, 'looker.com/data-topics/') AND ${event_category} = "formSubmissionSuccess") ;;
  }

  dimension: is_drift {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Event Filters"
    description: "Use with Event Tracking dimension(s)"
    type: yesno
    sql: UPPER(${event_category}) LIKE 'DRIFT%';;
  }

  dimension: is_entrance {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Page Filters"
    label: "Is Landing Page"
    description: "Use to filter for first pageview of a session. Use with Page dimensions."
    type: yesno
    sql: ${TABLE}.isEntrance ;;
  }

  dimension: is_exit {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Page Filters"
    description: "If this hit was the last pageview or screenview hit of a session, this is set to true."
    type: yesno
    sql: ${TABLE}.isExit ;;
  }

  dimension: is_interaction {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Page Filters"
    description: "If this hit was an interaction, this is set to true. If this was a non-interaction hit (i.e., an event with interaction set to false), this is false."
    type: yesno
    sql: ${TABLE}.isInteraction ;;
  }

  dimension: is_scroll {
    hidden: yes
    label: "Is Scroll Tracking"
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Event Filters"
    description: "Use with Event Tracking dimension(s). Scroll tracking monitors the length of the page scrolled by users."
    type: yesno
    sql: UPPER(${event_category}) LIKE 'SCROLL TRACKING%';;
  }

  dimension: is_subscribed_to_blog {
    description: "Is the visitor subscribed to Looker blog?"
    hidden: yes
    type: yesno
    sql: REGEXP_CONTAINS(${page_path}, 'looker.com/blog') AND REGEXP_CONTAINS(${page_path}, 'allid=') ;;
  }

  dimension: is_video {
    hidden: yes
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Event Filters"
    description: "Use with Event Tracking dimension(s). Tracks the player state (play, pause, and the % of video played of single/multiple videos embedded on the page."
    type: yesno
    sql: UPPER(${event_category}) LIKE 'VIDEO%';;
  }

  dimension: minute {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Session"
    group_label: "Time"
    description: "Returns the minutes, between 00 and 59, in the hour."
    type: number
    sql: ${TABLE}.minute ;;
  }

  dimension: page_path {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages (with Parameters)"
    label: "Page"
    description: "A page on the website specified by path and/or query parameters. Use this with hostname to get the page's full URL."
    sql: ${TABLE}.page.pagePath ;;

    link: {
      label: "Go To Link"
      url: "https://{{host_name._value }}{{ value }}"
    }

    drill_fields: [host_name]
  }

  dimension: page_path_formatted {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Page"
    description: "The url of the page."
    type: string
    sql: SPLIT(${page_path}, '?')[OFFSET(0)];;

    link: {
      label: "Go To Link"
      url: "https://{{host_name._value }}{{ value }}"
    }

    drill_fields: [host_name]
  }

  dimension: page_path_level_1 {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths in the first hierarchical level in pagePath."
    sql: ${TABLE}.page.pagePathLevel1 ;;
  }

  dimension: page_path_level_2 {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths in the second hierarchical level in pagePath."
    sql: ${TABLE}.page.pagePathLevel2 ;;
  }

  dimension: page_path_level_3 {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths in the third hierarchical level in pagePath."
    sql: ${TABLE}.page.pagePathLevel3 ;;
  }

  dimension: page_path_level_4 {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths into hierarchical levels. Up to 4 pagePath levels maybe specified. All additional levels in the pagePath hierarchy are also rolled up in this dimension."
    sql: ${TABLE}.page.pagePathLevel4 ;;
  }

  dimension: page_title {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    description: "The page's title. Multiple pages might have the same page title."
    sql: ${TABLE}.page.pageTitle ;;

    drill_fields: [page_path]
  }

  dimension: is_play {
    label: "Is Played"
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Video"
    description: "Yes if a video is played. NULL if the event action is not related to a video"
    type: yesno
    sql: ${is_video} AND (UPPER(${event_action}) LIKE "%PLAY%" OR REGEXP_CONTAINS(${event_action}, "%"));;
  }

  dimension: referer {
    description: "The previous page that directed the user to this page"
    hidden: yes
    type: string
    sql: ${TABLE}.referer ;;
  }

  dimension: search_category {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Internal Site Search"
    label: "Site Search Category"
    description: "The category used for the internal search if site search categories are enabled in the view. For example, the product category may be electronics, furniture, or clothing."
    sql: ${TABLE}.page.searchCategory ;;
  }

  dimension: scroll_tracking_page {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Scroll"
    description: "Use with Event measure(s). Scroll tracking monitors the length of the page scrolled by users."
    type: string
    sql: CASE
          WHEN ${is_scroll}
            THEN CONCAT(${host_name}, ${event_label})
         END;;

    link: {
      label: "Go To Link"
      url: "https://{{ value }}"
    }
  }

  dimension: scroll_percent {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Scroll"
    description: "Use with Event measure(s). % of the page scrolled."
    type: number
    sql: CASE
          WHEN ${is_scroll}
            THEN SAFE_CAST(REGEXP_REPLACE(${event_action}, "%","") AS INT64)
         END;;

    value_format: "0\%"
  }

  dimension: search_keyword {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Internal Site Search"
    label: "Search Term"
    description: "Search term used within the property."
    sql: ${TABLE}.page.searchKeyword ;;
  }

  dimension: social_interaction_action {
    hidden: yes
    group_label: "Social Interactions"
    label: "Social Action"
    description: "For social interactions, this is the social action (e.g., +1, bookmark) being tracked."
    type: string
    sql: ${TABLE}.social.socialInteractionAction ;;
  }

  dimension: social_interaction_network {
    hidden: yes
    group_label: "Social Interactions"
    description: "For social interactions, this represents the social network being tracked."
    type: string
    sql: ${TABLE}.social.socialInteractionNetwork ;;
  }

  dimension: social_interaction_target {
    hidden: yes
    group_label: "Social Interactions"
    label: "Social Entity"
    description: "For social interactions, this is the URL (or resource) which receives the social network action."
    type: string
    sql: ${TABLE}.social.socialInteractionTarget ;;
  }

  dimension: social_network {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Acquisition"
    group_label: "Traffic Sources"
    description: "The social network name. This is related to the referring social network for traffic sources; e.g., Google+, Blogger."
    type: string
    sql: ${TABLE}.social.socialNetwork ;;
  }

  dimension: social_network_and_action {
    hidden: yes
    group_label: "Social Interactions"
    description: "For social interactions, this is the concatenation of the socialInteractionNetwork and socialInteractionAction action (e.g., Google: +1) being tracked at this hit level."
    type: string
    sql: ${TABLE}.social.socialInteractionNetworkAction ;;
  }

  dimension: time {
    label: "Time Elapsed Since Session Start"
    description: "The time elapsed since the Session Start Date when this hit was registered. The first hit in a session has a value of 0"
    type: number
    sql: ${TABLE}.time ;;
  }

  dimension: type {
    label: "Hit Type"
    description: "The type of hit: PAGE or EVENT"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unique_social_interactions {
    description: "Number of unique social interactions"
    hidden: yes
    type: number
    sql: ${TABLE}.social.uniqueSocialInteractions ;;
  }

  dimension: video_page {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Video"
    description: "Use with Event measure(s). Page where the video is embedded."
    type: string
    sql: CASE
          WHEN ${is_video}
            THEN REGEXP_REPLACE(${event_label}, "from: ", "")
         END;;

    link: {
      label: "Link"
      url: "{{ value }}"
    }
  }

  dimension: video_percent_watched{
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Video"
    description: "Use with Event measure(s). % of video watched on "
    type: number
    sql: CASE
          WHEN ${is_play}
            THEN COALESCE(SAFE_CAST(REGEXP_REPLACE(REGEXP_REPLACE(${event_action}, "Reached ", ""), "%","") AS INT64), 0)
         END;;

    value_format: "0\%"
  }

  dimension: video_title {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Video"
    description: "Use with Event measure(s). Title of Video."
    type: string
    sql: CASE
          WHEN ${is_video}
            THEN REGEXP_REPLACE(${event_category}, "Video: ", "")
         END;;
  }



  ########## MEASURES ##########

  measure: count {
    group_label: "Hits"
    label: "Hit Count"
    description: "Total number of hits within the session."
    type: count
    drill_fields: [detail*]
  }

  measure: entrance_pageviews_total {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Entrances"
    description: "The number of entrances to the property measured as the first pageview in a session, typically used with landingPagePath."
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [detail*]
    filters: {
      field: is_entrance
      value: "Yes"
    }
  }
  measure: entrance_rate {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    description: "The percentage of pageviews in which this page was the entrance."
    type: number
    sql: ${entrance_pageviews_total}/NULLIF(${page_count}, 0) ;;
    value_format_name: percent_2
  }

  measure: event_count {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Events"
    label: "Total Events"
    description: "The total number of web events for the event."
    type: count_distinct
    sql: ${id} ;;

    filters: {
      field: type
      value: "EVENT"
    }

    drill_fields: [event_category, event_action, event_label, event_value, event_count, unique_event_count]
  }

  measure: exit_pageviews_total {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Exits"
    description: "The number of exits from the property."
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [detail*]
    filters: {
      field: is_exit
      value: "Yes"
    }
  }

  measure: exit_rate {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Exit Rate"
    description: "Exit is (number of exits) / (number of pageviews) for the page or set of pages. It indicates how often users exit from that page or set of pages when they view the page(s)."
    type: number
    sql: ${exit_pageviews_total}/NULLIF(${page_count}, 0) ;;
    value_format_name: percent_2
  }

  measure: page_count {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Pageviews"
    description: "The total number of pageviews for the property."
    type: count_distinct
    sql: ${id} ;;

    filters: {
      field: type
      value: "PAGE"
    }

    drill_fields: [ga_sessions.visit_start_date, unique_page_count, entrance_pageviews_total, exit_pageviews_total, time_on_page.average_time_on_page]
  }

  measure: page_value {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    description: "The average value of this page or set of pages, which is equal to (ga:transactionRevenue + ga:goalValueAll) / ga:uniquePageviews."
    type: number
    sql: (${ga_sessions.transaction_revenue_total})/nullif(${unique_page_count}, 0) ;;
  }

  measure: percent_sessions_with_event {
    group_label: "Hits"
    label: "Events / Sessions with Events"
    description: "The average number of web events per session with web event."
    type: number
    sql: ${event_count}/NULLIF(${sessions_with_events},0);;
    drill_fields: [detail*]
    value_format_name: decimal_2
  }

  measure: sessions_with_events {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Session"
    group_label: "Session"
    description: "The total number of sessions with web events."
    type: count_distinct
    sql: ${ga_sessions.id} ;;
    drill_fields: [detail*]
    filters: {
      field: type
      value: "EVENT"
    }
  }

  measure: unique_page_count {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Pages"
    label: "Unique Pageviews"
    description: "Unique Pageviews are the number of sessions during which the specified page was viewed at least once. A unique pageview is counted for each page URL + page title combination."
    type: count_distinct
    sql: CONCAT(${ga_sessions.id}, ${page_path}, ${page_title});;

    filters: {
      field: type
      value: "PAGE"
    }

    drill_fields: [event_category, event_action, event_label, event_value, event_count, unique_event_count]
  }

  measure: unique_event_count {
    view_label: "{% if _explore._name == 'campaign_analytics' %}Web {% else %}{%endif%}Behavior"
    group_label: "Events"
    label: "Unique Events"
    description: "Unique Events are interactions with content by a single user within a single session that can be tracked separately from pageviews or screenviews."
    type: count_distinct
    sql: CONCAT(${ga_sessions.id}, ${event_action}, ${event_category}, ${event_label}) ;;
    filters: {
      field: type
      value: "EVENT"
    }

    drill_fields: [ga_sessions.visit_start_date, page_count, entrance_pageviews_total, exit_pageviews_total, time_on_page.average_time_on_page]
  }

  ########## SETS ##########

  set: detail {
    fields: [
      ga_sessions.id
      , ga_sessions.visitnumber
      , ga_sessions.session_count
      , page_path, page_title
    ]
  }
}
