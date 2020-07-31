- dashboard: behavior
  title: Behavior
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Landing Page Detail
    name: Landing Page Detail
    model: marketing
    explore: ga_sessions
    type: table
    fields: [ga_sessions.landing_page_formatted, ga_sessions.visits_total, ga_sessions.transaction_revenue_total,
      ga_sessions.transaction_conversion_rate, ga_sessions.bounce_rate, ga_sessions.percent_new_sessions,
      ga_sessions.timeonsite_average_per_session, ga_sessions.page_views_session]
    filters:
      ga_sessions.partition_date: 5 years
      ga_sessions.landing_page_hostname: ''
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
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Date Range
    title: Date Range
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
  - name: Host name
    title: Host name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options:
      - hostname
      - " head"
      - tet
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.host_name
