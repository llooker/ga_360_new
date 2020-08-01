project_name: "ga_360_new"


################ Constants ################

# Used in google_analytics_block.model connection param
constant: CONNECTION_NAME {
  value: "ga_generated"
  export: override_required
}



# Used in ga_sessions.view sql_table_name
constant: SCHEMA_NAME {
  value: "bigquery-public-data.google_analytics_sample"
  export: override_required
}

constant: GA360_TABLE_NAME {
  value: "ga_sessions_*"
  export: override_required
}

constant: MODEL_NAME {
  value: "marketing"
  export: override_required
}

constant: CONFIG_PROJECT_NAME {
  value: "ga_360_config"
  export: override_required
}

constant: PARTITION_DATE_PDT_FILTER {
  value: "last 1500 days"
  export: override_required
}

constant: PARTITION_DATE_DEFAULT_EXPLORE_FILTER {
  value: "last 1500 days"
  export: override_required
}
