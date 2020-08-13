- dashboard: custom_page_funnel
  title: Custom Page Funnel
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Top Page Paths
    name: Top Page Paths
    model: google_analytics_360
    explore: ga_sessions
    type: sankey
    fields: [ga_sessions.visits_total, session_flow.page_path_1, session_flow.page_path_2,
      session_flow.page_path_3, session_flow.page_path_4, session_flow.page_path_5,
      session_flow.page_path_6]
    filters: {}
    sorts: [ga_sessions.visits_total desc]
    limit: 50
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: of_total_sessions, label: "% of Total Sessions",
        expression: "${ga_sessions.visits_total}/${ga_sessions.visits_total:total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    hidden_fields: [of_total_sessions]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A853", "#5F6368", "#185ABC",
      "#9AA0A6", "#B31412", "#BDC1C6", "#EA8600", "#E8EAED", "#137333"]
    label_type: name
    show_null_points: false
    series_types: {}
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      If session contained more than 1 page visit.
      Open Look if you want to see page paths as % of total
    defaults_version: 0
    listen:
      Date Range: ga_sessions.partition_date
      Host name: hits.host_name
    row: 37
    col: 0
    width: 24
    height: 12
  - title: Page Path Funnel
    name: Page Path Funnel
    model: google_analytics_360
    explore: ga_sessions
    type: looker_column
    fields: [page_funnel.count_of_page_1, page_funnel.count_of_page_2, page_funnel.count_of_page_3,
      page_funnel.count_of_page_4, page_funnel.count_of_page_5, page_funnel.count_of_page_6,
      ga_sessions.audience_trait]
    filters:
      ga_sessions.partition_date: 1500 days
    sorts: [page_funnel.count_of_page_1 desc]
    limit: 12
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
    trellis: row
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: page_funnel.count_of_page_1,
            id: page_funnel.count_of_page_1, name: "\n            Count of Page 1\n\
              \            "}, {axisId: page_funnel.count_of_page_2, id: page_funnel.count_of_page_2,
            name: "\n    Count of Page 2\n    "}, {axisId: page_funnel.count_of_page_3,
            id: page_funnel.count_of_page_3, name: "\n    Count of Page 3\n    "},
          {axisId: page_funnel.count_of_page_4, id: page_funnel.count_of_page_4, name: "\n\
              \    Count of Page 4\n    "}, {axisId: page_funnel.count_of_page_5,
            id: page_funnel.count_of_page_5, name: "\n    Count of Page 5\n    "},
          {axisId: page_funnel.count_of_page_6, id: page_funnel.count_of_page_6, name: "\n\
              \    Count of Page 6\n    "}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: page_1_of_total, id: page_1_of_total,
            name: Page 1 % of Total}, {axisId: page_2_of_total, id: page_2_of_total,
            name: Page 2 % of Total}, {axisId: page_3_of_total, id: page_3_of_total,
            name: Page 3 % of Total}, {axisId: page_4_of_total, id: page_4_of_total,
            name: Page 4 % of Total}, {axisId: page_5_of_total, id: page_5_of_total,
            name: Page 5 % of Total}, {axisId: page_6_of_total, id: page_6_of_total,
            name: Page 6 % of Total}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    hide_legend: true
    series_types:
      page_1_of_total: scatter
      page_2_of_total: scatter
      page_3_of_total: scatter
      page_4_of_total: scatter
      page_5_of_total: scatter
      page_6_of_total: scatter
    series_colors:
      page_1_of_total: "#ffffff"
      page_2_of_total: "#ffffff"
      page_3_of_total: "#ffffff"
      page_4_of_total: "#ffffff"
      page_5_of_total: "#ffffff"
      page_6_of_total: "#ffffff"
    label_color: [black]
    show_dropoff: true
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    defaults_version: 1
    listen:
      Page 1: page_funnel.page_1
      Page 2: page_funnel.page_2
      Page 3: page_funnel.page_3
      Page 4: page_funnel.page_4
      Page 5: page_funnel.page_5
      Page 6: page_funnel.page_6
      Audience Selector: ga_sessions.audience_selector
    row: 3
    col: 0
    width: 24
    height: 14
  - name: <font color="#34A853" size="45" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> GA 360 Page Pathing </strong> <font color= "#4285F4"size="45">
      Page Funnel </font>
    type: text
    title_text: <font color="#34A853" size="4.5" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> GA 360 Page Pathing </strong> <font color= "#4285F4"size="4.5">
      Page Funnel </font>
    subtitle_text: How are customers moving through our site?
    body_text: "<center> <b>Recommended Action</b>\U0001f447 Update the filters above\
      \ to create your own custom path pathing funnel. Then link from any page in\
      \ the funnel to see what actions occur on that page.<center>"
    row: 0
    col: 0
    width: 19
    height: 3
  - name: <font color= "#4285F4"size="45"> Page Path Funnel </font>
    type: text
    title_text: <font color= "#4285F4"size="4.5"> Page Path Funnel </font>
    subtitle_text: How are people moving through the website as a % of Total
    body_text: "<center> <b>Recommended Action</b>\U0001f447 Use the page filters\
      \ at the top to define the different steps in the funnel.<center>"
    row: 17
    col: 0
    width: 24
    height: 4
  - name: <font color= "#4285F4"size="45"> Natural Page Path </font>
    type: text
    title_text: <font color= "#4285F4"size="4.5"> Natural Page Path </font>
    subtitle_text: How are users naturally flowing through the site?
    body_text: "<center> <b>Recommended Action</b>Drill in to see the breakdown by\
      \ source medium .<center>"
    row: 33
    col: 0
    width: 24
    height: 4
  - title: Page Path Funnel % of Total
    name: Page Path Funnel % of Total
    model: google_analytics_360
    explore: ga_sessions
    type: looker_funnel
    fields: [page_funnel.count_of_page_1, page_funnel.count_of_page_2, page_funnel.count_of_page_3,
      page_funnel.count_of_page_4, page_funnel.count_of_page_5, page_funnel.count_of_page_6]
    filters:
      ga_sessions.partition_date: 1500 days
    sorts: [page_funnel.count_of_page_1 desc]
    limit: 12
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
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
    trellis: row
    stacking: ''
    limit_displayed_rows: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: page_funnel.count_of_page_1,
            id: page_funnel.count_of_page_1, name: "\n            Count of Page 1\n\
              \            "}, {axisId: page_funnel.count_of_page_2, id: page_funnel.count_of_page_2,
            name: "\n    Count of Page 2\n    "}, {axisId: page_funnel.count_of_page_3,
            id: page_funnel.count_of_page_3, name: "\n    Count of Page 3\n    "},
          {axisId: page_funnel.count_of_page_4, id: page_funnel.count_of_page_4, name: "\n\
              \    Count of Page 4\n    "}, {axisId: page_funnel.count_of_page_5,
            id: page_funnel.count_of_page_5, name: "\n    Count of Page 5\n    "},
          {axisId: page_funnel.count_of_page_6, id: page_funnel.count_of_page_6, name: "\n\
              \    Count of Page 6\n    "}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: page_1_of_total, id: page_1_of_total,
            name: Page 1 % of Total}, {axisId: page_2_of_total, id: page_2_of_total,
            name: Page 2 % of Total}, {axisId: page_3_of_total, id: page_3_of_total,
            name: Page 3 % of Total}, {axisId: page_4_of_total, id: page_4_of_total,
            name: Page 4 % of Total}, {axisId: page_5_of_total, id: page_5_of_total,
            name: Page 5 % of Total}, {axisId: page_6_of_total, id: page_6_of_total,
            name: Page 6 % of Total}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    hide_legend: true
    series_types: {}
    series_colors:
      page_1_of_total: "#4285F4"
      page_2_of_total: "#EA4335"
      page_3_of_total: "#FBBC04"
      page_4_of_total: "#34A853"
      page_5_of_total: "#5F6368"
      page_6_of_total: "#185ABC"
    label_color: []
    show_dropoff: false
    defaults_version: 1
    hidden_fields:
    listen:
      Page 1: page_funnel.page_1
      Page 2: page_funnel.page_2
      Page 3: page_funnel.page_3
      Page 4: page_funnel.page_4
      Page 5: page_funnel.page_5
      Page 6: page_funnel.page_6
    row: 21
    col: 0
    width: 24
    height: 12
  - title: Untitled
    name: Untitled
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.partition_date_filter]
    filters:
      ga_sessions.partition_date: 1500 days
    sorts: [ga_sessions.partition_date_filter]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4285F4"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 0
    col: 19
    width: 5
    height: 3
  filters:
  - name: Date Range
    title: Date Range
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
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
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: hits.host_name
  - name: Page 1
    title: Page 1
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: page_funnel.page_1
  - name: Page 2
    title: Page 2
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: page_funnel.page_2
  - name: Page 3
    title: Page 3
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: page_funnel.page_3
  - name: Page 4
    title: Page 4
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: page_funnel.page_4
  - name: Page 5
    title: Page 5
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: page_funnel.page_5
  - name: Page 6
    title: Page 6
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: page_funnel.page_6
  - name: Audience Selector
    title: Audience Selector
    type: field_filter
    default_value: Device
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.audience_selector