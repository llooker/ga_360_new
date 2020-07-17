- dashboard: web_analytics_pulse
  title: 'Web Analytics: Pulse'
  layout: newspaper
  elements:
  - title: Top US States
    name: Top US States
    model: marketing
    explore: ga_sessions
    type: looker_map
    fields: [ga_sessions.visits_total, ga_sessions.region]
    filters:
      ga_sessions.country: United States
      ga_sessions.region: ''
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: dark
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 36.64253952433933
    map_longitude: -98.10797452926636
    map_zoom: 4
    map_value_scale_clamp_max: 0.05
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: of_total, id: of_total,
            name: "% of Total"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: ga_sessions.visits_total, id: ga_sessions.visits_total, name: Session
              Sessions}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_label: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.session_count, ga_sessions.visits_total]
    series_types: {}
    show_null_points: true
    interpolation: linear
    hidden_fields: [ga_sessions.visits_total]
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 46
    col: 0
    width: 12
    height: 14
  - title: Traffic
    name: Traffic
    model: marketing
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.visit_start_week, ga_sessions.visits_total, ga_sessions.bounce_rate,
      ga_sessions.timeonsite_average_per_session]
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    row_total: right
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
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: ga_sessions.bounce_rate, id: ga_sessions.bounce_rate,
            name: Bounce Rate}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: '', orientation: right, series: [
          {axisId: ga_sessions.timeonsite_average_per_session, id: ga_sessions.timeonsite_average_per_session,
            name: Avg. Session Duration}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    size_by_field: ga_sessions.bounce_rate
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '1'
    hidden_series: []
    series_types:
      ga_sessions.bounce_rate: line
      ga_sessions.timeonsite_average_per_session: line
    series_colors: {}
    ordering: none
    show_null_labels: false
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: Entrances to Looker websites based on web properties
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 6
    col: 0
    width: 24
    height: 12
  - title: New vs Returning Users
    name: New vs Returning Users
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.user_type, ga_sessions.unique_visitors]
    pivots: [ga_sessions.user_type]
    sorts: [ga_sessions.user_type 0, ga_sessions.unique_visitors desc 2]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: bottom, series: [{axisId: New User - ga_sessions.unique_visitors,
            id: New User - ga_sessions.unique_visitors, name: New User}, {axisId: Returning
              User - ga_sessions.unique_visitors, id: Returning User - ga_sessions.unique_visitors,
            name: Returning User}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 8, type: linear}]
    x_axis_label: ''
    hidden_series: [ga_sessions.percent_new_sessions]
    series_types: {}
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    note_state: expanded
    note_display: hover
    note_text: "Percentage of new vs. returning users for each web property. \nA user\
      \ can be considered both new & returning in the same report, depending on date\
      \ range."
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 70
    col: 0
    width: 24
    height: 5
  - title: Sessions by Source Channel
    name: Sessions by Source Channel
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.channel_grouping]
    pivots: [ga_sessions.channel_grouping]
    sorts: [ga_sessions.visits_total desc 9, ga_sessions.channel_grouping 0]
    limit: 500
    column_limit: 50
    row_total: right
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
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: "(Other) - ga_sessions.visits_total",
            id: "(Other) - ga_sessions.visits_total", name: "(Other)"}, {axisId: Affiliates
              - ga_sessions.visits_total, id: Affiliates - ga_sessions.visits_total,
            name: Affiliates}, {axisId: Direct - ga_sessions.visits_total, id: Direct
              - ga_sessions.visits_total, name: Direct}, {axisId: Display - ga_sessions.visits_total,
            id: Display - ga_sessions.visits_total, name: Display}, {axisId: Organic
              Search - ga_sessions.visits_total, id: Organic Search - ga_sessions.visits_total,
            name: Organic Search}, {axisId: Paid Search - ga_sessions.visits_total,
            id: Paid Search - ga_sessions.visits_total, name: Paid Search}, {axisId: Referral
              - ga_sessions.visits_total, id: Referral - ga_sessions.visits_total,
            name: Referral}, {axisId: Social - ga_sessions.visits_total, id: Social
              - ga_sessions.visits_total, name: Social}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_label: ''
    hidden_series: [ga_sessions.percent_new_sessions]
    font_size: '14'
    series_types: {}
    series_colors: {}
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      Channel groups are default, as defined by Google
      https://support.google.com/analytics/answer/3297892?hl=en
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 18
    col: 12
    width: 12
    height: 6
  - title: Sessions
    name: Sessions
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visits_total, ga_sessions.page_views_session]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Pages / Session
    series_types: {}
    hidden_fields: []
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 0
    col: 0
    width: 12
    height: 4
  - title: Users
    name: Users
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors, ga_sessions.sessions_per_user]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Sessions / User
    series_types: {}
    hidden_fields: []
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 63
    col: 0
    width: 24
    height: 4
  - title: Avg Session Duration
    name: Avg Session Duration
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.timeonsite_average_per_session, ga_sessions.bounce_rate]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Bounce Rate
    series_types: {}
    hidden_fields: []
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 0
    col: 12
    width: 12
    height: 4
  - title: When are People Visitng?
    name: When are People Visitng?
    model: marketing
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.visit_start_hour_of_day, ga_sessions.visit_start_day_of_week,
      ga_sessions.visits_total]
    pivots: [ga_sessions.visit_start_day_of_week]
    filters:
      ga_sessions.partition_date: 1 years ago for 1 years
    sorts: [ga_sessions.visit_start_day_of_week, ga_sessions.visit_start_hour_of_day
        0]
    limit: 500
    total: true
    row_total: right
    dynamic_fields: [{table_calculation: of_total_sessions, label: "% of Total Sessions",
        expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total:row_total})",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: weekly_of_total_sessions, label: Weekly
          % of Total Sessions, expression: "${ga_sessions.visits_total:row_total}/sum(${ga_sessions.visits_total:row_total})",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      ga_sessions.visit_start_hour_of_day: Hour of Day
      of_total_sessions: Sessions
      ga_sessions.visit_start_day_of_week: Day of Week
      weekly_of_total_sessions: Week Total
    series_cell_visualizations:
      ga_sessions.visits_total:
        is_active: false
        value_display: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: maximum}}, mirror: false, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [of_total_sessions]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: maximum}}, mirror: false, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [weekly_of_total_sessions]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [ga_sessions.visits_total]
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 75
    col: 0
    width: 13
    height: 12
  - title: How often do People Come Back?
    name: How often do People Come Back?
    model: marketing
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.unique_visitors, ga_sessions.visit_number_tier]
    filters:
      ga_sessions.partition_date: 1 years ago for 1 years
    sorts: [ga_sessions.visit_number_tier]
    limit: 500
    total: true
    row_total: right
    dynamic_fields: [{table_calculation: of_total_users, label: "% of Total Users",
        expression: "${ga_sessions.unique_visitors}/${ga_sessions.unique_visitors:total}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
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
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    label_value_format: ''
    series_types: {}
    series_labels:
      ga_sessions.visit_start_hour_of_day: Hour of Day
      of_total_sessions: Sessions
      ga_sessions.visit_start_day_of_week: Day of Week
      weekly_of_total_sessions: Week Total
    column_spacing_ratio: 0.3
    show_dropoff: true
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: false
    transpose: false
    truncate_text: false
    size_to_fit: true
    series_cell_visualizations:
      ga_sessions.visits_total:
        is_active: false
        value_display: false
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: maximum}}, mirror: false, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: []}, {type: along
          a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: maximum}}, mirror: false, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    hidden_fields: [ga_sessions.unique_visitors]
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 75
    col: 13
    width: 11
    height: 12
  - title: Sessions by Devices
    name: Sessions by Devices
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.device_category, ga_sessions.visits_total]
    pivots: [ga_sessions.device_category]
    sorts: [ga_sessions.device_category]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: bottom, series: [{axisId: New User - ga_sessions.unique_visitors,
            id: New User - ga_sessions.unique_visitors, name: New User}, {axisId: Returning
              User - ga_sessions.unique_visitors, id: Returning User - ga_sessions.unique_visitors,
            name: Returning User}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 8, type: linear}]
    x_axis_label: ''
    hidden_series: [ga_sessions.percent_new_sessions]
    series_types: {}
    series_colors:
      tablet - ga_sessions.visits_total: "#592EC2"
    series_labels:
      desktop - ga_sessions.visits_total: Desktop
      mobile - ga_sessions.visits_total: Mobile
      tablet - ga_sessions.visits_total: Tablet
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    note_state: expanded
    note_display: hover
    note_text: "Percentage of new vs. returning users for each web property. \nA user\
      \ can be considered both new & returning in the same report, depending on date\
      \ range."
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 18
    col: 0
    width: 12
    height: 6
  - name: Where are People Visiting From?
    type: text
    title_text: Where are People Visiting From?
    row: 38
    col: 0
    width: 24
    height: 3
  - title: Top Landing Pages
    name: Top Landing Pages
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.landing_page_formatted, ga_sessions.visits_total, ga_sessions.transaction_conversion_rate]
    filters: {}
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{table_calculation: of_total_sessions, label: "% of Total Sessions",
        expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
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
    limit_displayed_rows: true
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: bottom,
        series: [{axisId: ga_sessions.transaction_conversion_rate, id: ga_sessions.transaction_conversion_rate,
            name: Transaction Conversion Rate}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: bottom, series: [{axisId: of_total_sessions, id: of_total_sessions,
            name: "% of Total Sessions"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_label: ''
    size_by_field: ga_sessions.transaction_conversion_rate
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.visits_total]
    font_size: '15'
    series_types:
      ga_sessions.transaction_conversion_rate: scatter
    series_colors:
      ga_sessions.transaction_conversion_rate: "#34A853"
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      Channel groups are default, as defined by Google
      https://support.google.com/analytics/answer/3297892?hl=en
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 26
    col: 0
    width: 9
    height: 12
  - name: Users (2)
    type: text
    title_text: Users
    subtitle_text: ''
    body_text: ''
    row: 60
    col: 0
    width: 24
    height: 3
  - title: Top Countries (Non-US)
    name: Top Countries (Non-US)
    model: marketing
    explore: ga_sessions
    type: looker_map
    fields: [ga_sessions.country, ga_sessions.visits_total]
    filters:
      ga_sessions.country: "-United States"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: dark
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 39.3761002367386
    map_longitude: 6.973786354064942
    map_zoom: 2
    map_value_scale_clamp_max: 0.05
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: of_total, id: of_total,
            name: "% of Total"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: ga_sessions.visits_total, id: ga_sessions.visits_total, name: Session
              Sessions}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_label: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.session_count, ga_sessions.visits_total]
    series_types: {}
    show_null_points: true
    interpolation: linear
    hidden_fields: [ga_sessions.visits_total]
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 46
    col: 12
    width: 12
    height: 14
  - title: Sessions by Continent
    name: Sessions by Continent
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.continent]
    pivots: [ga_sessions.continent]
    filters:
      ga_sessions.continent: "-(not set)"
    sorts: [ga_sessions.visits_total desc 0, ga_sessions.continent]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: true
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: of_total, id: of_total,
            name: "% of Total"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: ga_sessions.visits_total, id: ga_sessions.visits_total, name: Session
              Sessions}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_label: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.session_count, ga_sessions.visits_total]
    series_types: {}
    series_colors: {}
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: dark
    map_position: custom
    map_latitude: 36.64253952433933
    map_longitude: -98.10797452926636
    map_zoom: 4
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_value_scale_clamp_max: 0.05
    show_null_points: true
    interpolation: linear
    hidden_fields:
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 41
    col: 0
    width: 24
    height: 5
  - name: What content is performing best?
    type: text
    title_text: What content is performing best?
    row: 24
    col: 0
    width: 24
    height: 2
  - title: Top Landing Page Detail
    name: Top Landing Page Detail
    model: marketing
    explore: ga_sessions
    type: table
    fields: [ga_sessions.landing_page_formatted, ga_sessions.visits_total, ga_sessions.transaction_revenue_total,
      ga_sessions.transaction_conversion_rate, ga_sessions.bounce_rate, ga_sessions.percent_new_sessions,
      ga_sessions.timeonsite_average_per_session, ga_sessions.page_views_session]
    filters: {}
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
        reverse: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 81c3d7d1-e9ca-4b9f-7eda-f22d4709dfa0, label: Custom, type: continuous,
            stops: [{color: "#ffffff", offset: 0}, {color: "#EA4335", offset: 50},
              {color: "#B31412", offset: 100}]}, options: {steps: 5, reverse: false,
            constraints: {max: {type: percentile, value: 99}, min: {type: percentile,
                value: 10}}}}, bold: false, italic: false, strikethrough: false, fields: [
          ga_sessions.bounce_rate]}, {type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 620e533c-0510-b56a-549b-04671fa7fc9c, label: Custom, type: continuous,
            stops: [{color: "#ffffff", offset: 0}, {color: "#34A853", offset: 50},
              {color: "#137333", offset: 100}]}, options: {steps: 5, constraints: {
              max: {type: percentile, value: 99}}}}, bold: false, italic: false, strikethrough: false,
        fields: [ga_sessions.transaction_revenue_total]}, {type: along a scale...,
        value: !!null '', background_color: !!null '', font_color: !!null '', color_application: {
          collection_id: google, custom: {id: c5d6b90e-67ed-69c9-ebce-4493aff73847,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: "#34A853", offset: 50}, {color: "#137333", offset: 100}]}, options: {
            steps: 5, constraints: {max: {type: percentile, value: 99}}}}, bold: false,
        italic: false, strikethrough: false, fields: [ga_sessions.transaction_conversion_rate]},
      {type: along a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {max: {type: percentile, value: 99}, min: {
                type: percentile, value: 1}}}}, bold: false, italic: false, strikethrough: false,
        fields: [ga_sessions.percent_new_sessions]}, {type: along a scale..., value: !!null '',
        background_color: !!null '', font_color: !!null '', color_application: {collection_id: google,
          palette_id: google-sequential-0, options: {steps: 5, constraints: {max: {
                type: percentile, value: 99}, min: {type: percentile, value: 1}}}},
        bold: false, italic: false, strikethrough: false, fields: [ga_sessions.timeonsite_average_per_session]},
      {type: along a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {max: {type: percentile, value: 99}}}},
        bold: false, italic: false, strikethrough: false, fields: [ga_sessions.page_views_session]}]
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_column_widths:
      ga_sessions.landing_page_formatted: 325
    series_cell_visualizations:
      ga_sessions.visits_total:
        is_active: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: bottom,
        series: [{axisId: ga_sessions.transaction_conversion_rate, id: ga_sessions.transaction_conversion_rate,
            name: Transaction Conversion Rate}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: bottom, series: [{axisId: of_total_sessions, id: of_total_sessions,
            name: "% of Total Sessions"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_label: ''
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.visits_total]
    font_size: '14'
    series_types: {}
    series_colors: {}
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      Channel groups are default, as defined by Google
      https://support.google.com/analytics/answer/3297892?hl=en
    defaults_version: 1
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 26
    col: 9
    width: 15
    height: 12
  - title: Sessions from prev 7-day period
    name: Sessions from prev 7-day period
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visit_start_date, ga_sessions.visits_total]
    filters: {}
    sorts: [ga_sessions.visit_start_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: last_7_days, label: last 7 days, expression: "sum(\n\
          \  offset_list(\n    ${ga_sessions.visits_total}\n    , 0\n    , 7\n  )\n\
          )", value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: previous_7_day_period, label: previous
          7-day period, expression: "sum(\n  offset_list(\n    ${ga_sessions.visits_total}\n\
          \    , 7\n    , 7\n  )\n)", value_format: !!null '', value_format_name: decimal_0,
        is_disabled: false, _kind_hint: measure, _type_hint: number}, {table_calculation: from_previous_7_day_period,
        label: from previous 7-day period, expression: "if(\n  count(offset_list(\n\
          \    ${ga_sessions.visits_total}\n    , 7\n    , 7\n  )) >= 7,\n  ${last_7_days}\
          \ / ${previous_7_day_period} - 1\n  , null\n)", value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: from previous 7-day period
    comparison_label: ''
    conditional_formatting: [{type: greater than, value: 0, background_color: "#34A853",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#EA4335", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    hidden_fields: [ga_sessions.visits_total, last_7_days, previous_7_day_period]
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 4
    col: 0
    width: 8
    height: 2
  - title: Sessions from prev 28-day period
    name: Sessions from prev 28-day period
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visit_start_date, ga_sessions.visits_total]
    filters: {}
    sorts: [ga_sessions.visit_start_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: last_28_days, label: last 28 days, expression: "sum(\n\
          \  offset_list(\n    ${ga_sessions.visits_total}\n    , 0\n    , 28\n  )\n\
          )", value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: previous_28_day_period, label: previous
          28-day period, expression: "sum(\n  offset_list(\n    ${ga_sessions.visits_total}\n\
          \    , 28\n    , 28\n  )\n)", value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, _type_hint: number}, {table_calculation: from_previous_28_day_period,
        label: from previous 28-day period, expression: "if(\n  count(offset_list(\n\
          \    ${ga_sessions.visits_total}\n    , 28\n    , 28\n  )) >= 28,\n  ${last_28_days}\
          \ / ${previous_28_day_period} - 1\n  , null\n)", value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: from previous 28-day period
    comparison_label: ''
    conditional_formatting: [{type: greater than, value: 0, background_color: "#34A853",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#EA4335", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    hidden_fields: [ga_sessions.visits_total, last_28_days, previous_28_day_period]
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 4
    col: 8
    width: 8
    height: 2
  - title: Sessions from prev 90-day period
    name: Sessions from prev 90-day period
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visit_start_date, ga_sessions.visits_total]
    filters: {}
    sorts: [ga_sessions.visit_start_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: last_90_days, label: last 90 days, expression: "sum(\n\
          \  offset_list(\n    ${ga_sessions.visits_total}\n    , 0\n    , 90\n  )\n\
          )", value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: previous_90_day_period, label: previous
          90-day period, expression: "sum(\n  offset_list(\n    ${ga_sessions.visits_total}\n\
          \    , 90\n    , 90\n  )\n)", value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, _type_hint: number}, {table_calculation: from_previous_90_day_period,
        label: from previous 90-day period, expression: "if(\n  count(offset_list(\n\
          \    ${ga_sessions.visits_total}\n    , 90\n    , 90\n  )) >= 90,\n  ${last_90_days}\
          \ / ${previous_90_day_period} - 1\n  , null\n)", value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: from previous 90-day period
    comparison_label: ''
    conditional_formatting: [{type: greater than, value: 0, background_color: "#34A853",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#EA4335", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    hidden_fields: [ga_sessions.visits_total, last_28_days, last_90_days, previous_90_day_period]
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 4
    col: 16
    width: 8
    height: 2
  - title: Users from prev 7-day period
    name: Users from prev 7-day period
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visit_start_date, ga_sessions.unique_visitors]
    filters: {}
    sorts: [ga_sessions.visit_start_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: last_7_days, label: last 7 days, expression: "sum(offset_list(\n\
          \    ${ga_sessions.unique_visitors}\n    , 0\n    , 7\n  )\n)", value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}, {
        table_calculation: previous_7_day_period, label: previous 7-day period, expression: "\n\
          sum(\n  offset_list(\n    ${ga_sessions.unique_visitors}\n    , 7\n    ,\
          \ 7\n  )\n)", value_format: !!null '', value_format_name: decimal_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}, {table_calculation: from_previous_7_day_period,
        label: from previous 7-day period, expression: "if(\n  count(\n    offset_list(\n\
          \      ${ga_sessions.unique_visitors}\n      , 7\n      , 7\n    )\n  )\
          \ >= 7,\n  ${last_7_days} / ${previous_7_day_period} - 1\n  , null\n)",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: from previous 7-day period
    comparison_label: ''
    conditional_formatting: [{type: greater than, value: 0, background_color: "#34A853",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#EA4335", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    hidden_fields: [last_7_days, ga_sessions.unique_visitors, previous_7_day_period]
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 67
    col: 0
    width: 8
    height: 3
  - title: Users from prev 28-day period
    name: Users from prev 28-day period
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visit_start_date, ga_sessions.unique_visitors]
    filters: {}
    sorts: [ga_sessions.visit_start_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: last_28_days, label: last 28 days, expression: "sum(\n\
          \  offset_list(\n    ${ga_sessions.unique_visitors}\n    , 0\n    , 28\n\
          \  )\n)", value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: previous_28_day_period, label: previous
          28-day period, expression: "sum(\n  offset_list(\n    ${ga_sessions.unique_visitors}\n\
          \    , 28\n    , 28\n  )\n)", value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, _type_hint: number}, {table_calculation: from_previous_28_day_period,
        label: from previous 28-day period, expression: "if(\n  count(\n    offset_list(\n\
          \      ${ga_sessions.unique_visitors}\n      , 28\n      , 28\n    )\n \
          \ ) >= 28,\n  ${last_28_days} / ${previous_28_day_period} - 1\n  , null\n\
          )", value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: from previous 28-day period
    comparison_label: ''
    conditional_formatting: [{type: greater than, value: 0, background_color: "#34A853",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#EA4335", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    hidden_fields: [last_28_days, previous_28_day_period, ga_sessions.unique_visitors,
      last_90_days]
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 67
    col: 8
    width: 8
    height: 3
  - title: Users from prev 90-day period
    name: Users from prev 90-day period
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visit_start_date, ga_sessions.unique_visitors]
    filters: {}
    sorts: [ga_sessions.visit_start_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: last_90_days, label: last 90 days, expression: "sum(\n\
          \  offset_list(\n    ${ga_sessions.unique_visitors}\n    , 0\n    , 90\n\
          \  )\n)", value_format: !!null '', value_format_name: decimal_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}, {table_calculation: previous_90_day_period,
        label: previous 90-day period, expression: "sum(\n  offset_list(\n    ${ga_sessions.unique_visitors}\n\
          \    , 90\n    , 90\n  )\n)", value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, _type_hint: number}, {table_calculation: from_previous_90_day_period,
        label: from previous 90-day period, expression: "if(\n  count(\n    offset_list(\n\
          \      ${ga_sessions.unique_visitors}\n      , 90\n      , 90\n    )\n \
          \ ) >= 90,\n  ${last_90_days} / ${previous_90_day_period} - 1\n  , null\n\
          )", value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: from previous 90-day period
    comparison_label: ''
    conditional_formatting: [{type: greater than, value: 0, background_color: "#34A853",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#EA4335", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    hidden_fields: [last_28_days, ga_sessions.unique_visitors, last_90_days_copy,
      last_90_days, previous_90_day_period]
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    listen:
      Partition Date: ga_sessions.partition_date
      Session Date: ga_sessions.visit_start_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 67
    col: 16
    width: 8
    height: 3
  filters:
  - name: Partition Date
    title: Partition Date
    type: field_filter
    default_value: 1 years
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: inline
      options: []
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
  - name: Session Date
    title: Session Date
    type: field_filter
    default_value: 1 years
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: inline
      options: []
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.visit_start_date
  - name: Landing Page Hostname
    title: Landing Page Hostname
    type: string_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: inline
      options: []
