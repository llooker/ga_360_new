- dashboard: web_analytics_pulse
  title: 'Web Analytics: Pulse'
  layout: newspaper
  elements:
  - title: 'Top 15 Countries: Traffic'
    name: 'Top 15 Countries: Traffic'
    model: marketing
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.country, ga_sessions.visits_total]
    filters: {}
    sorts: [totals.visits_total desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${totals.visits_total}/${totals.visits_total:total}",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: [{label: '', orientation: left, series: [{id: ga_sessions.session_count,
            name: Session Session Count, axisId: ga_sessions.session_count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{id: of_total, name: "% of\
              \ Total", axisId: of_total}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: ''
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.session_count, totals.visits_total]
    legend_position: center
    series_types: {}
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
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 28
    col: 0
    width: 12
    height: 9
  - title: 'Top 15 Countries: Conversions'
    name: 'Top 15 Countries: Conversions'
    model: marketing
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.country, ga_sessions.goal_completions]
    filters: {}
    sorts: [ga_sessions.goal_completions desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.goal_completions}/${ga_sessions.goal_completions:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: [{label: !!null '', orientation: left, series: [{id: ga_sessions.all_confirmation_completions,
            name: 'Conversions All Confirmations: Completions', axisId: ga_sessions.all_confirmation_completions}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}, {label: !!null '', orientation: right, series: [{id: of_total,
            name: "% of Total", axisId: of_total}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: ''
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.all_confirmation_completions,
      ga_sessions.goal_completions]
    legend_position: center
    series_types: {}
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
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 28
    col: 12
    width: 12
    height: 9
  - title: 'Company Size: Traffic'
    name: 'Company Size: Traffic'
    model: marketing
    explore: ga_sessions
    type: looker_column
    fields: [segment, ga_sessions.visits_total]
    sorts: [segment]
    limit: 15
    total: true
    dynamic_fields: [{dimension: segment, label: Segment, expression: "if(contains(${hits_customDimensions.value},\"\
          1-10\") OR contains(${hits_customDimensions.value},\"11-50\"),\"1. SMB\"\
          ,\nif(contains(${hits_customDimensions.value},\"51-250\") OR contains(${hits_customDimensions.value},\"\
          251-1K\") \n\tOR contains(${hits_customDimensions.value},\"251-1000\"),\"\
          2. MM\",\nif(contains(${hits_customDimensions.value},\"1K-5K\") OR contains(${hits_customDimensions.value},\"\
          1000+\"),\"3. COM\",\nif(contains(${hits_customDimensions.value},\"5K-10K\"\
          ) OR contains(${hits_customDimensions.value},\"10K-50K\") \n\tOR contains(${hits_customDimensions.value},\"\
          50K-100K\") OR contains(${hits_customDimensions.value},\"100K+\"),\"4. ENT\"\
          ,null))))", value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}, {table_calculation: total, label: "% Total", expression: "${totals.visits_total}/${totals.visits_total:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: circle
    series_types: {}
    limit_displayed_rows: false
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.session_count, totals.visits_total]
    y_axes: [{label: '', orientation: left, series: [{id: ga_sessions.session_count,
            name: Session Session Count, axisId: ga_sessions.session_count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{id: total, name: "% Total",
            axisId: total}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: ''
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      Employee Range based on Clearbit (ID 13% of traffic)

      SMB: 1-50
      MM: 51-1K
      COM: 1K-5K
      ENT: 5K+
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 37
    col: 0
    width: 12
    height: 9
  - title: 'Company Size: Conversions'
    name: 'Company Size: Conversions'
    model: marketing
    explore: ga_sessions
    type: looker_column
    fields: [segment, ga_sessions.goal_completions]
    sorts: [segment]
    limit: 500
    total: true
    dynamic_fields: [{dimension: segment, label: Segment, expression: "if(contains(${hits_customDimensions.value},\"\
          1-10\") OR contains(${hits_customDimensions.value},\"11-50\"),\"1. SMB\"\
          ,\nif(contains(${hits_customDimensions.value},\"51-250\") OR contains(${hits_customDimensions.value},\"\
          251-1K\") \n\tOR contains(${hits_customDimensions.value},\"251-1000\"),\"\
          2. MM\",\nif(contains(${hits_customDimensions.value},\"1K-5K\") OR contains(${hits_customDimensions.value},\"\
          1000+\"),\"3. COM\",\nif(contains(${hits_customDimensions.value},\"5K-10K\"\
          ) OR contains(${hits_customDimensions.value},\"10K-50K\") \n\tOR contains(${hits_customDimensions.value},\"\
          50K-100K\") OR contains(${hits_customDimensions.value},\"100K+\"),\"4. ENT\"\
          ,null))))", value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}, {table_calculation: total, label: "% Total", expression: "${ga_sessions.goal_completions}/${ga_sessions.goal_completions:total}",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: [{label: !!null '', orientation: right, series: [{id: ga_sessions.all_confirmation_completions,
            name: 'Conversions All Confirmations: Completions', axisId: ga_sessions.all_confirmation_completions}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}, {label: !!null '', orientation: right, series: [{id: total,
            name: "% Total", axisId: total}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: ''
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.all_confirmation_completions,
      ga_sessions.goal_completions]
    legend_position: center
    series_types: {}
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
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      Employee Range based on Clearbit (ID 13% of traffic)

      SMB: 1-50
      MM: 51-1K
      COM: 1K-5K
      ENT: 5K+
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 37
    col: 12
    width: 12
    height: 9
  - title: Traffic
    name: Traffic
    model: marketing
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.visit_start_week, ga_sessions.landing_page_hostname, ga_sessions.visits_total]
    pivots: [ga_sessions.landing_page_hostname]
    fill_fields: [ga_sessions.visit_start_week]
    filters: {}
    sorts: [totals.visits_total desc 8]
    limit: 500
    row_total: right
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: ccba75a3-58c7-4b9c-a931-4ffc59e79cba
      options:
        steps: 5
        reverse: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: []
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
    stacking: normal
    limit_displayed_rows: false
    hidden_series: []
    legend_position: center
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: false
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
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: Entrances to Looker websites based on web properties
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 0
    col: 0
    width: 24
    height: 10
  - title: New vs Returning Users
    name: New vs Returning Users
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.user_type, ga_sessions.landing_page_hostname, ga_sessions.unique_visitors]
    pivots: [ga_sessions.user_type]
    filters: {}
    sorts: [ga_sessions.user_type 0, ga_sessions.unique_visitors desc 2]
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: [{label: '', orientation: left, series: [{id: ga_sessions.session_count,
            name: Session Session Count, axisId: ga_sessions.session_count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{id: ga_sessions.percent_new_sessions,
            name: Audience % New Sessions, axisId: ga_sessions.percent_new_sessions}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: ''
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    hidden_series: [ga_sessions.percent_new_sessions]
    legend_position: center
    series_types: {}
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
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    note_state: expanded
    note_display: hover
    note_text: "Percentage of new vs. returning users for each web property. \nA user\
      \ can be considered both new & returning in the same report, depending on date\
      \ range."
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 10
    col: 0
    width: 12
    height: 10
  - title: Traffic Sources
    name: Traffic Sources
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.landing_page_hostname, ga_sessions.channel_grouping, ga_sessions.visits_total]
    pivots: [ga_sessions.channel_grouping]
    filters: {}
    sorts: [totals.visits_total desc 9, ga_sessions.channelGrouping 0]
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: ccba75a3-58c7-4b9c-a931-4ffc59e79cba
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: [{label: '', orientation: left, series: [{id: ga_sessions.session_count,
            name: Session Session Count, axisId: ga_sessions.session_count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{id: ga_sessions.percent_new_sessions,
            name: Audience % New Sessions, axisId: ga_sessions.percent_new_sessions}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: ''
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    hidden_series: [ga_sessions.percent_new_sessions]
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      Channel groups are default, as defined by Google
      https://support.google.com/analytics/answer/3297892?hl=en
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 10
    col: 12
    width: 12
    height: 10
  - title: Web KPIs
    name: Web KPIs
    model: marketing
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.landing_page_hostname, ga_sessions.visits_total, ga_sessions.first_time_sessions,
      ga_sessions.timeonsite_average_per_session, ga_sessions.page_views_session, ga_sessions.bounce_rate]
    filters: {}
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
    series_types: {}
    hidden_fields: []
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: ''
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Page Hostname: ga_sessions.landing_page_hostname
    row: 20
    col: 0
    width: 24
    height: 8
  filters:
  - name: Partition Date
    title: Partition Date
    type: field_filter
    default_value: 6 months
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
  - name: Landing Page Hostname
    title: Landing Page Hostname
    type: field_filter
    default_value: looker.com,de.looker.com,ja.looker.com,fr.looker.com,discover.looker.com,info.looker.com,help.looker.com,docs.looker.com,databases.looker.com,discourse.looker.com,training.looker.com,-NULL,-%statamic%
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.landing_page_hostname
