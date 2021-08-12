- dashboard: campaign_impact
  title: Campaign Impact
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Users saw the campaign page
    name: Users saw the campaign page
    model: google_analytics_360_v2
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors, user_segment.segment_users, user_segment.retention_rate]
    filters: {}
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#000000"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    hidden_fields: [user_segment.segment_users, user_segment.retention_rate]
    listen:
      Campaign Date: ga_sessions.partition_date
      Page: hits.page_path_formatted
      User Return Date: user_segment.user_segment_timeframe
    row: 3
    col: 0
    width: 12
    height: 4
  - title: Users Returned
    name: Users Returned
    model: google_analytics_360_v2
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors, user_segment.segment_users, user_segment.retention_rate]
    filters: {}
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Retention Rate
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    hidden_fields: [ga_sessions.unique_visitors]
    listen:
      Campaign Date: ga_sessions.partition_date
      Page: hits.page_path_formatted
      User Return Date: user_segment.user_segment_timeframe
    row: 3
    col: 12
    width: 12
    height: 4
  - title: Transaction Conversion Rate
    name: Transaction Conversion Rate
    model: google_analytics_360_v2
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.transaction_conversion_rate, user_segment.segment_transaction_conversion_rate]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: change, label: Change, expression: "${user_segment.segment_transaction_conversion_rate}-${ga_sessions.transaction_conversion_rate}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#EA4335",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    hidden_fields: [user_segment.segment_transaction_conversion_rate, change]
    listen:
      Campaign Date: ga_sessions.partition_date
      Page: hits.page_path_formatted
      User Return Date: user_segment.user_segment_timeframe
    row: 7
    col: 0
    width: 12
    height: 4
  - title: Retained User Transaction Conversion Rate
    name: Retained User Transaction Conversion Rate
    model: google_analytics_360_v2
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.transaction_conversion_rate, user_segment.segment_transaction_conversion_rate]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: change, label: Change, expression: "${user_segment.segment_transaction_conversion_rate}-${ga_sessions.transaction_conversion_rate}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: conversion rate driven by campaign
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#EA4335",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_conversion_rate]
    listen:
      Campaign Date: ga_sessions.partition_date
      Page: hits.page_path_formatted
      User Return Date: user_segment.user_segment_timeframe
    row: 7
    col: 12
    width: 12
    height: 4
  - title: Revenue per User
    name: Revenue per User
    model: google_analytics_360_v2
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.transaction_revenue_per_user, user_segment.segment_transaction_revenue_per_user]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: change, label: Change, expression: "${user_segment.segment_transaction_revenue_per_user}/${ga_sessions.transaction_revenue_per_user}-1",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#ffffff"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#FBBC04",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    hidden_fields: [change]
    listen:
      Campaign Date: ga_sessions.partition_date
      Page: hits.page_path_formatted
      User Return Date: user_segment.user_segment_timeframe
    row: 11
    col: 0
    width: 12
    height: 4
  - title: Revenue per Retained User
    name: Revenue per Retained User
    model: google_analytics_360_v2
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.transaction_revenue_per_user, user_segment.segment_transaction_revenue_per_user]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: change, label: Change, expression: "${user_segment.segment_transaction_revenue_per_user}/${ga_sessions.transaction_revenue_per_user}-1",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: revenue per user driven by campaign
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#FBBC04",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_per_user]
    listen:
      Campaign Date: ga_sessions.partition_date
      Page: hits.page_path_formatted
      User Return Date: user_segment.user_segment_timeframe
    row: 11
    col: 12
    width: 12
    height: 4
  - name: <font color="#34A853" size="45" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> GA360 </strong> <font color= "#4285F4"size="45">
      Campaign Impact </font>
    type: text
    title_text: <font color="#34A853" size="4.5" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> GA360 </strong> <font color= "#4285F4"size="4.5">
      Campaign Impact </font>
    subtitle_text: ''
    body_text: "<center> <b>Recommended Action</b> Select a <b>period</b> and <b>landing\
      \ page</b> for a campaign you ran, and measure its <b>retention</b>  and <b>upsell</b>\
      \ impact. Observe which <b>audiences</b> are benefitting the most from this\
      \ campaign to <b>better target</b> in the future.<center>"
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Impact by Audience
    name: Impact by Audience
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.audience_trait, ga_sessions.unique_visitors, user_segment.segment_users,
      ga_sessions.transaction_revenue_per_user, user_segment.segment_transaction_revenue_per_user,
      ga_sessions.transaction_conversion_rate, user_segment.segment_transaction_conversion_rate]
    filters: {}
    sorts: [retention_rate desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: retention_rate, label: Retention Rate, expression: "${user_segment.segment_users}/${ga_sessions.unique_visitors}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: d, label: Δ, expression: "${user_segment.segment_transaction_conversion_rate}-${ga_sessions.transaction_conversion_rate}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: d_2, label: Δ, expression: "${user_segment.segment_transaction_revenue_per_user}/${ga_sessions.transaction_revenue_per_user}-1",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '16'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", ga_sessions.audience_trait, retention_rate,
      ga_sessions.transaction_revenue_per_user, user_segment.segment_transaction_revenue_per_user,
      d_2, ga_sessions.transaction_conversion_rate, user_segment.segment_transaction_conversion_rate,
      d]
    show_totals: true
    show_row_totals: true
    series_labels:
      user_segment.segment_users: Retained Users
      ga_sessions.transaction_revenue_per_user: Revenue / User
      user_segment.segment_transaction_revenue_per_user: Revenue / Retained User
      ga_sessions.transaction_conversion_rate: Conversion Rate
      user_segment.segment_transaction_conversion_rate: Retained User Conversion Rate
    series_cell_visualizations:
      ga_sessions.unique_visitors:
        is_active: false
      retention_rate:
        is_active: true
      ga_sessions.transaction_conversion_rate:
        is_active: false
      d:
        is_active: true
      d_2:
        is_active: true
    series_text_format:
      user_segment.segment_transaction_conversion_rate: {}
    header_background_color: "#34A853"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    defaults_version: 1
    hidden_fields: [ga_sessions.unique_visitors, user_segment.segment_users]
    listen:
      Campaign Date: ga_sessions.partition_date
      Page: hits.page_path_formatted
      User Return Date: user_segment.user_segment_timeframe
      Audience Selector: ga_sessions.audience_selector
    row: 15
    col: 0
    width: 24
    height: 8
  filters:
  - name: Campaign Date
    title: Campaign Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
  - name: Page
    title: Page
    type: string_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
  - name: User Return Date
    title: User Return Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: user_segment.user_segment_timeframe
  - name: Audience Selector
    title: Audience Selector
    type: field_filter
    default_value: Channel
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.audience_selector