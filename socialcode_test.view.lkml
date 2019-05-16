view: socialcode_test {
  derived_table: {
    sql: SELECT  "1d_click" AS attribution, 1 AS id
      UNION ALL
      SELECT  "7d_click" AS attribution, 2 AS id
      UNION ALL
      SELECT  "28d_click" AS attribution, 3 AS id
      UNION ALL
      SELECT  "1d_view" AS attribution, 4 AS id
      UNION ALL
      SELECT  "7d_view" AS attribution, 5 AS id
      UNION ALL
      SELECT  "28d_view"  AS attribution, 6 AS id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: attribution {
    type: string
    sql: ${TABLE}.attribution ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "test drill"
      url: "/dashboards/68?attribution={{ _filters['socialcode_test.attribution'] }}"
    }
  }

  set: detail {
    fields: [attribution, id]
  }

  filter: attribution_select {
    label: "Attribution Window"
    hidden: no
    suggestions: ["1d_click", "7d_click", "28d_click", "1d_view", "7d_view", "28d_view"]
  }

  dimension: attribution_select_dim {
    type: string
    sql: {% condition attribution_select %} ${attribution} {% endcondition %}  ;;
  }
}
