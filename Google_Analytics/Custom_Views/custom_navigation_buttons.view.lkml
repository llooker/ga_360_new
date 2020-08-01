view: custom_navigation_buttons {
  extension: required

  measure: dash_nav {
    view_label: "Session"
    group_label: "Dashboard Navigation"
    label: "Navigation Bar"
    type: string
    sql: "";;
    html:
    <div style="background-color: #F6F6F7; height:500px;width:100%"></div>
      <div style="background-color: #F6F6F7; border: solid 1px #4285F4; border-radius: 5px; padding: 5px 10px; height: 60px; width:100%">
        <nav style="font-size: 18px; color: #4285F4">
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::ga360_overview?Date={{ _filters['ga_sessions.partition_date'] }}">GA360 Overview</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::audience?Date={{ _filters['ga_sessions.partition_date'] }}">Audience</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::acquisition?Date={{ _filters['ga_sessions.partition_date'] }}">Acquisition</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::behavior?Date={{ _filters['ga_sessions.partition_date'] }}">Behavior</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::custom_goal_conversions?Date={{ _filters['ga_sessions.partition_date'] }}">Conversions</a>
        </nav>
      </div>
    <div style="background-color: #F6F6F7; height:500px;width:100%"></div>;;
  }
}
