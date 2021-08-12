- dashboard: event_action_funnel
  title: Event Action Funnel
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Event Action Funnel
    name: Event Action Funnel
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_column
    fields: [event_action_funnel.count_of_event_1, event_action_funnel.count_of_event_2,
      event_action_funnel.count_of_event_3, event_action_funnel.count_of_event_4,
      event_action_funnel.count_of_event_5, event_action_funnel.count_of_event_6,
      ga_sessions.audience_trait]
    filters:
      ga_sessions.partition_date: 1500 days
    limit: 12
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
    trellis: row
    stacking: ''
    limit_displayed_rows: false
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
    series_types: {}
    show_dropoff: true
    defaults_version: 1
    listen:
      Page: hits.page_path
      Event 1: event_action_funnel.event_1
      Event 2: event_action_funnel.event_2
      Event 3: event_action_funnel.event_3
      Event 4: event_action_funnel.event_4
      Event 5: event_action_funnel.event_5
      Event 6: event_action_funnel.event_6
      Audience Cohort: ga_sessions.audience_selector
    row: 4
    col: 0
    width: 24
    height: 16
  - name: <font color="#34A853" size="45" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> GA 360 Event Flow </strong> <font color= "#4285F4"size="45">
      Event Funnel </font>
    type: text
    title_text: <font color="#34A853" size="4.5" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> GA 360 Event Flow </strong> <font color= "#4285F4"size="4.5">
      Event Funnel </font>
    subtitle_text: What are customers clicking on our site?
    body_text: "<center> <b>Recommended Action</b>\U0001f447 Update the filters above\
      \ to create your own custom event flow. Alter the audience cohort to dynamically\
      \ view your funnel.<center>"
    row: 0
    col: 0
    width: 19
    height: 4
  - name: <font color= "#4285F4"size="45"> Customer Event Flow </font>
    type: text
    title_text: <font color= "#4285F4"size="4.5"> Customer Event Flow </font>
    subtitle_text: What are customers clicking before our conversion event
    body_text: "<center> <b>Recommended Action</b>\U0001f447 Use the Goal Event filter\
      \ at the top to choose a conversion event.<center>"
    row: 20
    col: 0
    width: 24
    height: 4
  - title: Event Action % of Total Funnel
    name: Event Action % of Total Funnel
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_funnel
    fields: [event_action_funnel.count_of_event_1, event_action_funnel.count_of_event_2,
      event_action_funnel.count_of_event_3, event_action_funnel.count_of_event_4,
      event_action_funnel.count_of_event_5, event_action_funnel.count_of_event_6]
    filters:
      ga_sessions.partition_date: 1500 days
    limit: 12
    query_timezone: America/Los_Angeles
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
    series_types: {}
    show_dropoff: true
    defaults_version: 1
    listen:
      Page: hits.page_path
      Event 1: event_action_funnel.event_1
      Event 2: event_action_funnel.event_2
      Event 3: event_action_funnel.event_3
      Event 4: event_action_funnel.event_4
      Event 5: event_action_funnel.event_5
      Event 6: event_action_funnel.event_6
      Audience Cohort: ga_sessions.audience_selector
    row: 24
    col: 0
    width: 24
    height: 11
  - title: Event Flow
    name: Event Flow
    model: google_analytics_360_v2
    explore: ga_sessions
    type: sankey
    fields: [event_action_facts.event_action, event_action_facts.current_event_plus_1,
      event_action_facts.current_event_plus_2, event_action_facts.current_event_plus_3,
      event_action_facts.current_event_plus_4, event_action_facts.current_event_plus_5,
      event_action_facts.current_event_plus_6, ga_sessions.visits_total]
    filters:
      ga_sessions.partition_date: 1500 days
      event_action_facts.event_action: "-NULL"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A853", "#5F6368", "#185ABC",
      "#9AA0A6", "#B31412", "#BDC1C6", "#EA8600", "#E8EAED", "#137333"]
    label_type: name
    show_null_points: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 0
    series_types: {}
    listen:
      Page: hits.page_path
    row: 35
    col: 0
    width: 24
    height: 15
  - title: Untitled
    name: Untitled
    model: google_analytics_360_v2
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
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4285F4"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 0
    col: 19
    width: 5
    height: 4
  filters:
  - name: Page
    title: Page
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: hits.page_path
  - name: Event 1
    title: Event 1
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: event_action_funnel.event_1
  - name: Event 2
    title: Event 2
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: event_action_funnel.event_2
  - name: Event 3
    title: Event 3
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: event_action_funnel.event_3
  - name: Event 4
    title: Event 4
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: event_action_funnel.event_4
  - name: Event 5
    title: Event 5
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: event_action_funnel.event_5
  - name: Event 6
    title: Event 6
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: event_action_funnel.event_6
  - name: Goal Event
    title: Goal Event
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_action
  - name: Audience Cohort
    title: Audience Cohort
    type: field_filter
    default_value: Device
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.audience_selector