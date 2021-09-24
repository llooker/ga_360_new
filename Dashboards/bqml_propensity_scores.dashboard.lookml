- dashboard: bqml_propensity_scores
  title: BQML Propensity Scores
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Propensity Scores by Audience Traits
    name: Propensity Scores by Audience Traits
    model: google_analytics_360_v2
    explore: future_input
    type: looker_grid
    fields: [future_input.audience_trait, future_purchase_prediction.average_user_propensity_score,
      future_purchase_prediction.median_user_propensity_score]
    filters:
      future_input.audience_trait: "-NULL"
    sorts: [future_purchase_prediction.average_user_propensity_score desc]
    limit: 500
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
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      future_purchase_prediction.median_user_propensity_score:
        is_active: true
      future_purchase_prediction.average_user_propensity_score:
        is_active: true
    header_font_color: "#ffffff"
    header_background_color: "#4285F4"
    series_types: {}
    defaults_version: 1
    series_column_widths:
      future_purchase_prediction.average_user_propensity_score: 291
    listen:
      Audience Selector: future_input.audience_selector
    row: 4
    col: 0
    width: 24
    height: 9
  - name: <font color="#34A853" size="45" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> BQML Propensity Scores </strong> <font color=
      "#4285F4"size="45"> Cohort Analysis </font>
    type: text
    title_text: <font color="#34A853" size="4.5" weight="bold"><i class="fa fa-tachometer"
      aria-hidden="true"></i><strong> BQML Propensity Scores </strong> <font color=
      "#4285F4"size="4.5"> Cohort Analysis </font>
    subtitle_text: How likely are customers to make a future purchase?
    body_text: |-
      <center> <b>Recommended Action</b>👇 Update the filters above to slice and dice the propensity scores by audience traits. Drill in to see the client IDs that fall under that cohort. <center>

      <center> <b>Note: </b>The propensity score shows you how likely a customer is to make a future purchase. These numbers are based off of purchases from the past 30 days <center>
    row: 0
    col: 0
    width: 24
    height: 4
  filters:
  - name: Audience Selector
    title: Audience Selector
    type: field_filter
    default_value: Browser
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: google_analytics_360_v2
    explore: future_input
    listens_to_filters: []
    field: future_input.audience_selector