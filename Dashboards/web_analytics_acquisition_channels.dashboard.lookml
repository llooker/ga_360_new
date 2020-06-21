- dashboard: web_analytics_acquisition_channels
  title: 'Web Analytics: Acquisition Channels'
  layout: newspaper
  elements:
  - title: Traffic by Channel
    name: Traffic by Channel
    model: marketing
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.visits_total, ga_sessions.all_confirmation_completions, ga_sessions.channel_grouping,
      ga_sessions.visit_start_week]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.visit_start_week]
    filters: {}
    sorts: [ga_sessions.all_confirmation_completions desc 0, ga_sessions.channel_grouping]
    limit: 500
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: ccba75a3-58c7-4b9c-a931-4ffc59e79cba
      options:
        steps: 5
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
    legend_position: center
    series_types: {}
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
    ordering: none
    show_null_labels: false
    hidden_fields: [ga_sessions.all_confirmation_completions]
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Source / Medium: ga_sessions.source_medium
    row: 2
    col: 0
    width: 24
    height: 10
  - title: Conversions by Channel
    name: Conversions by Channel
    model: marketing
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.channel_grouping, ga_sessions.visit_start_week, ga_sessions.goal_completions]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.visit_start_week]
    filters: {}
    sorts: [ga_sessions.channel_grouping 0, ga_sessions.visit_start_week]
    limit: 500
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: ccba75a3-58c7-4b9c-a931-4ffc59e79cba
      options:
        steps: 5
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
    legend_position: center
    series_types: {}
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
    ordering: none
    show_null_labels: false
    hidden_fields: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Source / Medium: ga_sessions.source_medium
    row: 12
    col: 0
    width: 24
    height: 10
  - title: Top Landing Pages
    name: Top Landing Pages
    model: marketing
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.landing_page_hostname, ga_sessions.landing_page_formatted,
      ga_sessions.visits_total, ga_sessions.bounce_rate, ga_sessions.page_views_session, ga_sessions.timeonsite_average_per_session,
      ga_sessions.goal_completions, ga_sessions.goal_conversion_rate]
    filters:
      ga_sessions.landing_page_formatted: "-NULL"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
    column_order: ["$$$_row_numbers_$$$", ga_sessions.landing_page_hostname, ga_sessions.landing_page_formatted,
      ga_sessions.visits_total, ga_sessions.bounce_rate, ga_sessions.page_views_session, ga_sessions.timeonsite_average_per_session,
      ga_sessions.goal_completions, ga_sessions.goal_conversion_rate]
    show_view_names: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_labels:
      ga_sessions.landing_page_hostname: Hostname
      ga_sessions.landing_page_formatted: Landing Page
    series_column_widths:
      ga_sessions.landing_page_hostname: 107
    series_cell_visualizations:
      ga_sessions.visits_total:
        is_active: true
    table_theme: white
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: circle
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ga_sessions.entrance_pageviews_total,
            name: Total Entrance Pageviews, axisId: ga_sessions.entrance_pageviews_total}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}, {label: !!null '', orientation: right, series: [{id: ga_sessions.all_confirmations_conversion_rate,
            name: 'All Confirmations: Conversion Rate', axisId: ga_sessions.all_confirmations_conversion_rate}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    note_state: collapsed
    note_display: hover
    note_text: Landing page is the first page someone visited on website
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 48
    col: 0
    width: 24
    height: 11
  - title: Engagement by Channel
    name: Engagement by Channel
    model: marketing
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.channel_grouping, ga_sessions.percent_new_sessions, ga_sessions.bounce_rate,
      ga_sessions.page_views_session, ga_sessions.timeonsite_average_per_session, ga_sessions.goal_conversion_rate]
    filters: {}
    sorts: [ga_sessions.channel_grouping]
    limit: 500
    color_application:
      collection_id: legacy
      palette_id: santa_cruz
    show_totals: true
    show_row_totals: true
    show_view_names: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_cell_visualizations:
      ga_sessions.percent_new_sessions:
        is_active: true
        palette:
          palette_id: legacy_sequential2
          collection_id: legacy
      ga_sessions.bounce_rate:
        is_active: true
        palette:
          palette_id: legacy_sequential1
          collection_id: legacy
      ga_sessions.page_views_session:
        is_active: true
        palette:
          palette_id: legacy_sequential2
          collection_id: legacy
      ga_sessions.timeonsite_average_per_session:
        is_active: true
        palette:
          palette_id: legacy_sequential2
          collection_id: legacy
      ga_sessions.goal_conversion_rate:
        is_active: true
        palette:
          palette_id: 2257875b-b3f9-911e-70f4-71c298f52cb7
          collection_id: legacy
          custom_colors:
          - "#a6d2e6"
          - "#0092E5"
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: circle
    series_colors: {}
    series_types: {}
    hidden_series: [ga_sessions.bounce_rate, ga_sessions.timeonsite_average_per_session]
    y_axes: [{label: '', orientation: left, series: [{id: ga_sessions.page_views_session,
            name: Behavior Pages / Session, axisId: ga_sessions.page_views_session}, {
            id: ga_sessions.timeonsite_average_per_session, name: Session Time On Site
              Average Per Session, axisId: ga_sessions.timeonsite_average_per_session}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{id: ga_sessions.all_confirmations_conversion_rate, name: 'Conversions
              All Confirmations: Conversion Rate', axisId: ga_sessions.all_confirmations_conversion_rate},
          {id: ga_sessions.demo_conversion_rate, name: 'Conversions Demo: Conversion
              Rate', axisId: ga_sessions.demo_conversion_rate}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{id: ga_sessions.bounce_rate,
            name: Session Bounce Rate, axisId: ga_sessions.bounce_rate}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 30
    col: 0
    width: 24
    height: 7
  - name: Snapshot
    type: text
    title_text: Snapshot
    subtitle_text: Use filters to update
    row: 22
    col: 0
    width: 24
    height: 2
  - title: Users
    name: Users
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors, ga_sessions.new_visits_total, ga_sessions.visits_total,
      ga_sessions.percent_new_sessions, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: new_users, label: "% New Users", expression: "${ga_sessions.new_visits_total}/${ga_sessions.unique_visitors}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
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
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 24
    col: 0
    width: 6
    height: 3
  - title: Avg Session Duration
    name: Avg Session Duration
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.timeonsite_average_per_session]
    filters: {}
    limit: 500
    column_limit: 50
    hidden_fields: []
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 24
    col: 6
    width: 6
    height: 3
  - title: Sessions
    name: Sessions
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors, ga_sessions.new_visits_total, ga_sessions.visits_total,
      ga_sessions.percent_new_sessions, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: new_users, label: "% New Users", expression: "${ga_sessions.newVisits_total}/${ga_sessions.unique_visitors}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
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
    series_types: {}
    hidden_fields: [ga_sessions.unique_visitors, ga_sessions.new_visits_total, ga_sessions.percent_new_sessions,
      ga_sessions.all_confirmation_completions, ga_sessions.all_confirmations_conversion_rate,
      new_users]
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 24
    col: 12
    width: 6
    height: 3
  - title: "% New Sessions"
    name: "% New Sessions"
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors, ga_sessions.new_visits_total, ga_sessions.visits_total,
      ga_sessions.percent_new_sessions, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: new_users, label: "% New Users", expression: "${ga_sessions.new_visits_total}/${ga_sessions.unique_visitors}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
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
    series_types: {}
    hidden_fields: [ga_sessions.unique_visitors, ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate, new_users, ga_sessions.visits_total]
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 24
    col: 18
    width: 6
    height: 3
  - title: Conversions
    name: Conversions
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.goal_completions]
    filters: {}
    limit: 500
    column_limit: 50
    hidden_fields: []
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 27
    col: 12
    width: 6
    height: 3
  - title: CVR
    name: CVR
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.goal_conversion_rate]
    filters: {}
    limit: 500
    column_limit: 50
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 27
    col: 18
    width: 6
    height: 3
  - title: Bounce Rate
    name: Bounce Rate
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.bounce_rate]
    filters: {}
    limit: 500
    column_limit: 50
    hidden_fields: []
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 27
    col: 6
    width: 6
    height: 3
  - title: Pages / Session
    name: Pages / Session
    model: marketing
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.page_views_session, ga_sessions.bounce_rate]
    filters: {}
    limit: 500
    column_limit: 50
    hidden_fields: [ga_sessions.bounce_rate]
    series_types: {}
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 27
    col: 0
    width: 6
    height: 3
  - title: Top CTAs
    name: Top CTAs
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [hits.event_action, hits.event_label, ga_sessions.visits_total,
      ga_sessions.page_views_total, hits.count]
    filters:
      hits.event_category: "-Null"
      hits.event_label: "-%careers%"
      hits.event_action: "-Null"
    sorts: [hits.count desc]
    limit: 10
    dynamic_fields: [{table_calculation: ctr, label: CTR, expression: "${ga_sessions.hits_total}/${ga_sessions.pageviews_total}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
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
    hidden_fields: [ga_sessions.visits_total, ga_sessions.page_views_total, hits.event_label,
      ga_sessions.total_events]
    series_types: {}
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Most clicked buttons on website
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 37
    col: 0
    width: 12
    height: 11
  - title: Top Confirmation Pages
    name: Top Confirmation Pages
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [hits.page_path_formatted, ga_sessions.goal_completions]
    filters:
      hits.page_path: "%confirmation%,%thank%"
    limit: 10
    column_limit: 500
    total: true
    dynamic_fields: [{table_calculation: goal_cvr, label: Goal CVR, expression: "${ga_sessions.goal_completions}/${ga_sessions.visits_total:total}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    stacking: normal
    color_application:
      collection_id: legacy
      palette_id: santa_cruz
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
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
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Most visited confirmation/thank-you pages after form-fill
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: hits.host_name
      Default Channel: ga_sessions.channel_grouping
      Country: ga_sessions.country
      Continent: ga_sessions.continent
      City: ga_sessions.city
      Source / Medium: ga_sessions.source_medium
    row: 37
    col: 12
    width: 12
    height: 11
  - name: Past 1 Year
    type: text
    title_text: Past 1 Year
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Top Referral Traffic
    name: Top Referral Traffic
    model: marketing
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.source, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    filters:
      ga_sessions.source: ""
      ga_sessions.channel_grouping: Referral
    sorts: [ga_sessions.visits_total desc]
    limit: 500
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
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    legend_position: center
    series_types: {}
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
    hidden_fields: [ga_sessions.all_confirmation_completions, ga_sessions.all_confirmations_conversion_rate]
    y_axes: []
    listen:
      Partition Date: ga_sessions.partition_date
      Landing Hostname: ga_sessions.landing_page_hostname
      Source / Medium: ga_sessions.source_medium
    row: 59
    col: 0
    width: 24
    height: 9
  filters:
  - name: Partition Date
    title: Partition Date
    type: field_filter
    default_value: 1 years
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
  - name: Landing Hostname
    title: Landing Hostname
    type: field_filter
    #default_value: looker.com
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.landing_page_hostname
  - name: Default Channel
    title: Default Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.channel_grouping
  - name: Country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.country
  - name: Continent
    title: Continent
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.continent
  - name: City
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.city
  - name: Source / Medium
    title: Source / Medium
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: marketing
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.source_medium
