#############################################################################################################
# Purpose: Defines the fields within the traffic source struct in google analytics. Is extending into ga_sessions.view.lkml
#          and should not be joined into GA sessions explore as an independent view file.
#############################################################################################################

view: traffic_source {
  extension: required

  ########## DIMENSIONS ############

  dimension: adcontent {
    view_label: "Acquisition"
    group_label: "Advertising"
    label: "Ad Content"
    description: "For manual campaign tracking, it is the value of the utm_content campaign tracking parameter. For AdWords autotagging, it is the first line of the text for the online Ad campaign. If you use mad libs for the AdWords content, it contains the keywords you provided for the mad libs keyword match. If you use none of the above, its value is (not set)."
    sql: ${TABLE}.trafficsource.adContent ;;

    drill_fields: [campaign, keyword, source, source_medium]
  }

  dimension: campaign {
    view_label: "Acquisition"
    group_label: "Advertising"
    description: "For manual campaign tracking, it is the value of the utm_campaign campaign tracking parameter. For AdWords autotagging, it is the name(s) of the online ad campaign(s) you use for the property. If you use neither, its value is (not set)."
    type: string
    sql: ${TABLE}.trafficsource.campaign ;;
    drill_fields: [ad_content, keyword, source, source_medium]
  }

  dimension: campaigncode {
    hidden: yes
    view_label: "Acquisition"
    group_label: "Advertising"
    label: "Campaign Code"
    description: "For manual campaign tracking, it is the value of the utm_id campaign tracking parameter."
    type: string
    sql: ${TABLE}.trafficsource.campaignCode ;;
  }


  dimension: full_referrer {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The full referring URL including the hostname and path."
    type: string
    sql:
      CASE
        WHEN ${medium} = "referral" THEN CONCAT(${source}, ${referralpath})
      END;;
  }

  dimension: keyword {
    view_label: "Acquisition"
    group_label: "Advertising"
    description: "For manual campaign tracking, it is the value of the utm_term campaign tracking parameter. For AdWords traffic, it contains the best matching targeting criteria. For the display network, where multiple targeting criteria could have caused the ad to show up, it returns the best matching targeting criteria as selected by Ads. This could be display_keyword, site placement, boomuserlist, user_interest, age, or gender. Otherwise its value is (not set)."
    type: string
    sql: ${TABLE}.trafficsource.keyword ;;

   drill_fields: [ad_content, campaign, source, source_medium]
  }

  dimension: medium {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The type of referrals. For manual campaign tracking, it is the value of the utm_medium campaign tracking parameter. For AdWords autotagging, it is cpc. If users came from a search engine detected by Google Analytics, it is organic. If the referrer is not a search engine, it is referral. If users came directly to the property and document.referrer is empty, its value is (none)."
    type: string
    sql: ${TABLE}.trafficsource.medium ;;

   drill_fields: [ad_content, campaign, keyword, source, source_medium]
  }

  dimension: referralpath {
    label: "Referral Path"
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The path of the referring URL (e.g., document.referrer). If someone places on their webpage a link to the property, this is the path of the page containing the referring link."
    sql: ${TABLE}.trafficsource.referralPath ;;

    drill_fields: [source]
  }

  dimension: source {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The source of referrals. For manual campaign tracking, it is the value of the utm_source campaign tracking parameter. For AdWords autotagging, it is google. If you use neither, it is the domain of the source (e.g., document.referrer) referring the users. It may also contain a port address. If users arrived without a referrer, its value is (direct)."
    type: string
    sql: ${TABLE}.trafficsource.source ;;

   drill_fields: [ad_content, campaign, keyword, source_medium]
  }

  dimension: source_medium {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    label: "Source / Medium"
    description: "Combined values of ga:source and ga:medium."
    type: string
    sql: CONCAT(${source}, '/', ${medium}) ;;

   drill_fields: [ad_content, campaign, keyword, source]
  }

  ########## MEASURES ############

  measure: keyword_count {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "Counts distinct keywords grouped by specified dimension."
    type: count_distinct
    sql: ${keyword} ;;
    drill_fields: [keyword, totals.hits, totals.pageviews]
  }

  measure: source_count {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "Counts distinct sources grouped by specified dimension."
    type: count_distinct
    sql: ${source} ;;
    drill_fields: [source, totals.hits, totals.pageviews]
  }

  measure: source_list {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "Concatenates a list from the source field grouped on specified dimension."
    type: list
    list_field: source
  }
}
