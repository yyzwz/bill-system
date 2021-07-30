<template>
  <div class="card-bar">
    <Card>
      <p slot="title" class="card-title">产品销售统计</p>
      <div slot="extra">
        <DatePicker type="year" placeholder="选择查看的年份" style="width: 220px"></DatePicker>
      </div>
      <div class="wrap">
        <div class="chart">
          <apexchart type="bar" height="280" :options="chartOptions" :series="series" />
        </div>
        <Row class="row">
          <Col span="8" class="text">
            <h6 class>总销售额</h6>
            <h3>￥10,345</h3>
          </Col>
          <Col span="8" class="text">
            <h6 class>本月</h6>
            <h3>￥7,589</h3>
          </Col>
          <Col span="8" class="text">
            <h6 class>本周</h6>
            <h3>￥1,476</h3>
          </Col>
        </Row>
      </div>
    </Card>
  </div>
</template>

<script>
var zh = require("../../../../libs/zh.json");
export default {
  name: "bar",
  components: {},
  props: {},
  data() {
    return {
      series: [
        {
          name: "",
          data: []
        }
      ],
      chartOptions: {
        colors: ["#398af7", "#63a3f9", "#b3d1fd"],
        chart: {
          stacked: true,
          toolbar: {
            show: false
          },
          zoom: {
            enabled: false
          },
          locales: [zh],
          defaultLocale: "zh"
        },
        plotOptions: {
          bar: {
            columnWidth: "40%",
            horizontal: false
          }
        },
        xaxis: {
          labels: {
            formatter: function(value) {
              return value + "月";
            }
          },
          categories: [
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12"
          ]
        },
        legend: {
          show: false
        },
        dataLabels: {
          enabled: false
        }
      }
    };
  },
  methods: {
    init() {
      this.series = [
        {
          name: "产品 A",
          data: [44, 55, 41, 67, 22, 43, 27, 45, 15, 44, 30, 44, 30, 15]
        },
        {
          name: "产品 B",
          data: [13, 23, 20, 8, 13, 27, 23, 20, 8, 13, 27, 13, 27, 50]
        },
        {
          name: "产品 C",
          data: [11, 17, 15, 15, 21, 14, 17, 15, 15, 21, 14, 21, 14, 55]
        }
      ];
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
.card-bar {
  .ivu-card-head {
    border-bottom: none !important;
  }
  .card-title {
    color: #67757c;
  }
  .wrap {
    height: 370px;
    .text {
      padding: 1rem;
      text-align: center;
      color: #67757c;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      h6 {
        font-size: 0.875rem;
        margin-bottom: 0.5rem;
        line-height: 1.2;
      }
      h3 {
        font-size: 1.3125rem;
        margin-bottom: 0.5rem;
        font-weight: 400;
      }
    }
  }
}
</style>