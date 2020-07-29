- dashboard: custom_goal_conversions
  title: Custom Goal Conversions
  layout: newspaper
  load_configuration: wait
  description: "Using the filters, users are able to create a \"conversion\" event\
    \ and see results based on the filters. For example, if I wanted to track how\
    \ many users have \"Added to Cart\" on the \"/store\" page, I'd enter those values\
    \ into the Event Action and Page filters respectively. \n\nValues for Event Action,\
    \ Event Label, Event Category, and Page will vary between different Google Analytics\
    \ instances, so be sure to check with your Google Analytics Admin. \n\nThe filters\
    \ should also provide suggestions based on your data."
  elements:
  - title: Custom Goal Conversion Rate
    name: Custom Goal Conversion Rate
    model: marketing
    explore: ga_sessions
    type: looker_line
    fields: [ga_sessions.visit_start_date, ga_sessions.visits_total, hits.session_conversion_rate]
    fill_fields: [ga_sessions.visit_start_date]
    filters: {}
    sorts: [ga_sessions.visit_start_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: rolling_7_day_conversion_rate, label: Rolling
          7-day Conversion Rate, expression: 'mean(offset_list(${hits.sessions_with_conversions_conversion_rate},-6,7))',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: right,
        series: [{axisId: rolling_7_day_conversion_rate, id: rolling_7_day_conversion_rate,
            name: Rolling 7-day Conversion Rate}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      hits.sessions_with_conversions: column
      ga_sessions.visits_total: column
    series_colors:
      ga_sessions.visits_total: "#FBBC04"
      rolling_7_day_conversion_rate: "#4285F4"
      hits.sessions_with_conversions_conversion_rate: "#34A853"
    series_labels:
      hits.sessions_with_conversions_conversion_rate: Conversion Rate
    defaults_version: 1
    hidden_fields: [hits.sessions_with_conversions_conversion_rate]
    listen:
      Event Action: hits.event_action_goal_selection
      Event Label: hits.event_label_goal_selection
      Event Category: hits.event_category_goal_selection
      Page: hits.page_goal_selection
      Partition Date: ga_sessions.partition_date
    row: 2
    col: 0
    width: 24
    height: 12
  - title: Total Converting Sessions
    name: Total Converting Sessions
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [hits.sessions_with_conversions]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Event Action: hits.event_action_goal_selection
      Event Label: hits.event_label_goal_selection
      Event Category: hits.event_category_goal_selection
      Page: hits.page_goal_selection
      Partition Date: ga_sessions.partition_date
    row: 0
    col: 8
    width: 8
    height: 2
  - title: Total Sessions
    name: Total Sessions
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visits_total]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Event Action: hits.event_action_goal_selection
      Event Label: hits.event_label_goal_selection
      Event Category: hits.event_category_goal_selection
      Page: hits.page_goal_selection
      Partition Date: ga_sessions.partition_date
    row: 0
    col: 0
    width: 8
    height: 2
  - title: Conversion Rate
    name: Conversion Rate
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [hits.session_conversion_rate]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Event Action: hits.event_action_goal_selection
      Event Label: hits.event_label_goal_selection
      Event Category: hits.event_category_goal_selection
      Page: hits.page_goal_selection
      Partition Date: ga_sessions.partition_date
    row: 0
    col: 16
    width: 8
    height: 2
  - title: Top Pages with Conversion
    name: Top Pages with Conversion
    model: marketing
    explore: ga_sessions
    type: looker_grid
    fields: [hits.page_path, hits.conversion_count, hits.sessions_with_conversions,
      hits.session_conversion_rate]
    filters: {}
    sorts: [hits.conversion_count desc]
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: conversions_per_page, label: Conversions
          per Page, expression: "${hits.conversion_count}/${hits.sessions_with_conversions}",
        value_format: !!null '', value_format_name: decimal_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: calculation_2, label: Calculation
          2, expression: 'sum(${hits.conversion_count})', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number, is_disabled: true}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '14'
    rows_font_size: '14'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", hits.page_path, hits.conversion_count, hits.sessions_with_conversions,
      conversions_per_page, hits.sessions_with_conversions_conversion_rate]
    show_totals: true
    show_row_totals: true
    series_labels:
      hits.conversion_count: Total Conversions
      hits.sessions_with_conversions: Sessions with Conversion
    series_column_widths:
      hits.page_path: 361
    series_cell_visualizations:
      hits.conversion_count:
        is_active: true
        palette:
          palette_id: google-diverging-0
          collection_id: google
        value_display: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: percentile, value: 99}}, mirror: false, reverse: false,
            stepped: false}}, bold: false, italic: false, strikethrough: false, fields: [
          hits.sessions_with_conversions_conversion_rate]}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    defaults_version: 1
    listen:
      Event Action: hits.event_action_goal_selection
      Event Label: hits.event_label_goal_selection
      Event Category: hits.event_category_goal_selection
      Page: hits.page_goal_selection
      Partition Date: ga_sessions.partition_date
    row: 14
    col: 0
    width: 24
    height: 13
  filters:
  - name: Event Action
    title: Event Action
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_action_goal_selection
  - name: Event Label
    title: Event Label
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_label_goal_selection
  - name: Event Category
    title: Event Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_category_goal_selection
  - name: Page
    title: Page
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.page_goal_selection
  - name: Partition Date
    title: Partition Date
    type: field_filter
    default_value: 7 days
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
