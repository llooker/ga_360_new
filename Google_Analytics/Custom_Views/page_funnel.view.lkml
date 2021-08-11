

view: page_funnel {
  
 derived_table: {
   sql: SELECT page1.full_visitor_id as full_vistor_id,
               page1.page_sequence_number as page1_page_sequence_number, page1.hit_time as page1_hit_time, page1.page_path as page1_page, page1.hit_id as page1_hit_id, page1.id as page1_session_id,
               page2.page_sequence_number as page2_page_sequence_number, page2.hit_time as page2_time, page2.page_path as page2_page, page2.hit_id as page2_hit_id, page2.id as page2_session_id,
               page3.page_sequence_number as page3_page_sequence_number, page3.hit_time as page3_time, page3.page_path as page3_page,page3.hit_id as page3_hit_id, page3.id as page3_session_id,
               page4.page_sequence_number as page4_page_sequence_number, page4.hit_time as page4_time, page4.page_path as page4_page,page4.hit_id as page4_hit_id, page4.id as page4_session_id,
               page5.page_sequence_number as page5_page_sequence_number, page5.hit_time as page5_time, page5.page_path as page5_page,page5.hit_id as page5_hit_id, page5.id as page5_session_id,
               page6.page_sequence_number as page6_page_sequence_number, page6.hit_time as page6_time, page6.page_path as page6_page,page6.hit_id as page6_hit_id, page6.id as page6_session_id
        FROM ${page_facts.SQL_TABLE_NAME} page1
        LEFT JOIN ${page_facts.SQL_TABLE_NAME} page2
        ON page1.id = page2.id AND page1.page_sequence_number + 1 = page2.page_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} page3
        ON page1.id = page3.id AND page1.page_sequence_number + 2 = page3.page_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} page4
        ON page1.id = page4.id AND page1.page_sequence_number + 3 = page4.page_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} page5
        ON page1.id = page5.id AND page1.page_sequence_number + 4 = page5.page_sequence_number
         LEFT JOIN ${page_facts.SQL_TABLE_NAME} page6
        ON page1.id = page6.id AND page1.page_sequence_number + 5 = page6.page_sequence_number
        ;;
        persist_for: "24 hours"
 }

 ########## FILTERS ##########

  filter: page_1 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_2 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_3 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_4 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_5 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_6 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

   ########## DIMENSIONS ##########

  dimension: full_vistor_id {
    type: string
    sql: ${TABLE}.full_vistor_id ;;
    hidden: yes
  }

  dimension: page1_hit_sequence_number {
    type: number
    sql: ${TABLE}.page1_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page1_hit_time {
    type: time
    sql: ${TABLE}.page1_hit_time ;;
    hidden: yes
  }

  dimension: page1_page {
    type: string
    sql: ${TABLE}.page1_page ;;
    hidden: yes
  }

  dimension: page1_hit_id {
    type: string
    sql: ${TABLE}.page1_hit_id ;;
    hidden: yes
  }

  dimension: page1_session_id {
    type: string
    sql: ${TABLE}.page1_session_id ;;
    hidden: yes
  }

  dimension: page2_hit_sequence_number {
    type: number
    sql: ${TABLE}.page2_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page2_time {
    type: time
    sql: ${TABLE}.page2_time ;;
    hidden: yes
  }

  dimension: page2_page {
    type: string
    sql: ${TABLE}.page2_page ;;
    hidden: yes
  }

  dimension: page2_hit_id {
    type: string
    sql: ${TABLE}.page2_hit_id ;;
    hidden: yes
  }

  dimension: page2_session_id {
    type: string
    sql: ${TABLE}.page2_session_id ;;
    hidden: yes
  }

  dimension: page3_hit_sequence_number {
    type: number
    sql: ${TABLE}.page3_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page3_time {
    type: time
    sql: ${TABLE}.page3_time ;;
    hidden: yes
  }

  dimension: page3_page {
    type: string
    sql: ${TABLE}.page3_page ;;
    hidden: yes
  }

  dimension: page3_hit_id {
    type: string
    sql: ${TABLE}.page3_hit_id ;;
    hidden: yes
  }

  dimension: page3_session_id {
    type: string
    sql: ${TABLE}.page3_session_id ;;
    hidden: yes
  }

  dimension: page4_hit_sequence_number {
    type: number
    sql: ${TABLE}.page4_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page4_time {
    type: time
    sql: ${TABLE}.page4_time ;;
    hidden: yes
  }

  dimension: page4_page {
    type: string
    sql: ${TABLE}.page4_page ;;
    hidden: yes
  }

  dimension: page4_hit_id {
    type: string
    sql: ${TABLE}.page4_hit_id ;;
    hidden: yes
  }

  dimension: page4_session_id {
    type: string
    sql: ${TABLE}.page4_session_id ;;
    hidden: yes
  }

  dimension: page5_hit_sequence_number {
    type: number
    sql: ${TABLE}.page5_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page5_time {
    type: time
    sql: ${TABLE}.page5_time ;;
    hidden: yes
  }

  dimension: page5_page {
    type: string
    sql: ${TABLE}.page5_page ;;
    hidden: yes
  }

  dimension: page5_hit_id {
    type: string
    sql: ${TABLE}.page5_hit_id ;;
    hidden: yes
  }

  dimension: page5_session_id {
    type: string
    sql: ${TABLE}.page5_session_id ;;
    hidden: yes
  }

  dimension: page6_hit_sequence_number {
    type: number
    sql: ${TABLE}.page6_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page6_time {
    type: time
    sql: ${TABLE}.page6_time ;;
    hidden: yes
  }

  dimension: page6_page {
    type: string
    sql: ${TABLE}.page6_page ;;
    hidden: yes
  }

  dimension: page6_hit_id {
    type: string
    sql: ${TABLE}.page6_hit_id ;;
    hidden: yes
  }

  dimension: page6_session_id {
    type: string
    sql: ${TABLE}.page6_session_id ;;
    hidden: yes
  }



  dimension: page1_hit_time_tagged {
    sql: CASE WHEN {% condition page_1 %} ${page1_page} {% endcondition %} THEN ${page1_hit_time_raw}
              ELSE NULL END ;;
    hidden: yes
  }

  dimension: page2_hit_time_tagged {
    sql: CASE WHEN {% condition page_2 %} ${page2_page} {% endcondition %} THEN ${page2_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page3_hit_time_tagged {
    sql: CASE WHEN {% condition page_3 %} ${page3_page} {% endcondition %} THEN ${page3_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page4_hit_time_tagged {
    sql: CASE WHEN {% condition page_4 %} ${page4_page} {% endcondition %} THEN ${page4_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page5_hit_time_tagged {
    sql: CASE WHEN {% condition page_5 %} ${page5_page} {% endcondition %} THEN ${page5_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page6_hit_time_tagged {
    sql: CASE WHEN {% condition page_6 %} ${page6_page} {% endcondition %} THEN ${page6_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }


  dimension: page1_session_id_tagged {
    sql:  CASE WHEN {% condition page_1 %} ${page1_page} {% endcondition %}  THEN ${page1_session_id}
              ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page2_session_id_tagged {
    sql:
          CASE WHEN {% condition page_2 %} ${page2_page} {% endcondition %}  AND ${page1_hit_time_tagged} < ${page2_hit_time_tagged} THEN ${page2_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page3_session_id_tagged {
    sql:  CASE WHEN {% condition page_3 %} ${page3_page} {% endcondition %}  AND ${page1_hit_time_tagged} < ${page3_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page3_hit_time_tagged} THEN ${page3_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page4_session_id_tagged {
    sql:  CASE WHEN {% condition page_4 %} ${page4_page} {% endcondition %} AND ${page1_hit_time_tagged} < ${page4_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page4_hit_time_tagged} AND ${page3_hit_time_tagged} < ${page4_hit_time_tagged} THEN ${page4_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page5_session_id_tagged {
    sql:  CASE WHEN {% condition page_5 %} ${page5_page} {% endcondition %}  AND ${page1_hit_time_tagged} < ${page5_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page5_hit_time_tagged} AND ${page3_hit_time_tagged} < ${page5_hit_time_tagged}  AND ${page4_hit_time_tagged} < ${page5_hit_time_tagged} THEN ${page5_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page6_session_id_tagged {
    sql:  CASE WHEN {% condition page_6 %} ${page6_page} {% endcondition %} AND ${page1_hit_time_tagged} < ${page6_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page6_hit_time_tagged} AND ${page3_hit_time_tagged} < ${page6_hit_time_tagged}  AND ${page4_hit_time_tagged} < ${page6_hit_time_tagged} AND ${page5_hit_time_tagged} < ${page6_hit_time_tagged} THEN ${page6_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

   ########## MEASURES ##########

  measure: count_of_page_1 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page1_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_1._in_query %}
            {{_filters['page_funnel.page_1']}}
            {% else %}
            Count of Page 1
            {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_1']}}"
    }
  }

  measure: count_of_page_2 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page2_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_2._in_query %}
    {{_filters['page_funnel.page_2']}}
    {% else %}
    Count of Page 2
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_2']}}"
    }
  }

  measure: count_of_page_3 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page3_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_3._in_query %}
    {{_filters['page_funnel.page_3']}}
    {% else %}
    Count of Page 3
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_3']}}"
    }
  }

  measure: count_of_page_4 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page4_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_4._in_query %}
    {{_filters['page_funnel.page_4']}}
    {% else %}
    Count of Page 4
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_4']}}"
    }
  }

  measure: count_of_page_5 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page5_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_5._in_query %}
    {{_filters['page_funnel.page_5']}}
    {% else %}
    Count of Page 5
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_5']}}"
    }
  }

  measure: count_of_page_6 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page6_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_6._in_query %}
    {{_filters['page_funnel.page_6']}}
    {% else %}
    Count of Page 6
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_6']}}"
    }
  }

}
