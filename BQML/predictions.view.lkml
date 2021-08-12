#############################################################################################################
# Purpose: To identify a customer's propensity to make a purchase in the future. This file identifies a date range
#          for the training, testing, and future input data. You are going to be able to define the date range for
#          the future input data to ensure that you are looking at the range of data you want to.
#############################################################################################################

######################## TRAINING/TESTING INPUTS #############################
include: "/**/user_facts.view"


view: training_input {
  extends: [user_facts]
 ## Uses the SQL from the user facts table and dynamically updates the date range to look 900 days back for 360 days as our training dataset
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql:
{% assign x  = "${EXTENDED}" %}
    {% assign updated_start_sql = x | replace: 'DAYS_BACK',"390"   %}
    /*updated_start_date*/
    {% assign updated_sql = updated_start_sql  | replace: 'DAYS_FROM',"360"  %}
     /*updated_end_date*/
    {{updated_sql}}
    ;;
  }

  # measure: count {}

}

view: testing_input {
  extends: [user_facts]
  ## Uses the SQL from the user facts table and dynamically updates the date range to look 900 days back for 360 days as our training dataset
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql: {% assign x  = "${EXTENDED}" %}
     {% assign updated_start_sql = x | replace: 'DAYS_BACK',"390"   %}
    /*updated_start_date*/
    {% assign updated_sql = updated_start_sql  | replace: 'DAYS_FROM',"360"  %}
     /*updated_end_date*/
    {{updated_sql}}
     ;;
  }
}
######################## MODEL #############################

view: future_purchase_model {
  derived_table: {
    datagroup_trigger: bqml_datagroup
    sql_create:
    CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
    OPTIONS(model_type='logistic_reg'
    , labels=['label']
    , L1_REG = 1
    , DATA_SPLIT_METHOD = 'RANDOM'
    , DATA_SPLIT_EVAL_FRACTION = 0.20
    --, CLASS_WEIGHTS=[('1',1), ('0',0.05)] -- Consider adding class weights or downsampling if you have imbalanced classes
    ) AS
    SELECT
    * EXCEPT(clientId)
    FROM ${training_input.SQL_TABLE_NAME};;
  }
}

######################## TRAINING INFORMATION #############################
explore:  future_purchase_model_evaluation {
  hidden: yes
}
explore: future_purchase_model_training_info {
  hidden: yes
}
explore: roc_curve {
  hidden: yes
}

# VIEWS:

view: future_purchase_model_evaluation {
  derived_table: {
    sql: SELECT * FROM ml.EVALUATE(
          MODEL ${future_purchase_model.SQL_TABLE_NAME},
          (SELECT * FROM ${testing_input.SQL_TABLE_NAME}));;
  }
  dimension: recall {type: number value_format_name:percent_2}
  dimension: accuracy {type: number value_format_name:percent_2}
  dimension: f1_score {type: number value_format_name:percent_3}
  dimension: log_loss {type: number}
  dimension: roc_auc {type: number}
}

view: roc_curve {
  derived_table: {
    sql: SELECT * FROM ml.ROC_CURVE(
        MODEL ${future_purchase_model.SQL_TABLE_NAME},
        (SELECT * FROM ${testing_input.SQL_TABLE_NAME}));;
  }
  dimension: threshold {
    type: number
  }
  dimension: recall {type: number value_format_name: percent_2}
  dimension: false_positive_rate {type: number}
  dimension: true_positives {type: number }
  dimension: false_positives {type: number}
  dimension: true_negatives {type: number}
  dimension: false_negatives {type: number }
  dimension: precision {
    type:  number
    value_format_name: percent_2
    sql:  ${true_positives} / NULLIF((${true_positives} + ${false_positives}),0);;
  }
  measure: total_false_positives {
    type: sum
    sql: ${false_positives} ;;
  }
  measure: total_true_positives {
    type: sum
    sql: ${true_positives} ;;
  }
  dimension: threshold_accuracy {
    type: number
    value_format_name: percent_2
    sql:  1.0*(${true_positives} + ${true_negatives}) / NULLIF((${true_positives} + ${true_negatives} + ${false_positives} + ${false_negatives}),0);;
  }
  dimension: threshold_f1 {
    type: number
    value_format_name: percent_3
    sql: 2.0*${recall}*${precision} / NULLIF((${recall}+${precision}),0);;
  }
}

