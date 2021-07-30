<template>
  <div class="card-chart-line">
    <Card>
      <p slot="title" class="card-title">销售量统计</p>
      <div slot="extra">
        <DatePicker type="year" placeholder="选择查看的年份" style="width: 220px"></DatePicker>
      </div>
      <div class="wrap">
        <div class="chart">
          <apexchart type="line" height="280" :options="chartOptions" :series="series" />
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
  name: "line",
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
        colors: ["#599df9"],
        chart: {
          zoom: {
            enabled: false
          },
          locales: [zh],
          defaultLocale: "zh"
        },
        stroke: {
          width: 3,
          curve: "straight"
        },
        dataLabels: {
          enabled: false
        },
        markers: {
          size: 4
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
        }
      }
    };
  },
  methods: {
    init() {
      this.series = [
        {
          name: "销售金额",
          data: [10, 41, 35, 51, 49, 62, 69, 91, 148, 110, 140, 135]
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
.card-chart-line {
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
        line-height: 1.2;
      }
    }
  }
}
</style>