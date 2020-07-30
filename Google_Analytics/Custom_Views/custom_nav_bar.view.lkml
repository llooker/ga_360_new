view: custom_nav_bar {
  extension: required

  parameter: dashboard_type {
    view_label: "Dashboard Navigation"
    type: string
    allowed_value: {
      label: "Audience"
      value: "audience"
    }
    allowed_value: {
      label: "Behavior"
      value: "behavior"
    }
    allowed_value: {
      label: "Acquisition"
      value: "acquisition"
    }
    allowed_value: {
      label: "Overview"
      value: "overview"
    }
  }

  measure: single_dashboard_button {
    view_label: "Dashboard Navigation"
    label: "Single Button"
    type: string
    sql: {% parameter dashboard_type %};;
    html:
    <button style="background-color: #4285F4; border: none; text-align: center; color: white; padding: 10px 25px; font-size: 12px;">
      <a style="text-decoration: none; color: white;" href="/dashboards/@{MODEL_NAME}::{{ value }}"  target="_blank"><b>Go to {{ value }}<br>Dashboard</b> ➜</a>
    </button>;;
  }

  measure: dash_nav {
    view_label: "Dashboard Navigation"
    label: "Navigation Bar"
    type: string
    sql: "";;
    html:
    <div style="background-color: #F6F6F7; height:500px;width:100%"></div>
      <div style="background-color: #F6F6F7; border: solid 1px #4285F4; border-radius: 5px; padding: 5px 10px; height: 60px; width:100%">
        <nav style="font-size: 18px; color: #4285F4">
          <a style="padding: 5px; float: left; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::overview">☰ Overview</a>
          <a style="padding: 5px; float: left; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::audience">Audience</a>
          <a style="padding: 5px; float: left; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::behavior">Acquisition</a>
          <a style="padding: 5px; float: left; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::behavior">Behavior</a>
          <a style="padding: 5px; float: left; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/@{MODEL_NAME}::custom_goal_conversions">Conversions</a>
        </nav>
      </div>
    <div style="background-color: #F6F6F7; height:500px;width:100%"></div>;;
  }
}