view: future_purchase_model_training_info {
  derived_table: {
    sql: SELECT  * FROM ml.TRAINING_INFO(MODEL ${future_purchase_model.SQL_TABLE_NAME});;
  }
  dimension: training_run {type: number}
  dimension: iteration {type: number}
  dimension: loss_raw {sql: ${TABLE}.loss;; type: number hidden:yes}
  dimension: eval_loss {type: number}
  dimension: duration_ms {label:"Duration (ms)" type: number}
  dimension: learning_rate {type: number}
  measure: total_iterations {
    type: count
    allow_approximate_optimization: yes
  }
  measure: loss {
    value_format_name: decimal_2
    type: sum
    sql:  ${loss_raw} ;;
  }
  measure: total_training_time {
    type: sum
    label:"Total Training Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
  measure: average_iteration_time {
    type: average
    label:"Average Iteration Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
}
########################################## PREDICT FUTURE ############################

view: future_input {
  extends: [user_facts]
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql: {% assign x  = "${EXTENDED}" %}
    {% assign updated_start_sql = x | replace: 'DAYS_BACK',"30"   %}
    /*updated_start_date*/
    {% assign updated_sql = updated_start_sql  | replace: 'DAYS_FROM',"31"  %}
    /*updated_end_date*/
    {{updated_sql}}
    ;;
  }


  parameter: audience_selector {
    type: string
    allowed_value: {
      value: "Metro"
    }
    allowed_value: {
      value: "Traffic Source"
    }
    allowed_value: {
      value: "Browser"
    }
    allowed_value: {
      value: "Day of Week"
    }
  }

  dimension: audience_trait {
    type: string
    sql: CASE WHEN {% parameter audience_selector %} = 'Metro' THEN ${metro}
              WHEN {% parameter audience_selector %} = 'Traffic Source' THEN ${traffic_source}
              WHEN {% parameter audience_selector %} = 'Browser' THEN ${browser}
              WHEN {% parameter audience_selector %} = 'Day of Week' THEN ${ga_sessions_visit_start_day_of_week}
              ELSE NULL END;;
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.clientId ;;
    primary_key: yes
  }

  dimension: label {
    type: number
    sql: ${TABLE}.label ;;
    hidden: yes
  }

  dimension: ga_sessions_visit_start_hour_of_day {
    label: "Start Hour of the Day"
    type: number
    sql: ${TABLE}.ga_sessions_visit_start_hour_of_day ;;
    hidden: no
  }

  dimension: metro {
    type: string
    sql: ${TABLE}.metro ;;
    hidden: no
  }

  dimension: ga_sessions_visit_start_day_of_week {
    label: "Start Day of the Week"
    type: string
    sql: ${TABLE}.ga_sessions_visit_start_day_of_week ;;
    hidden: no
  }


  dimension: total_sessions {
    type: number
    sql: ${TABLE}.total_sessions ;;
    hidden: no
  }

  dimension: total_pageviews {
    type: number
    sql: ${TABLE}.pageviews ;;
    hidden: no
  }

  dimension: bounce_rate {
    type: number
    sql: ${TABLE}.bounce_rate ;;
    value_format_name: percent_2
    hidden: no
  }

  dimension: average_session_depth {
    type: number
    sql: ${TABLE}.avg_session_depth ;;
    hidden: no

  }

  dimension: traffic_source {
    type: string
    sql: CASE WHEN ${visits_traffic_source_none} = 1 THEN 'None'
              WHEN ${visits_traffic_source_organic} = 1 THEN 'Organic'
              WHEN ${visits_traffic_source_cpc} = 1 THEN 'CPC'
              WHEN ${visits_traffic_source_cpm} = 1 THEN 'CPM'
              WHEN ${visits_traffic_source_affiliate} = 1  THEN 'Affiliate'
              WHEN ${visits_traffic_source_referral} = 1 THEN 'Referral'
              ELSE NULL END;;
  }

  dimension: visits_traffic_source_none {
    type: number
    sql: ${TABLE}.visits_traffic_source_none ;;
    hidden: yes
  }

  dimension: visits_traffic_source_organic {
    type: number
    sql: ${TABLE}.visits_traffic_source_organic ;;
    hidden: yes
  }

  dimension: visits_traffic_source_cpc {
    type: number
    sql: ${TABLE}.visits_traffic_source_cpc ;;
    hidden: yes
  }

  dimension: visits_traffic_source_cpm {
    type: number
    sql: ${TABLE}.visits_traffic_source_cpm ;;
    hidden: yes
  }

  dimension: visits_traffic_source_affiliate {
    type: number
    sql: ${TABLE}.visits_traffic_source_affiliate ;;
    hidden: yes
  }

  dimension: visits_traffic_source_referral {
    type: number
    sql: ${TABLE}.visits_traffic_source_referral ;;
    hidden: yes
  }

  dimension: distinct_dmas {
    type: number
    sql: ${TABLE}.distinct_dmas ;;
    hidden: no
  }

  dimension: is_mobile {
    type: yesno
    sql: ${TABLE}.mobile = 1 ;;
    hidden: no
  }

  dimension: browser {
    type: string
    sql: CASE WHEN ${chrome} = 1 THEN 'Chrome'
              WHEN ${safari} = 1 THEN 'Safari'
              WHEN ${browser_other} = 1 THEN 'Other'
              ELSE NULL END;;
  }

  dimension: chrome {
    type: number
    sql: ${TABLE}.chrome ;;
    hidden: yes
  }

  dimension: safari {
    type: number
    sql: ${TABLE}.safari ;;
    hidden: yes
  }

  dimension: browser_other {
    type: number
    sql: ${TABLE}.browser_other ;;
    hidden: yes
  }

}

view: future_purchase_prediction {
  derived_table: {
    sql: SELECT clientId,
          pred.prob as user_propensity_score,
          NTILE(10) OVER (ORDER BY pred.prob DESC) as user_propensity_decile
        FROM ml.PREDICT(
          MODEL ${future_purchase_model.SQL_TABLE_NAME},
          (SELECT * FROM ${future_input.SQL_TABLE_NAME})),
        UNNEST(predicted_label_probs) as pred
        WHERE pred.label = 1
       ;;
  }
  dimension: user_propensity_score {
    type: number
    sql: ${TABLE}.user_propensity_score ;;
    value_format_name: percent_2
  }
  dimension: user_propensity_decile {
    type: number
    sql: ${TABLE}.user_propensity_decile ;;
    value_format_name: decimal_2
  }
  dimension: clientId {
    type: string
    hidden: yes
    sql: TRIM(REPLACE(${TABLE}.clientId,',','')) ;;
  }

  measure: average_user_propensity_score {
    type: average
    sql: ${user_propensity_score} ;;
    value_format_name: percent_2
    drill_fields: [clientId, user_propensity_score]
  }

  measure: median_user_propensity_score {
    type: median
    sql: ${user_propensity_score} ;;
    value_format_name: percent_2
    drill_fields: [clientId, user_propensity_score]
  }
  measure: average_user_propensity_decile {
    type:  average
    sql:  ${user_propensity_decile} ;;
    value_format_name: decimal_2
    drill_fields: [clientId, user_propensity_score]
  }
}
