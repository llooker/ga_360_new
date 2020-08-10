- dashboard: ga360_overview
  title: GA360 Overview
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Top US States
    name: Top US States
    model: google_analytics_360
    explore: ga_sessions
    type: looker_geo_choropleth
    fields: [ga_sessions.visits_total, ga_sessions.region]
    filters:
      ga_sessions.country: United States
      ga_sessions.region: "-not available in demo dataset"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    outer_border_color: ''
    inner_border_color: ''
    colors: ["#f9f9f9", "#4285F4", "#185ABC"]
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 21
    col: 9
    width: 7
    height: 8
  - title: Traffic
    name: Traffic
    model: google_analytics_360
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.visit_start_week, ga_sessions.visits_total, ga_sessions.bounce_rate,
      ga_sessions.timeonsite_average_per_session]
    filters: {}
    sorts: [ga_sessions.visit_start_week]
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
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
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
    series_colors:
      ga_sessions.visits_total: "#FBBC04"
      ga_sessions.timeonsite_average_per_session: "#4285F4"
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: Entrances to Looker websites based on web properties
    defaults_version: 1
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 6
    col: 0
    width: 16
    height: 10
  - title: Top Referrers
    name: Top Referrers
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.source]
    filters:
      ga_sessions.medium: referral
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
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
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: of_total, id: of_total,
            name: "% of Total"}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: ga_sessions.visits_total, id: ga_sessions.visits_total, name: Sessions}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_label: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [ga_sessions.percent_new_sessions, of_total]
    font_size: '14'
    series_types: {}
    series_colors:
      ga_sessions.visits_total: "#FBBC04"
      of_total: "#EA8600"
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 38
    col: 0
    width: 12
    height: 12
  - title: Sessions
    name: Sessions
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visits_total, ga_sessions.percent_new_sessions]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#ffffff"
    value_format: ''
    comparison_label: New Sessions
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#FBBC04",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 4
    col: 0
    width: 8
    height: 2
  - title: Users
    name: Users
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors, ga_sessions.percent_returning_visitors]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#ffffff"
    value_format: ''
    comparison_label: Returning Users
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#185ABC",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 19
    col: 0
    width: 24
    height: 2
  - title: Avg Session Duration
    name: Avg Session Duration
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.timeonsite_average_per_session]
    filters: {}
    limit: 500
    column_limit: 50
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
    comparison_label: Bounce Rate
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 4
    col: 16
    width: 8
    height: 2
  - name: "<font size=16px>Acquisition</font>"
    type: text
    title_text: "<font size=16px>Acquisition</font>"
    subtitle_text: How are people finding you?
    body_text: ''
    row: 29
    col: 0
    width: 24
    height: 3
  - title: Top Landing Pages
    name: Top Landing Pages
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.landing_page_formatted, ga_sessions.visits_total]
    filters: {}
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}, {table_calculation: running_total,
        label: Running Total, expression: 'running_total(${of_total_sessions})', value_format: !!null '',
        value_format_name: percent_0, is_disabled: true, _kind_hint: measure, _type_hint: number}]
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
    stacking: ''
    limit_displayed_rows: true
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
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: top, series: [{axisId: of_total, id: of_total,
            name: "% of Total"}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: bottom,
        series: [{axisId: ga_sessions.visits_total, id: ga_sessions.visits_total,
            name: Sessions}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_label: ''
    size_by_field: ga_sessions.transaction_conversion_rate
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [ga_sessions.percent_new_sessions, running_total, of_total_sessions,
      of_total]
    font_size: '15'
    series_types:
      ga_sessions.transaction_conversion_rate: scatter
      running_total: area
    series_colors:
      ga_sessions.transaction_conversion_rate: "#34A853"
      ga_sessions.visits_total: "#FBBC04"
      of_total_sessions: "#EA8600"
      running_total: "#BDC1C6"
    label_color: []
    show_null_points: true
    interpolation: monotone
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Top 10 Landing pages based on Sessions within timeframe
    defaults_version: 1
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 38
    col: 12
    width: 12
    height: 12
  - name: "<font size=16px> Audience </font><br>"
    type: text
    title_text: "<font size=16px> Audience </font><br>"
    subtitle_text: Who is visiting your website?
    body_text: ''
    row: 16
    col: 0
    width: 24
    height: 3
  - title: Top Countries (Non-US)
    name: Top Countries (Non-US)
    model: google_analytics_360
    explore: ga_sessions
    type: looker_geo_choropleth
    fields: [ga_sessions.country, ga_sessions.visits_total]
    filters:
      ga_sessions.country: "-United States"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    map: world
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    show_antarctica: false
    outer_border_color: ''
    inner_border_color: ''
    colors: ["#f9f9f9", "#4285F4", "#185ABC"]
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 21
    col: 16
    width: 8
    height: 8
  - title: Sessions by Continent
    name: Sessions by Continent
    model: google_analytics_360
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.visits_total, ga_sessions.continent, ga_sessions.visit_start_month]
    pivots: [ga_sessions.continent]
    filters:
      ga_sessions.continent: "-(not set)"
    sorts: [ga_sessions.continent 0, ga_sessions.visit_start_month]
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
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
    hidden_fields:
    defaults_version: 1
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 21
    col: 0
    width: 9
    height: 8
  - name: "<font size=16px> Behavior</font> "
    type: text
    title_text: "<font size=16px> Behavior</font> "
    subtitle_text: What are people doing on your website?
    body_text: ''
    row: 50
    col: 0
    width: 24
    height: 3
  - title: Bounces
    name: Bounces
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.bounces_total, ga_sessions.bounce_rate]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#ffffff"
    value_format: ''
    comparison_label: Bounce Rate
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#EA4335",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 4
    col: 8
    width: 8
    height: 2
  - title: Session Duration
    name: Session Duration
    model: google_analytics_360
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.visits_total, ga_sessions.time_on_site_tier]
    fill_fields: [ga_sessions.time_on_site_tier]
    filters: {}
    sorts: [ga_sessions.time_on_site_tier]
    limit: 500
    column_limit: 50
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
    hidden_fields: [ga_sessions.visits_total]
    note_state: expanded
    note_display: hover
    note_text: "% of Total sessions by Session Duration (Seconds) broken out into\
      \ Tiers"
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 6
    col: 16
    width: 8
    height: 10
  - title: Page Views
    name: Page Views
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [hits.page_count, hits.unique_page_count]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#ffffff"
    value_format: ''
    comparison_label: Unique Pageviews
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#B31412",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 53
    col: 0
    width: 12
    height: 2
  - title: Avg Time on Page
    name: Avg Time on Page
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [hits.page_count, time_on_page.average_time_on_page, hits.page_path_formatted]
    filters: {}
    sorts: [hits.page_count desc]
    limit: 500
    column_limit: 50
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
    y_axes: []
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    font_size: '16'
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#000000", label: Avg}]
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
    value_format: ''
    comparison_label: Unique Pageviews
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#4285F4",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [hits.page_count]
    note_state: expanded
    note_display: hover
    note_text: ''
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 55
    col: 12
    width: 12
    height: 11
  - title: Top Pages
    name: Top Pages
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [hits.page_count, hits.unique_page_count, hits.page_path_formatted]
    filters: {}
    sorts: [hits.page_count desc]
    limit: 500
    column_limit: 50
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: hits.page_count, id: hits.page_count,
            name: Page Views}, {axisId: hits.unique_page_count, id: hits.unique_page_count,
            name: Unique Page Views}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    label_value_format: ''
    series_types:
      hits.unique_page_count: scatter
    series_colors:
      hits.page_count: "#B31412"
      hits.unique_page_count: "#BDC1C6"
    series_labels:
      hits.page_count: Page Views
      hits.unique_page_count: Unique Page Views
    label_color: ["#B31412", transparent]
    custom_color_enabled: true
    custom_color: "#ffffff"
    show_single_value_title: true
    value_format: 0.0,,"M"
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Unique Pageviews
    enable_conditional_formatting: true
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#B31412",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    note_state: expanded
    note_display: hover
    note_text: Top Pages based on Page Views within timeframe
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 55
    col: 0
    width: 12
    height: 11
  - title: Navigation Bar
    name: Navigation Bar
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.dash_nav]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    series_types: {}
    listen:
      Date: ga_sessions.partition_date
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Sessions by Source Channel
    name: Sessions by Source Channel
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.audience_trait, audience_cohorts.rank]
    pivots: [audience_cohorts.rank, ga_sessions.audience_trait]
    filters:
      ga_sessions.audience_selector: Channel
    sorts: [ga_sessions.visits_total desc 0, audience_cohorts.rank]
    limit: 500
    column_limit: 50
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
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 32
    col: 0
    width: 24
    height: 6
  - title: Avg Time on Page
    name: Avg Time on Page (2)
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [time_on_page.average_time_on_page]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: ''
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: expanded
    note_display: hover
    note_text: Avg time spent on each page in session
    listen:
      Landing Page Hostname: ga_sessions.landing_page_hostname
      Date: ga_sessions.partition_date
    row: 53
    col: 12
    width: 12
    height: 2
  - name: "<font size=16px>Overview</font>"
    type: text
    title_text: "<font size=16px>Overview</font>"
    subtitle_text: Overview of traffic to website
    body_text: ''
    row: 2
    col: 0
    width: 24
    height: 2
  filters:
  - name: Date
    title: Partition Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: inline
      options: []
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
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
