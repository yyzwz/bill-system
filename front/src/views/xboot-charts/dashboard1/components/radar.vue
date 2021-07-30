<template>
  <div class="card-radar">
    <Card>
      <p slot="title" class="card-title">订单分析</p>
      <div class="wrap">
        <div class="chart">
          <apexchart type="radar" height="350" :options="chartOptions" :series="series" />
        </div>
      </div>
    </Card>
  </div>
</template>

<script>
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
        colors: ["#5088de", "#55c2d6", "#f1633b"],
        chart: {
          toolbar: {
            show: false
          }
        },
        stroke: {
          width: 0
        },
        fill: {
          opacity: 0.4
        },
        markers: {
          size: 0
        },
        labels: ["2015年", "2016年", "2017年", "2018年", "2019年", "2020年"],
        yaxis: {
          labels: {
            show: true,
            style: {
              color: "#999"
            }
          }
        },
        legend: {
          show: true
        },
        dataLabels: {
          enabled: true
        }
      }
    };
  },
  methods: {
    init() {
      this.series = [
        {
          name: "PC端",
          data: [80, 50, 30, 40, 100, 20]
        },
        {
          name: "手机端",
          data: [20, 30, 40, 80, 20, 80]
        },
        {
          name: "平板端",
          data: [44, 76, 78, 13, 43, 10]
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
.card-radar {
  .ivu-card-head {
    border-bottom: none !important;
  }
  .card-title {
    color: #67757c;
  }
  .wrap {
    height: 350px;
  }
}
</style>