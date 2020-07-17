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

constant: CONFIG_PROJECT_NAME {
  value: "block-ga360-config"
  export: override_required
}


constant: QUERY_FILTER {
  value: " WHERE (
 (ga_sessions.visitStartTime < IFNULL(event_session, 0)
  or event_session is null) )"
}
