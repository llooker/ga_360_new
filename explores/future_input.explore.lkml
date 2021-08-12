include: "/*/*.view.lkml"
include: "/Google_Analytics/*.view.lkml"
include: "/Google_Analytics/Sessions/*.view.lkml"
include: "/Google_Analytics/Custom_Views/*.view.lkml"

explore: future_input {  
  view_label: "Audience Traits"
  label: "BQML Customer Likelihood to Purchase"
  description: "This explore allows you to slice and dice likeliness to purchase scores by different customer traits to see how they differ. The default range of data you are looking at is in the past 30 days"
  join: future_purchase_prediction {
    type: left_outer
    sql_on: ${future_purchase_prediction.clientId} = ${future_input.client_id} ;;
    relationship: one_to_one
  }
}