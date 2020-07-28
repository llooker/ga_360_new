######################## TRAINING/TESTING INPUTS #############################
include: "/**/user_facts.view"
view: training_input {
  extends: [user_facts]
  derived_table: {
    sql:
{% assign x  = "${EXTENDED}" %}
    {% assign updated_start_sql = x | replace: 'DAYS_BACK',"900"   %}
    /*updated_start_date*/
    {% assign updated_sql = updated_start_sql  | replace: 'DAYS_FROM',"360"  %}
     /*updated_end_date*/
    {{updated_sql}}
    ;;
  }
}

view: testing_input {
  extends: [user_facts]
  derived_table: {
    sql: {% assign x  = "${EXTENDED}" %}
     {% assign updated_start_sql = x | replace: 'DAYS_BACK',"900"   %}
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
    link: {
      label: "Likely Customers to Purchase"
      url: "/explore/bqml_ga_demo/ga_sessions?fields=ga_sessions.clientId,future_purchase_prediction.max_predicted_score&f[future_purchase_prediction.predicted_will_purchase_in_future]=%3E%3D{{value}}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
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
    sql: {% assign x  = "${EXTENDED}" %}
    {% assign updated_start_sql = x | replace: 'DAYS_BACK',"30"   %}
    /*updated_start_date*/
    {% assign updated_sql = updated_start_sql  | replace: 'DAYS_FROM',"31"  %}
     /*updated_end_date*/
    {{updated_sql}}
    ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.clientId ;;
  }

  dimension: label {
    type: number
    sql: ${TABLE}.label ;;
  }

  dimension: ga_sessions_visit_start_hour_of_day {
    type: number
    sql: ${TABLE}.ga_sessions_visit_start_hour_of_day ;;
  }

  dimension: metro {
    type: string
    sql: ${TABLE}.metro ;;
  }

  dimension: ga_sessions_visit_start_day_of_week {
    type: string
    sql: ${TABLE}.ga_sessions_visit_start_day_of_week ;;
  }

  dimension: ga_sessions_source {
    type: string
    sql: ${TABLE}.ga_sessions_source ;;
  }

  dimension: total_sessions {
    type: number
    sql: ${TABLE}.total_sessions ;;
  }

  dimension: pageviews {
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  dimension: bounce_rate {
    type: number
    sql: ${TABLE}.bounce_rate ;;
  }

  dimension: avg_session_depth {
    type: number
    sql: ${TABLE}.avg_session_depth ;;
  }

  dimension: visits_traffic_source_none {
    type: number
    sql: ${TABLE}.visits_traffic_source_none ;;
  }

  dimension: visits_traffic_source_organic {
    type: number
    sql: ${TABLE}.visits_traffic_source_organic ;;
  }

  dimension: visits_traffic_source_cpc {
    type: number
    sql: ${TABLE}.visits_traffic_source_cpc ;;
  }

  dimension: visits_traffic_source_cpm {
    type: number
    sql: ${TABLE}.visits_traffic_source_cpm ;;
  }

  dimension: visits_traffic_source_affiliate {
    type: number
    sql: ${TABLE}.visits_traffic_source_affiliate ;;
  }

  dimension: visits_traffic_source_referral {
    type: number
    sql: ${TABLE}.visits_traffic_source_referral ;;
  }

  dimension: distinct_dmas {
    type: number
    sql: ${TABLE}.distinct_dmas ;;
  }

  dimension: mobile {
    type: number
    sql: ${TABLE}.mobile ;;
  }

  dimension: chrome {
    type: number
    sql: ${TABLE}.chrome ;;
  }

  dimension: safari {
    type: number
    sql: ${TABLE}.safari ;;
  }

  dimension: browser_other {
    type: number
    sql: ${TABLE}.browser_other ;;
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
  dimension: user_propensity_score {type: number}
  dimension: user_propensity_decile {type: number}
  dimension: clientId {
       type: string
      hidden: no
      sql: TRIM(REPLACE(${TABLE}.clientId,',','')) ;;
      }
  measure: average_user_propensity_score {
    type: average
    sql: ${user_propensity_score} ;;
  }
  measure: average_user_propensity_decile {
    type:  average
    sql:  ${user_propensity_decile} ;;
  }
}
