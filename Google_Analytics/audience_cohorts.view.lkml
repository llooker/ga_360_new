# Purpose: Dynamically rank audience traits based on query filters so field can be used and sorted in pivots.
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/audience_cohorts.view.lkml"

view: audience_cohorts {
  extends: [audience_cohorts_config]
}

view: audience_cohorts_core {
  derived_table: {
    explore_source: ga_sessions {
      column: audience_trait {}
      column: visits_total {}

      derived_column: rank {
        sql: ROW_NUMBER() OVER() ;;
      }

      bind_all_filters: yes
      sorts: [ga_sessions.visits_total: desc]
    }
  }

  dimension: audience_trait {
    # Field used to JOIN back to ga_sessions via ga_sessions.audience_traits = audience_cohorts.audience_traits
    hidden: yes
  }

  dimension: rank {
    label: "Audience Trait: Rank by Traffic"
    view_label: "Audience"
    group_label: "Audience Cohorts"
    description: "Dynamic rank for Audience Trait based on web traffic (Sessions). Includes all filters in current query and reranks on each new query."
    type: number
  }
}
