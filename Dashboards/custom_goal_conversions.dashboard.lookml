- dashboard: custom_goal_conversions
  title: Custom Goal Conversions
  layout: newspaper
  preferred_viewer: dashboards
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
    model: google_analytics_360
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.visit_start_date, ga_sessions.visits_total, hits.has_completed_goal]
    pivots: [hits.has_completed_goal]
    fill_fields: [ga_sessions.visit_start_date, hits.has_completed_goal]
    filters: {}
    sorts: [ga_sessions.visit_start_date, hits.has_completed_goal]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: rolling_7_day_conversion_rate, label: Rolling
          7-day Conversion Rate, expression: "pivot_where(\n  ${hits.has_completed_goal}=yes\n\
          \  , mean(\n    offset_list(${ga_sessions.visits_total}/${ga_sessions.visits_total:row_total},-6,7)\n\
          \  )\n)", value_format: !!null '', value_format_name: percent_0, _kind_hint: supermeasure,
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
    stacking: normal
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
    y_axes: [{label: '', orientation: left, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: right,
        series: [{axisId: rolling_7_day_conversion_rate, id: rolling_7_day_conversion_rate,
            name: Rolling 7-day Conversion Rate}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      rolling_7_day_conversion_rate: line
    series_colors:
      ga_sessions.visits_total: "#FBBC04"
      rolling_7_day_conversion_rate: "#4285F4"
      ga_sessions.total_conversions_conversion_rate: "#34A853"
      Yes - ga_sessions.visits_total: "#34A853"
      No - ga_sessions.visits_total: "#FBBC04"
    series_labels:
      ga_sessions.total_conversions_conversion_rate: Conversion Rate
      No - ga_sessions.visits_total: Sessions
      Yes - ga_sessions.visits_total: Sessions with Conversion
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [ga_sessions.total_conversions_conversion_rate]
    note_state: collapsed
    note_display: hover
    note_text: Total Sessions, Sessions with Conversions, and Session Avg 7-day Conversion
      rate by day based on all filters.
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 10
    col: 0
    width: 14
    height: 11
  - title: Converting Sessions
    name: Converting Sessions
    model: google_analytics_360
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
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#34A853"
    value_format: 0.0,"K"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#34A853",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Total sessions that had at least one converting event (based on filters).
      Each session will only be counted once, even if there are multiple converting
      hits/events.
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 8
    col: 14
    width: 5
    height: 2
  - title: Total Sessions
    name: Total Sessions
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visits_total]
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
    custom_color: "#FBBC04"
    value_format: 0.0,"K"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#FBBC04",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Total sessions within timeframe (includes sessions without a converting
      hit/event).
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 8
    col: 0
    width: 14
    height: 2
  - title: Session CNV Rate
    name: Session CNV Rate
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [hits.session_conversion_rate]
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
    custom_color: "#34A853"
    value_format: ''
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#4285F4",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: "(Sessions with Conversion / Total Sessions in timeframe)"
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 8
    col: 19
    width: 5
    height: 2
  - title: Top Events
    name: Top Events
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [hits.conversion_count, hits.full_event]
    filters:
      hits.has_completed_goal: 'Yes'
    sorts: [hits.conversion_count desc]
    limit: 10
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: hits.conversion_count,
            id: hits.conversion_count, name: Total Conversions}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_types: {}
    series_colors:
      hits.conversion_count: "#B31412"
    series_labels:
      hits.conversion_count: Total Conversions
      ga_sessions.total_conversions: Sessions with Conversion
      hits.full_event: Event
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: unstyled
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '11'
    rows_font_size: '11'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    pinned_columns:
      hits.full_event: left
    column_order: ["$$$_row_numbers_$$$", hits.full_event, hits.conversion_count,
      conversions_per_page]
    show_totals: false
    show_row_totals: true
    series_column_widths:
      hits.page_path: 361
      hits.conversion_count: 150
    series_cell_visualizations:
      hits.conversion_count:
        is_active: true
        palette:
          palette_id: google-diverging-0
          collection_id: google
        value_display: true
      hits.sessions_with_conversions:
        is_active: true
    header_font_color: "#fff"
    header_background_color: "#185ABC"
    conditional_formatting: []
    series_value_format:
      hits.conversion_count: 0.0,"K"
      hits.sessions_with_conversions: 0.0,"K"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Total conversions (based on filters) by Unique Events (concatenates
      Event Category, Event Action, Event Label, and Event Page).
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 26
    col: 12
    width: 12
    height: 11
  - title: Reverse Goal Path
    name: Reverse Goal Path
    model: google_analytics_360
    explore: ga_sessions
    type: sankey
    fields: [page_facts.current_page_minus_3, page_facts.current_page_minus_2, page_facts.current_page_minus_1,
      hits.page_path_formatted, hits.sessions_with_conversions]
    filters:
      hits.has_completed_goal: 'Yes'
    sorts: [hits.sessions_with_conversions desc]
    limit: 25
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: of_total_sessions, label: "% of Total Sessions",
        expression: "${hits.sessions_with_conversions}/${hits.sessions_with_conversions:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    hidden_fields: [hits.sessions_with_conversions]
    hidden_points_if_no: []
    series_labels:
      hits.page_path_formatted: Goal Completion Page
      page_facts.current_page_minus_1: Page -1
      page_facts.current_page_minus_2: Page -2
      page_facts.current_page_minus_3: Page -3
      page_facts.current_page_minus_4: Page -4
      page_facts.current_page_minus_5: Page -5
      page_facts.current_page_minus_6: Page -6
      of_total_sessions: "% of total"
    show_view_names: false
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A853", "#5F6368", "#185ABC",
      "#9AA0A6", "#B31412", "#BDC1C6", "#EA8600", "#E8EAED", "#137333"]
    label_type: name
    show_null_points: true
    show_row_numbers: true
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: unstyled
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: false
    show_row_totals: true
    series_column_widths:
      hits.page_path_formatted: 300
      page_facts.current_page_minus_1: 300
      page_facts.current_page_minus_2: 250
      page_facts.current_page_minus_3: 225
      page_facts.current_page_minus_4: 200
    series_cell_visualizations:
      hits.sessions_with_conversions:
        is_active: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    header_font_color: "#ffffff"
    header_background_color: "#B31412"
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {max: {type: percentile, value: 99}}}},
        bold: false, italic: false, strikethrough: false, fields: [of_total_sessions]}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: Sessions with Conversion by Goal Completion Page (Location) with all
      page paths that led to that page.
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 49
    col: 0
    width: 12
    height: 11
  - title: Top Goal Completion Page(s)
    name: Top Goal Completion Page(s)
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [hits.conversion_count, hits.page_path_formatted, hits.session_conversion_rate]
    filters:
      hits.conversion_count: ">0"
    sorts: [hits.conversion_count desc]
    limit: 10
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
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: hits.conversion_count,
            id: hits.conversion_count, name: Total Conversions}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: '', orientation: bottom, series: [{axisId: hits.session_conversion_rate,
            id: hits.session_conversion_rate, name: Session Conversion Rate}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    size_by_field: hits.session_conversion_rate
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_types:
      hits.session_conversion_rate: scatter
      hits.sessions_with_conversions: scatter
    series_colors:
      hits.conversion_count: "#B31412"
      hits.session_conversion_rate: "#4285F4"
    series_labels:
      hits.conversion_count: Total Conversions
      ga_sessions.total_conversions: Sessions with Conversion
      hits.full_event: Event
    label_color: [transparent, "#4285F4"]
    show_sql_query_menu_options: false
    pinned_columns:
      hits.full_event: left
    column_order: ["$$$_row_numbers_$$$", hits.page_path_formatted, hits.conversion_count,
      hits.sessions_with_conversions, hits.session_conversion_rate]
    show_totals: false
    show_row_totals: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_column_widths:
      hits.page_path: 361
      hits.full_event: 618
      hits.sessions_with_conversions: 170
      hits.conversion_count: 140
      hits.session_conversion_rate: 175
      hits.page_path_formatted: 300
    series_cell_visualizations:
      hits.conversion_count:
        is_active: true
        palette:
          palette_id: google-diverging-0
          collection_id: google
        value_display: true
      hits.sessions_with_conversions:
        is_active: true
    table_theme: unstyled
    enable_conditional_formatting: true
    header_background_color: "#FBBC04"
    header_text_alignment: left
    header_font_size: '11'
    rows_font_size: '11'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: percentile, value: 99}}, mirror: false, reverse: false,
            stepped: false}}, bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format:
      hits.conversion_count: 0.0,"K"
      hits.sessions_with_conversions: 0.0,"K"
    hide_totals: false
    hide_row_totals: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: Total Conversions (based on filters) by Page the conversion occurred
      on. If the conversion is a page, then there will only be one row.
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 26
    col: 0
    width: 12
    height: 11
  - title: Total Conversions
    name: Total Conversions
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [hits.conversion_count]
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
    custom_color: "#B31412"
    value_format: 0.0,"K"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#B31412",
        font_color: "#ffffff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Total Pages or Events (conversions) in timeframe that match filter
      input. Aggregates multiple conversions within the same session.
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 24
    col: 0
    width: 24
    height: 2
  - name: <font color="#34A853" size="12" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> Custom </strong> <font color= "#4285F4"size="12">
      Conversions </font>
    type: text
    title_text: <font color="#34A853" size="12" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> Custom </strong> <font color= "#4285F4"size="12">
      Conversions </font>
    subtitle_text: ''
    body_text: "<center> \n<font size=4px><b>Instructions:</b> Select any permutation\
      \ of <b>Event Action</b>, <b>Event Label</b>, <b>Event Category</b> and/or <b>Page</b>\
      \ filters at the top to select your goal(s). Then click <b>Reload Data</b> button\
      \ at the top right.\n </font>\n<br>\n<br>\n<font size=3px><b>Optional</b>: Update\
      \ <b>Audience Selector</b> filter to update the <em>Conversion Rate by Audience\
      \ Cohort</em> tile\n</font>\n </center>"
    row: 2
    col: 0
    width: 24
    height: 4
  - title: Reverse Event Action Path
    name: Reverse Event Action Path
    model: google_analytics_360
    explore: ga_sessions
    type: sankey
    fields: [event_action_facts.current_event_minus_3, event_action_facts.current_event_minus_2,
      event_action_facts.current_event_minus_1, ga_sessions.visits_total, event_action_facts.event_action]
    filters:
      hits.event_action: "-NULL"
      event_action_facts.current_event_minus_1: "-NULL"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    query_timezone: America/Los_Angeles
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A853", "#5F6368", "#185ABC",
      "#9AA0A6", "#B31412", "#BDC1C6", "#EA8600", "#E8EAED", "#137333"]
    label_type: name
    show_null_points: true
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
    defaults_version: 0
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      'Goal: Event Action': event_action_facts.event_action
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 49
    col: 12
    width: 12
    height: 11
  - name: "<hr>"
    type: text
    title_text: "<hr>"
    subtitle_text: Sessions that have at least one goal completed compared to total
      sessions in timeframe
    body_text: ''
    row: 6
    col: 0
    width: 24
    height: 2
  - name: Total Conversions (2)
    type: text
    title_text: Total Conversions
    subtitle_text: Total number of hits (Page or Event) that match the goals set in
      dashboard filters
    body_text: ''
    row: 21
    col: 0
    width: 24
    height: 3
  - title: Session Conversion Rate by Audience Cohort
    name: Session Conversion Rate by Audience Cohort
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.audience_trait, hits.sessions_with_conversions, hits.session_conversion_rate]
    filters: {}
    sorts: [hits.sessions_with_conversions desc]
    limit: 10
    column_limit: 50
    dynamic_fields: [{table_calculation: of_total_converting_sessions, label: "% of\
          \ Total Converting Sessions", expression: "${hits.sessions_with_conversions}/sum(${hits.sessions_with_conversions})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
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
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: hits.session_conversion_rate,
            id: hits.session_conversion_rate, name: Session Conversion Rate}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: top, series: [{axisId: of_total_converting_sessions,
            id: of_total_converting_sessions, name: "% of Total Converting Sessions"}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: hits.sessions_with_conversions, id: hits.sessions_with_conversions,
            name: Sessions with Conversion}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    size_by_field: ''
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hidden_series: [of_total_converting_sessions]
    series_types:
      hits.session_conversion_rate: scatter
    series_colors:
      hits.conversion_count: "#B31412"
      hits.session_conversion_rate: "#4285F4"
      hits.sessions_with_conversions: "#34A853"
      of_total_converting_sessions: "#34A853"
    series_labels:
      hits.conversion_count: Total Conversions
      ga_sessions.total_conversions: Sessions with Conversion
      hits.full_event: Event
    series_point_styles:
      hits.session_conversion_rate: square
    label_color: []
    show_sql_query_menu_options: false
    pinned_columns:
      hits.full_event: left
    column_order: ["$$$_row_numbers_$$$", hits.page_path_formatted, hits.conversion_count,
      hits.sessions_with_conversions, hits.session_conversion_rate]
    show_totals: false
    show_row_totals: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_column_widths:
      hits.page_path: 361
      hits.full_event: 618
      hits.sessions_with_conversions: 170
      hits.conversion_count: 140
      hits.session_conversion_rate: 175
      hits.page_path_formatted: 300
    series_cell_visualizations:
      hits.conversion_count:
        is_active: true
        palette:
          palette_id: google-diverging-0
          collection_id: google
        value_display: true
      hits.sessions_with_conversions:
        is_active: true
    table_theme: unstyled
    enable_conditional_formatting: true
    header_background_color: "#FBBC04"
    header_text_alignment: left
    header_font_size: '11'
    rows_font_size: '11'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: percentile, value: 99}}, mirror: false, reverse: false,
            stepped: false}}, bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format:
      hits.conversion_count: 0.0,"K"
      hits.sessions_with_conversions: 0.0,"K"
    hide_totals: false
    hide_row_totals: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: Total Conversions (based on filters) by Page the conversion occurred
      on. If the conversion is a page, then there will only be one row.
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Audience Selector: ga_sessions.audience_selector
      Date: ga_sessions.partition_date
    row: 10
    col: 14
    width: 10
    height: 11
  - name: "<font size=8px> Reverse Goal Path</font>"
    type: text
    title_text: "<font size=8px> Reverse Goal Path</font>"
    subtitle_text: ''
    body_text: |-
      <font size=5px>Read Data from Right to Left:</font>
      <br>
      - The column furthest to the right is where the Goal was completed.
      <br>
      - Every subsequent column to the left is the hit (Page or Event Action) that took place directly before it.<br>
      - Every path that flows into a NULL value is the "Entrance" into the website (i.e. NULL values represent that the user had not entered the website yet)
    row: 37
    col: 0
    width: 24
    height: 6
  - title: Reverse Event Action Path
    name: Reverse Event Action Path (2)
    model: google_analytics_360
    explore: ga_sessions
    type: looker_grid
    fields: [event_action_facts.current_event_minus_3, event_action_facts.current_event_minus_2,
      event_action_facts.current_event_minus_1, ga_sessions.visits_total, event_action_facts.event_action]
    filters:
      hits.event_action: "-NULL"
      event_action_facts.current_event_minus_1: "-NULL"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
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
    series_labels: {}
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: [of_total]}]
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A853", "#5F6368", "#185ABC",
      "#9AA0A6", "#B31412", "#BDC1C6", "#EA8600", "#E8EAED", "#137333"]
    label_type: name
    show_null_points: true
    hidden_fields: [ga_sessions.visits_total]
    hidden_points_if_no: []
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
    listen:
      'Goal: Event Action': event_action_facts.event_action
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 43
    col: 12
    width: 12
    height: 6
  - title: Reverse Goal Path
    name: Reverse Goal Path (2)
    model: google_analytics_360
    explore: ga_sessions
    type: looker_grid
    fields: [page_facts.current_page_minus_3, page_facts.current_page_minus_2, page_facts.current_page_minus_1,
      hits.page_path_formatted, hits.sessions_with_conversions]
    filters:
      hits.has_completed_goal: 'Yes'
    sorts: [hits.sessions_with_conversions desc]
    limit: 50
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: of_total_sessions, label: "% of Total Sessions",
        expression: "${hits.sessions_with_conversions}/${hits.sessions_with_conversions:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", page_facts.current_page_minus_3, page_facts.current_page_minus_2,
      page_facts.current_page_minus_1, hits.page_path_formatted, of_total_sessions]
    show_totals: false
    show_row_totals: true
    series_labels:
      hits.page_path_formatted: Goal Completion Page
      page_facts.current_page_minus_1: Page -1
      page_facts.current_page_minus_2: Page -2
      page_facts.current_page_minus_3: Page -3
      page_facts.current_page_minus_4: Page -4
      page_facts.current_page_minus_5: Page -5
      page_facts.current_page_minus_6: Page -6
      of_total_sessions: "% of total"
    series_column_widths:
      page_facts.current_page_minus_4: 200
    series_cell_visualizations:
      hits.sessions_with_conversions:
        is_active: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    header_font_color: ''
    header_background_color: ''
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0,
          options: {steps: 5, constraints: {max: {type: percentile, value: 99}}}},
        bold: false, italic: false, strikethrough: false, fields: [of_total_sessions]}]
    truncate_column_names: false
    hidden_fields: [hits.sessions_with_conversions]
    hidden_points_if_no: []
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A853", "#5F6368", "#185ABC",
      "#9AA0A6", "#B31412", "#BDC1C6", "#EA8600", "#E8EAED", "#137333"]
    label_type: name
    show_null_points: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Sessions with Conversion by Goal Completion Page (Location) with all
      page paths that led to that page.
    listen:
      'Goal: Event Action': hits.event_action_goal_selection
      'Goal: Event Label': hits.event_label_goal_selection
      'Goal: Event Category': hits.event_category_goal_selection
      'Goal: Page': hits.page_goal_selection
      Date: ga_sessions.partition_date
    row: 43
    col: 0
    width: 12
    height: 6
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
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
  - name: 'Goal: Event Action'
    title: 'Goal: Event Action'
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_action_goal_selection
  - name: 'Goal: Event Label'
    title: 'Goal: Event Label'
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_label_goal_selection
  - name: 'Goal: Event Category'
    title: 'Goal: Event Category'
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: hits.event_category_goal_selection
  - name: 'Goal: Page'
    title: 'Goal: Page'
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: hits.page_goal_selection
  - name: Audience Selector
    title: Audience Selector
    type: field_filter
    default_value: Channel
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.audience_selector