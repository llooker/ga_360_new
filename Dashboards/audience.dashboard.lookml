- dashboard: audience
  title: Audience
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Sessions
    name: Sessions
    model: google_analytics_360_v2
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
      of_total: "#4285F4"
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
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 7
    col: 0
    width: 8
    height: 11
  - title: Users
    name: Users
    model: google_analytics_360_v2
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
      of_total: "#4285F4"
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
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 7
    col: 8
    width: 8
    height: 11
  - title: Pageviews
    name: Pageviews
    model: google_analytics_360_v2
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
      of_total: "#4285F4"
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
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 7
    col: 16
    width: 8
    height: 11
  - title: Session Breakdown
    name: Session Breakdown
    model: google_analytics_360_v2
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
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 18
    col: 0
    width: 24
    height: 5
  - title: Sessions by Week
    name: Sessions by Week
    model: google_analytics_360_v2
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
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 23
    col: 0
    width: 24
    height: 10
  - title: Sessions
    name: Sessions (2)
    model: google_analytics_360_v2
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
    note_text: Sessions based on filters
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 5
    col: 0
    width: 8
    height: 2
  - title: Users
    name: Users (2)
    model: google_analytics_360_v2
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
    note_text: Unique users based on filters
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 5
    col: 8
    width: 8
    height: 2
  - title: Pageviews
    name: Pageviews (2)
    model: google_analytics_360_v2
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
    note_text: Page Views based on filters
    listen:
      Audience Cohort [Required]: ga_sessions.audience_selector
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 5
    col: 16
    width: 8
    height: 2
  - title: When are People Visiting?
    name: When are People Visiting?
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.visit_start_hour_of_day, ga_sessions.visit_start_day_of_week,
      ga_sessions.visits_total]
    pivots: [ga_sessions.visit_start_day_of_week]
    fill_fields: [ga_sessions.visit_start_hour_of_day]
    filters:
      ga_sessions.landing_page_hostname: ''
    sorts: [ga_sessions.visit_start_day_of_week, ga_sessions.visit_start_hour_of_day
        0]
    limit: 500
    column_limit: 50
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
    series_text_format:
      ga_sessions.visit_start_day_of_week:
        align: center
      of_total_sessions:
        align: center
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
    series_column_widths:
      ga_sessions.visit_start_hour_of_day: 133
    listen:
      Date: ga_sessions.partition_date
    row: 62
    col: 0
    width: 24
    height: 14
  - title: United States Traffic
    name: United States Traffic
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_map
    fields: [ga_sessions.visits_total, ga_sessions.region]
    filters:
      ga_sessions.country: United States
      ga_sessions.landing_page_hostname: ''
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
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
    map_value_colors: ["#f9f9f9", "#4285F4", "#185ABC"]
    map: usa
    map_projection: ''
    quantize_colors: false
    outer_border_color: ''
    inner_border_color: ''
    colors: ["#f9f9f9", "#4285F4", "#185ABC"]
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
    hidden_fields:
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Traffic by Region (i.e. State) for United States
    listen:
      Date: ga_sessions.partition_date
    row: 85
    col: 12
    width: 12
    height: 9
  - title: Non-US Traffic
    name: Non-US Traffic
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_map
    fields: [ga_sessions.country, ga_sessions.visits_total]
    filters:
      ga_sessions.landing_page_hostname: ''
      ga_sessions.country: "-United States"
    sorts: [ga_sessions.visits_total desc]
    limit: 500
    column_limit: 50
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
    map_latitude: 46.437856895024204
    map_longitude: -52.3828125
    map_zoom: 2
    map_value_colors: ["#f9f9f9", "#4285F4", "#185ABC"]
    map: world
    map_projection: ''
    quantize_colors: false
    show_antarctica: false
    outer_border_color: ''
    inner_border_color: ''
    colors: ["#f9f9f9", "#4285F4", "#185ABC"]
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
    hidden_fields:
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Traffic by country (excludes United States)
    listen:
      Date: ga_sessions.partition_date
    row: 85
    col: 0
    width: 12
    height: 9
  - title: How many people return?
    name: How many people return?
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_funnel
    fields: [ga_sessions.unique_visitors, ga_sessions.visit_number_tier]
    fill_fields: [ga_sessions.visit_number_tier]
    filters:
      ga_sessions.landing_page_hostname: ''
      ga_sessions.audience_selector: Device
    sorts: [ga_sessions.visit_number_tier]
    limit: 5
    column_limit: 50
    row_total: right
    dynamic_fields: [{table_calculation: of_total_users, label: "% of Total Users",
        expression: "${ga_sessions.unique_visitors}/${ga_sessions.unique_visitors:total}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    query_timezone: America/Los_Angeles
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: true
    orientation: columns
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    color_application:
      collection_id: google
      palette_id: google-diverging-0
      options:
        steps: 5
        reverse: true
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
      num_rows: '10'
    legend_position: center
    label_value_format: ''
    trellis_rows: 3
    series_types: {}
    point_style: none
    series_labels:
      ga_sessions.visit_start_hour_of_day: Hour of Day
      of_total_sessions: Sessions
      ga_sessions.visit_start_day_of_week: Day of Week
      weekly_of_total_sessions: Week Total
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    column_spacing_ratio: 0.3
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
    hidden_fields: []
    listen:
      Date: ga_sessions.partition_date
    row: 38
    col: 0
    width: 12
    height: 12
  - title: Navigation Bar
    name: Navigation Bar
    model: google_analytics_360_v2
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
      Country [Optional]: ga_sessions.country
      Continent [Optional]: ga_sessions.continent
      Source [Optional]: ga_sessions.source
      Source / Medium [Optional]: ga_sessions.source_medium
      Medium [Optional]: ga_sessions.medium
      Channel [Optional]: ga_sessions.channel_grouping
      Date: ga_sessions.partition_date
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Frequency & Recency
    type: text
    title_text: Frequency & Recency
    subtitle_text: ''
    body_text: ''
    row: 36
    col: 0
    width: 24
    height: 2
  - title: Session Duration Tiers (Seconds)
    name: Session Duration Tiers (Seconds)
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.visits_total, ga_sessions.time_on_site_tier]
    filters:
      ga_sessions.time_on_site_tier: "-Undefined"
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
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 8, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: of_total_sessions,
            id: of_total_sessions, name: "% of Total Sessions"}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: custom, tickDensityCustom: 8,
        type: linear}]
    x_axis_label: ''
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.visits_total]
    series_types: {}
    series_colors:
      tablet - ga_sessions.visits_total: "#592EC2"
      ga_sessions.visits_total: "#FBBC04"
      of_total_sessions: "#4285F4"
    series_labels:
      desktop - ga_sessions.visits_total: Desktop
      mobile - ga_sessions.visits_total: Mobile
      tablet - ga_sessions.visits_total: Tablet
    show_null_points: true
    interpolation: monotone
    hidden_fields:
    note_state: expanded
    note_display: hover
    note_text: "Percentage of new vs. returning users for each web property. \nA user\
      \ can be considered both new & returning in the same report, depending on date\
      \ range."
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    listen:
      Date: ga_sessions.partition_date
    row: 53
    col: 0
    width: 12
    height: 9
  - title: Days since Previous Session
    name: Days since Previous Session
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.visits_total, session_flow.days_since_previous_session_tier]
    fill_fields: [session_flow.days_since_previous_session_tier]
    filters:
      ga_sessions.visit_number: ">1"
    sorts: [session_flow.days_since_previous_session_tier]
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
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 8, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: of_total_sessions,
            id: of_total_sessions, name: "% of Total Sessions"}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: custom, tickDensityCustom: 8,
        type: linear}]
    x_axis_label: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.visits_total]
    series_types: {}
    series_colors:
      tablet - ga_sessions.visits_total: "#592EC2"
      of_total_sessions: "#4285F4"
      ga_sessions.visits_total: "#FBBC04"
    series_labels:
      desktop - ga_sessions.visits_total: Desktop
      mobile - ga_sessions.visits_total: Mobile
      tablet - ga_sessions.visits_total: Tablet
    show_null_points: false
    interpolation: monotone
    hidden_fields:
    note_state: expanded
    note_display: hover
    note_text: "Percentage of new vs. returning users for each web property. \nA user\
      \ can be considered both new & returning in the same report, depending on date\
      \ range."
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    listen:
      Date: ga_sessions.partition_date
    row: 38
    col: 12
    width: 12
    height: 12
  - title: Pages Visited in Session
    name: Pages Visited in Session
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_column
    fields: [ga_sessions.visits_total, session_flow.pages_visited]
    filters:
      session_flow.pages_visited: NOT NULL
    sorts: [session_flow.pages_visited]
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
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: ga_sessions.visits_total,
            id: ga_sessions.visits_total, name: Sessions}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 8, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: of_total_sessions,
            id: of_total_sessions, name: "% of Total Sessions"}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: custom, tickDensityCustom: 8,
        type: linear}]
    x_axis_label: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: [ga_sessions.percent_new_sessions, ga_sessions.visits_total]
    series_types: {}
    series_colors:
      tablet - ga_sessions.visits_total: "#592EC2"
      of_total_sessions: "#4285F4"
      ga_sessions.visits_total: "#FBBC04"
    series_labels:
      desktop - ga_sessions.visits_total: Desktop
      mobile - ga_sessions.visits_total: Mobile
      tablet - ga_sessions.visits_total: Tablet
    show_null_points: false
    interpolation: monotone
    hidden_fields:
    note_state: expanded
    note_display: hover
    note_text: "Percentage of new vs. returning users for each web property. \nA user\
      \ can be considered both new & returning in the same report, depending on date\
      \ range."
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    listen:
      Date: ga_sessions.partition_date
    row: 53
    col: 12
    width: 12
    height: 9
  - name: Engagement
    type: text
    title_text: Engagement
    subtitle_text: ''
    body_text: ''
    row: 50
    col: 0
    width: 24
    height: 3
  - title: Language
    name: Language
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.audience_trait, audience_cohorts.rank]
    pivots: [audience_cohorts.rank, ga_sessions.audience_trait]
    filters:
      ga_sessions.landing_page_hostname: ''
      ga_sessions.audience_selector: Language
    sorts: [ga_sessions.visits_total desc 0, audience_cohorts.rank, ga_sessions.audience_trait]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
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
    colors: ["#f9f9f9", "#4285F4", "#185ABC"]
    series_types: {}
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
    map_value_colors: ["#f9f9f9", "#4285F4", "#185ABC"]
    map: usa
    map_projection: ''
    quantize_colors: false
    outer_border_color: ''
    inner_border_color: ''
    show_null_points: true
    interpolation: linear
    hidden_fields: [ga_sessions.visits_total]
    defaults_version: 1
    listen:
      Date: ga_sessions.partition_date
    row: 79
    col: 12
    width: 12
    height: 6
  - name: Geo
    type: text
    title_text: Geo
    subtitle_text: ''
    body_text: ''
    row: 76
    col: 0
    width: 24
    height: 3
  - name: "<font size=16px>Audience Overview</font>"
    type: text
    title_text: "<font size=16px>Audience Overview</font>"
    subtitle_text: Use <b>Audience Cohort</b> filter to change what field the data
      is grouped by for the Overview metrics
    body_text: ''
    row: 2
    col: 0
    width: 24
    height: 3
  - name: "<font size=16px>Audience Behavior</font>"
    type: text
    title_text: "<font size=16px>Audience Behavior</font>"
    subtitle_text: "<center><b>Audience Cohort</b> filter <b>does not</b> affect any\
      \ tiles below this point</center>"
    body_text: "<br>"
    row: 33
    col: 0
    width: 24
    height: 3
  - title: Sub Continent
    name: Sub Continent
    model: google_analytics_360_v2
    explore: ga_sessions
    type: looker_bar
    fields: [ga_sessions.visits_total, ga_sessions.continent]
    pivots: [ga_sessions.continent]
    filters:
      ga_sessions.landing_page_hostname: ''
      ga_sessions.continent: "-(not set)"
    sorts: [ga_sessions.visits_total desc 0, ga_sessions.continent]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${ga_sessions.visits_total}/sum(${ga_sessions.visits_total})",
        value_format: !!null '', value_format_name: percent_0, is_disabled: true,
        _kind_hint: measure, _type_hint: number}]
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
    colors: ["#f9f9f9", "#4285F4", "#185ABC"]
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
    map_value_colors: ["#f9f9f9", "#4285F4", "#185ABC"]
    map: usa
    map_projection: ''
    quantize_colors: false
    outer_border_color: ''
    inner_border_color: ''
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    defaults_version: 1
    listen:
      Date: ga_sessions.partition_date
    row: 79
    col: 0
    width: 12
    height: 6
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
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.partition_date
  - name: Audience Cohort [Required]
    title: Audience Cohort [Required]
    type: field_filter
    default_value: Device
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options:
      - Device
      - Metro
      - Operating System
      - Country
      - Continent
      - Browser
      - Language
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.audience_selector
  - name: Country [Optional]
    title: Country [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.country
  - name: Continent [Optional]
    title: Continent [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.continent
  - name: Source [Optional]
    title: Source [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.source
  - name: Source / Medium [Optional]
    title: Source / Medium [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.source_medium
  - name: Medium [Optional]
    title: Medium [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.medium
  - name: Channel [Optional]
    title: Channel [Optional]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: google_analytics_360_v2
    explore: ga_sessions
    listens_to_filters: []
    field: ga_sessions.channel_grouping