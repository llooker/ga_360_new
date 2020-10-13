- dashboard: acquisition
  title: Acquisition
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Sessions
    name: Sessions
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [audience_cohorts.rank, ga_sessions.audience_trait, ga_sessions.visits_total]
    filters: {}
    sorts: [audience_cohorts.rank]
    limit: 500
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Session Sessions}], showLabels: false,
        showValues: false, valueFormat: '0,"K"', unpinAxis: false, tickDensity: default,
        type: linear}, {label: '', orientation: bottom, series: [{axisId: ga_sessions.percent_new_sessions,
            id: ga_sessions.percent_new_sessions, name: Audience % New Sessions}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
    size_by_field: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [of_total]
    series_types:
      attribution_model_pdt.first_touch_sessions_pct: scatter
      ga_sessions.percent_new_sessions: scatter
    series_colors:
      ga_sessions.visits_total: "#FBBC04"
      of_total: "#34A853"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate, audience_cohorts.rank]
    defaults_version: 1
    note_state: collapsed
    note_display: above
    note_text: Traffic (i.e. Sessions) based on Audience Trait (based on Audience
      Cohort filter).
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 7
    col: 0
    width: 8
    height: 11
  - title: Users
    name: Users
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [audience_cohorts.rank, ga_sessions.audience_trait, ga_sessions.unique_visitors]
    filters: {}
    sorts: [audience_cohorts.rank]
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.unique_visitors}/sum(${ga_sessions.unique_visitors})",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: ga_sessions.unique_visitors,
            id: ga_sessions.unique_visitors, name: Users}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: bottom,
        series: [{axisId: new_users, id: new_users, name: "% New Users"}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear}]
    size_by_field: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [of_total]
    series_types:
      attribution_model_pdt.first_touch_sessions_pct: scatter
      ga_sessions.percent_new_sessions: scatter
      new_users: scatter
    series_colors:
      ga_sessions.unique_visitors: "#185ABC"
      of_total: "#34A853"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate, audience_cohorts.rank]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Unique users sorted by Top Audience Trait based on Web Traffic (i.e.
      Audience Traits by Total Sessions)
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 7
    col: 8
    width: 8
    height: 11
  - title: Pageviews
    name: Pageviews
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [audience_cohorts.rank, ga_sessions.audience_trait, hits.page_count]
    filters: {}
    sorts: [audience_cohorts.rank]
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${hits.page_count}/sum(${hits.page_count})",
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: hits.page_count, id: hits.page_count,
            name: Pageviews}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: time_on_page.average_time_on_page, id: time_on_page.average_time_on_page,
            name: Avg Time on Page}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    size_by_field: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [of_total]
    series_types:
      attribution_model_pdt.first_touch_sessions_pct: scatter
      ga_sessions.percent_new_sessions: scatter
      new_users: scatter
    series_colors:
      ga_sessions.unique_visitors: "#185ABC"
      hits.page_count: "#B31412"
      time_on_page.average_time_on_page: "#4285F4"
      of_total: "#34A853"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate, audience_cohorts.rank]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Page Views by Top Audience Trait based on Web Traffic (i.e. Audience
      Traits by Total Sessions)
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 7
    col: 16
    width: 8
    height: 11
  - title: Session Breakdown
    name: Session Breakdown
    model: google_analytics_360
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.audience_trait, audience_cohorts.rank]
    pivots: [audience_cohorts.rank, ga_sessions.audience_trait]
    filters: {}
    sorts: [ga_sessions.visits_total desc 0, audience_cohorts.rank, ga_sessions.audience_trait]
    column_limit: 5
    row_total: right
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${ga_sessions.visits_total}/${ga_sessions.visits_total:row_total}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: other, label: Other,
        expression: "${ga_sessions.visits_total:row_total}-sum(pivot_row(${ga_sessions.visits_total}))",
        value_format: !!null '', value_format_name: decimal_0, is_disabled: false,
        _kind_hint: supermeasure, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
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
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: 1 - (direct) /
              (none) - ga_sessions.visits_total, id: 1 - (direct) / (none) - ga_sessions.visits_total,
            name: 1 - (direct) / (none) - Session Sessions}, {axisId: 2 - google /
              organic - ga_sessions.visits_total, id: 2 - google / organic - ga_sessions.visits_total,
            name: 2 - google / organic - Session Sessions}, {axisId: 3 - youtube.com
              / referral - ga_sessions.visits_total, id: 3 - youtube.com / referral
              - ga_sessions.visits_total, name: 3 - youtube.com / referral - Session
              Sessions}, {axisId: 4 - Partners / affiliate - ga_sessions.visits_total,
            id: 4 - Partners / affiliate - ga_sessions.visits_total, name: 4 - Partners
              / affiliate - Session Sessions}, {axisId: 5 - analytics.google.com /
              referral - ga_sessions.visits_total, id: 5 - analytics.google.com /
              referral - ga_sessions.visits_total, name: 5 - analytics.google.com
              / referral - Session Sessions}, {axisId: other, id: other, name: Other}],
        showLabels: false, showValues: false, valueFormat: '', unpinAxis: false, tickDensity: default,
        type: linear}]
    size_by_field: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    font_size: '12'
    series_types: {}
    series_colors:
      ga_sessions.visits_total: "#FBBC04"
    value_labels: legend
    label_type: labPer
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Traffic (i.e. Sessions) breakdown by Audience Trait (based on Audience
      Cohort filter).
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 18
    col: 0
    width: 24
    height: 6
  - title: Engagement
    name: Engagement
    model: google_analytics_360
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.audience_trait, ga_sessions.visits_total, ga_sessions.percent_new_sessions,
      ga_sessions.bounce_rate, ga_sessions.page_views_session, ga_sessions.timeonsite_average_per_session]
    filters: {}
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '20'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google
      palette_id: google-categorical-0
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", ga_sessions.audience_trait, of_total_sessions,
      ga_sessions.percent_new_sessions, ga_sessions.bounce_rate, ga_sessions.page_views_session,
      ga_sessions.timeonsite_average_per_session]
    show_totals: true
    show_row_totals: true
    series_column_widths:
      ga_sessions.audience_trait: 252
    series_cell_visualizations:
      ga_sessions.percent_new_sessions:
        is_active: true
        palette:
          palette_id: google-sequential-0
          collection_id: google
      ga_sessions.bounce_rate:
        is_active: true
        palette:
          palette_id: d84b1efb-41fe-4407-4ecf-adeaf273eb98
          collection_id: google
          custom_colors:
          - "#ffffff"
          - "#EA4335"
          - "#B31412"
      ga_sessions.page_views_session:
        is_active: true
        palette:
          palette_id: google-sequential-0
          collection_id: google
      ga_sessions.timeonsite_average_per_session:
        is_active: true
        palette:
          palette_id: google-sequential-0
          collection_id: google
      ga_sessions.goal_conversion_rate:
        is_active: true
        palette:
          palette_id: 2257875b-b3f9-911e-70f4-71c298f52cb7
          collection_id: legacy
          custom_colors:
          - "#a6d2e6"
          - "#0092E5"
      of_total_sessions:
        is_active: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    header_background_color: "#FBBC04"
    series_value_format:
      ga_sessions.percent_new_sessions:
        name: percent_0
        format_string: "#,##0%"
        label: Percent (0)
      ga_sessions.bounce_rate:
        name: percent_0
        format_string: "#,##0%"
        label: Percent (0)
    truncate_column_names: false
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
            name: Behavior Pages / Session, axisId: ga_sessions.page_views_session},
          {id: ga_sessions.timeonsite_average_per_session, name: Session Time On Site
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
    hidden_fields: [ga_sessions.visits_total]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Engagement metrics by Audience Trait (based on Audience Cohort filter).
      Sorted by trait with highest traffic (i.e. Sessions).
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 34
    col: 0
    width: 24
    height: 11
  - title: Sessions by Week
    name: Sessions by Week
    model: google_analytics_360
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.visits_total, ga_sessions.partition_week, ga_sessions.audience_trait,
      audience_cohorts.rank]
    pivots: [audience_cohorts.rank, ga_sessions.audience_trait]
    filters: {}
    sorts: [ga_sessions.partition_week, audience_cohorts.rank, ga_sessions.audience_trait]
    limit: 500
    column_limit: 5
    row_total: right
    dynamic_fields: [{table_calculation: other, label: Other, expression: "${ga_sessions.visits_total:row_total}-sum(pivot_row(${ga_sessions.visits_total}))",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: supermeasure,
        _type_hint: number}]
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
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    y_axes: []
    series_types: {}
    show_null_points: true
    interpolation: linear
    hidden_fields: [ga_sessions.all_confirmation_completions]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Traffic by Week & Audience Trait (based on Audience Cohort filter).
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 24
    col: 0
    width: 24
    height: 10
  - title: Sessions
    name: Sessions (2)
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.visits_total]
    filters: {}
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#FBBC04",
        font_color: "#fff", color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Session Sessions}], showLabels: false,
        showValues: false, valueFormat: '0,"K"', unpinAxis: false, tickDensity: default,
        type: linear}, {label: '', orientation: bottom, series: [{axisId: ga_sessions.percent_new_sessions,
            id: ga_sessions.percent_new_sessions, name: Audience % New Sessions}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    size_by_field: ''
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [of_total]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      ga_sessions.visits_total: "#FBBC04"
      of_total: "#34A853"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Sessions based on all filters. Audience Cohort filter will not affect
      value.
    listen:
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 5
    col: 0
    width: 8
    height: 2
  - title: Users
    name: Users (2)
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.unique_visitors]
    filters: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#185ABC",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: ga_sessions.unique_visitors,
            id: ga_sessions.unique_visitors, name: Users}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: bottom,
        series: [{axisId: new_users, id: new_users, name: "% New Users"}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    size_by_field: ''
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [of_total]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      ga_sessions.unique_visitors: "#185ABC"
      of_total: "#34A853"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Unique users based on filters. Audience Cohort filter will not affect
      value.
    listen:
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 5
    col: 8
    width: 8
    height: 2
  - title: Pageviews
    name: Pageviews (2)
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [hits.page_count]
    filters: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#B31412",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: hits.page_count, id: hits.page_count,
            name: Pageviews}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: time_on_page.average_time_on_page, id: time_on_page.average_time_on_page,
            name: Avg Time on Page}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    size_by_field: ''
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [of_total]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      ga_sessions.unique_visitors: "#185ABC"
      hits.page_count: "#B31412"
      time_on_page.average_time_on_page: "#4285F4"
      of_total: "#34A853"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [ga_sessions.newVisits_total, ga_sessions.all_confirmation_completions,
      ga_sessions.all_confirmations_conversion_rate]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Page Views based on filters. Audience Cohort filter will not affect
      value.
    listen:
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 5
    col: 16
    width: 8
    height: 2
  - title: Navigation Bar
    name: Navigation Bar
    model: google_analytics_360
    explore: ga_sessions
    type: single_value
    fields: [ga_sessions.dash_nav]
    filters: {}
    limit: 500
    column_limit: 50
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
  - name: "<font size=16px>Acquisition Overview</font>"
    type: text
    title_text: "<font size=16px>Acquisition Overview</font>"
    subtitle_text: Use <b>Audience Cohort</b> filter to change what field the data
      is grouped by for the Overview metrics
    body_text: ''
    row: 2
    col: 0
    width: 24
    height: 3
  - name: "<font size=16px>Acquisition Detail</font>"
    type: text
    title_text: "<font size=16px>Acquisition Detail</font>"
    subtitle_text: "<center><b>Audience Cohort</b> filter <b>does not</b> affect any\
      \ tiles below this point</center>"
    body_text: "<br>"
    row: 45
    col: 0
    width: 24
    height: 3
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
    note_text: Top traffic by Source for all "Referral" traffic. Channel, Medium and
      Source / Medium filters do not affect this tile.
    defaults_version: 1
    listen:
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Date: ga_sessions.partition_date
    row: 48
    col: 0
    width: 12
    height: 11
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
    note_text: Traffic by Landing page (i.e. Sessions)
    defaults_version: 1
    listen:
      Landing Hostname [Optional]: ga_sessions.landing_page_hostname
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Channel [Optional]: ga_sessions.channel_grouping
      Source [Optional]: ga_sessions.source
      Medium [Optional]: ga_sessions.medium
      Source / Medium [Optional]: ga_sessions.source_medium
      Date: ga_sessions.partition_date
    row: 48
    col: 12
    width: 12
    height: 11
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
  - name: Audience Cohort [Required]
    title: Audience Cohort [Required]
    type: field_filter
    default_value: Channel
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options:
      - Channel
      - Medium
      - Source
      - Source Medium
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.audience_selector
  - name: Landing Hostname [Optional]
    title: Landing Hostname [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.landing_page_hostname
  - name: Country [Optional]
    title: Country [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.country
  - name: Continent [Optional]
    title: Continent [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.continent
  - name: Channel [Optional]
    title: Channel [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: inline
      options: []
    model: google_analytics_360
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.channel_grouping
  - name: Source [Optional]
    title: Source [Optional]
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
    field: ga_sessions.source
  - name: Medium [Optional]
    title: Medium [Optional]
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
    field: ga_sessions.medium
  - name: Source / Medium [Optional]
    title: Source / Medium [Optional]
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
    field: ga_sessions.source_medium
