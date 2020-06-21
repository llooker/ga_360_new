- dashboard: web_analytics_pages__content
  title: 'Web Analytics: Pages & Content'
  layout: newspaper
  elements:
  - title: Most viewed pages
    name: Most viewed pages
    model: marketing
    explore: ga_sessions
    type: table
    fields: [hits.page_path, ga_sessions.page_views_total, hits.unique_page_count, hits.entrance_rate,
      hits.exit_rate]
    filters: {}
    sorts: [ga_sessions.page_views_total desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    subtotals_at_bottom: false
    hidden_fields: []
    y_axes: []
    listen:
      Date Range: ga_sessions.partition_date
      Hostname: hits.host_name
    row: 0
    col: 0
    width: 24
    height: 10
  - title: 'Pages: Scroll Through Rate'
    name: 'Pages: Scroll Through Rate'
    model: marketing
    explore: ga_sessions
    type: looker_funnel
    fields: [hits.count, scroll_through]
    pivots: [scroll_through]
    filters:
      hits.event_category: Scroll Tracking
    sorts: [scroll_through]
    limit: 500
    column_limit: 50
    dynamic_fields: [{dimension: scroll_through, label: Scroll Through, expression: "if(contains(${hits.event_action},\"\
          10%\"),\"1. 10%\",\nif(contains(${hits.event_action},\"25%\"),\"\
          2. 25%\",\nif(contains(${hits.event_action},\"50%\"),\"3. 50%\"\
          ,\nif(contains(${hits.event_action},\"75%\"),\"4. 75%\",\nif(contains(${hits.event_action},\"\
          90%\"),\"5. 90%\",\nif(contains(${hits.event_action},\"100%\"),\"\
          6. 100%\",null))))))", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors: ["#1D98D3", "#3B4260", "#39A736", "#F3BF0E", "#E57200", "#5DCCCC",
      "#7e64e0", "#F663D6", "#603535", "#A5C740", "#B54B4B", "#B1B0B0"]
    smoothedBars: false
    orientation: automatic
    labelPosition: right
    percentType: prior
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    series_types: {}
    hidden_fields: []
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: |-
      How far through the page do visitors scroll through?
      To see scroll through rate of a specific page, use Pages: Scroll Through Rate filter. Use page path (ex. /product/pricing)
    listen:
      'Pages: Scroll Through Rate': hits.event_label
      Date Range: ga_sessions.partition_date
      Hostname: hits.host_name
    row: 30
    col: 0
    width: 12
    height: 11
  - title: 'Video: View Through Rate'
    name: 'Video: View Through Rate'
    model: marketing
    explore: ga_sessions
    type: looker_funnel
    fields: [hits.count, video_actions]
    pivots: [video_actions]
    filters:
      hits.event_category: "%Video:%"
      video_actions: "-%Buffering%,-%Pause%,-%undefined%,-NULL"
    sorts: [video_actions]
    limit: 500
    column_limit: 50
    dynamic_fields: [{dimension: video_actions, label: Video Actions, expression: "if(contains(${hits.event_action},\"\
          Start playing\"),\"1. Start\",\nif(contains(${hits.event_action},\"\
          Reached 10%\"),\"2. 10%\",\nif(contains(${hits.event_action},\"\
          Reached 25%\"),\"3. 25%\",\nif(contains(${hits.event_action},\"\
          Reached 50%\"),\"4. 50%\",\nif(contains(${hits.event_action},\"\
          Reached 75%\"),\"5. 75%\",\nif(contains(${hits.event_action},\"\
          Reached 90%\"),\"6. 90%\",\nif(contains(${hits.event_action},\"\
          Reached the end\"),\"7. 100%\",\nif(contains(${hits.event_action},\"\
          Buffering\"),\"Buffering\",\nif(contains(${hits.event_action},\"\
          Pause\"),\"Pause\",null)))))))))", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors: ["#1D98D3", "#3B4260", "#39A736", "#F3BF0E", "#E57200", "#5DCCCC",
      "#7e64e0", "#F663D6", "#603535", "#A5C740", "#B54B4B", "#B1B0B0"]
    smoothedBars: false
    orientation: automatic
    labelPosition: right
    percentType: prior
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    stacking: normal
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    hidden_series: [video_actions___null - hits.count, Pause - hits.count, Buffering
        - hits.count]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
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
    hidden_fields: []
    y_axes: []
    note_state: expanded
    note_display: hover
    note_text: "How far through a video is viewed?\nTo see view through rate of a\
      \ specific video, use Videos: View Through Rate filter. \nInclude \"Video:\"\
      \ & name of video (ex. A Data-Driven Day)"
    listen:
      Date Range: ga_sessions.partition_date
      Hostname: hits.host_name
    row: 30
    col: 12
    width: 12
    height: 11
  - title: Top Page Paths
    name: Top Page Paths
    model: marketing
    explore: ga_sessions
    type: sankey
    fields: [session_page_facts.landing_page_path, session_page_facts.second_page_path,
      session_page_facts.third_page_path, ga_sessions.visits_total]
    filters:
      session_page_facts.second_page_path: "-NULL"
    sorts: [ga_sessions.visits_total desc]
    limit: 20
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: of_total_sessions, label: "% of Total Sessions",
        expression: "${ga_sessions.visits_total}/${ga_sessions.visits_total:total}", value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}]
    series_types: {}
    hidden_fields: [of_total_sessions]
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      If session contained more than 1 page visit.
      Open Look if you want to see page paths as % of total
    listen:
      Date Range: ga_sessions.partition_date
      Hostname: hits.host_name
    row: 10
    col: 0
    width: 24
    height: 12
  - title: Navigation Clicks
    name: Navigation Clicks
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [hits.event_action, hits.count]
    filters:
      hits.event_category: Nav
    sorts: [hits.count desc]
    limit: 500
    column_limit: 50
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
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
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
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Items clicked in looker.com top navigation
    listen:
      Date Range: ga_sessions.partition_date
    row: 22
    col: 0
    width: 12
    height: 8
  - title: Homepage Clicks
    name: Homepage Clicks
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [clicked_on, hits.event_action, hits.count]
    filters:
      hits.event_category: "%HP%,%btn%"
      hits.event_label: 'from: https://looker.com/'
    sorts: [hits.count desc]
    limit: 100
    column_limit: 50
    dynamic_fields: [{dimension: clicked_on, label: Clicked on, expression: "if(contains(${hits.event_category},\"\
          btn\"), \"Button\",\nif(contains(${hits.event_category},\"HP Customer\
          \ Logos\"), \"Logos\",\nif(contains(${hits.event_category},\"Video\"\
          ), \"Video\",\nif(contains(${hits.event_action}, \"sticky\"), \"\
          HP Promo Bar\",\nif(contains(${hits.event_category},\"HP Report\
          \ Carousel\"), \"Report\",\nnull)))))", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
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
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
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
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Items clicked on looker.com homepage
    listen:
      Date Range: ga_sessions.partition_date
    row: 22
    col: 12
    width: 12
    height: 8
  - title: Pageviews by Content Group
    name: Pageviews by Content Group
    model: marketing
    explore: ga_sessions
    type: looker_column
    fields: [content_group, hits.page_count]
    filters:
      ga_sessions.partition_date: ''
    limit: 50
    column_limit: 50
    dynamic_fields: [{dimension: content_group, label: Content Group, expression: "if(contains(${hits.page_path_level_1},\
          \ \"solutions\"), \"Solutions\",\nif(contains(${hits.page_path_level_1},\
          \ \"product\") OR contains(${hits.page_path_level_1}, \"professional-services\"\
          ), \"Product\",\nif(contains(${hits.page_path_level_1}, \"platform\")\
          \ OR contains(${hits.page_path_level_1}, \"partner-network\"), \"Platform\"\
          ,\nif(contains(${hits.page_path_level_1}, \"blog\"), \"Blog\",\nif(contains(${hits.page_path_level_1},\
          \ \"blocks\"), \"Blocks\",\nif(contains(${hits.page_path_level_1}, \"\
          customers\"), \"Customer Content\",\nif(contains(${hits.page_path_level_1},\
          \ \"company\") OR contains(${hits.page_path_level_1}, \"news\") OR contains(${hits.page_path_level_1},\
          \ \"events\"), \"Company\",\nif(contains(${hits.page_path_level_1}, \"\
          demo\") OR contains(${hits.page_path_level_1}, \"learn\") OR contains(${hits.host_name},\
          \ \"discover.looker.com\"), \"LP\",\nif(contains(${hits.page_path_level_1},\
          \ \"data-topics\"), \"Data Topics\",\nif(contains(${hits.host_name},\
          \ \"info.looker.com\"), \"Uberflip\",\"Other content\"\n\t))))))))))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, _type_hint: string}]
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
    stacking: ''
    limit_displayed_rows: false
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
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      Pages grouped for info.looker.com, discover.looker.com & looker.com
      "Other content" includes HP
    listen: {}
    row: 41
    col: 0
    width: 24
    height: 9
  filters:
  - name: 'Pages: Scroll Through Rate'
    title: 'Pages: Scroll Through Rate'
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_label
  - name: 'Video: View Through Rate'
    title: 'Video: View Through Rate'
    type: field_filter
    default_value: Null
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_category
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
  - name: Hostname
    title: Host name
    type: field_filter
    default_value: Null
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: hits.host_name
