<template>
  <div class="card-map-world">
    <Card :padding="0">
      <p slot="title" class="card-title">访问统计</p>
      <Row>
        <Col class="chart">
          <div style="height:400px;" id="wordMap"></div>
        </Col>
      </Row>
    </Card>
  </div>
</template>

<script>
import axios from "axios";
import echarts from "echarts";
import geoData from "../../map-data/get-geography-value.js";
import cityData from "../../map-data/get-city-value.js";
export default {
  name: "card-map",
  components: {},
  props: {},
  data() {
    return {};
  },
  methods: {
    convertData(data) {
      let res = [];
      let len = data.length;
      for (var i = 0; i < len; i++) {
        var geoCoord = geoData[data[i].name];
        if (geoCoord) {
          res.push({
            name: data[i].name,
            value: geoCoord.concat(data[i].value)
          });
        }
      }
      return res;
    },
    init() {
      axios
        .get("https://cdn.jsdelivr.net/npm/echarts@4.5.0/map/json/world.json")
        .then(res => {
          if (!res) {
            this.$Message.error("加载世界地图JSON数据失败");
            return;
          }
          let wordJson = res;
          var map = echarts.init(document.getElementById("wordMap"));
          echarts.registerMap("word", wordJson);
          map.setOption({
            backgroundColor: "#FFF",
            geo: {
              map: "word",
              zoom: 1.2,
              label: {
                emphasis: {
                  show: false
                }
              },
              itemStyle: {
                normal: {
                  areaColor: "#EFEFEF",
                  borderColor: "#CCC"
                },
                emphasis: {
                  areaColor: "#E5E5E5"
                }
              }
            },
            series: [
              {
                type: "scatter",
                coordinateSystem: "geo",
                data: [
                  {
                    name: "北京",
                    value: [116.46, 39.92, 250]
                  }
                ],
                symbolSize: 12,
                label: {
                  normal: {
                    formatter: "{b}",
                    position: "right",
                    show: false
                  },
                  emphasis: {
                    show: true
                  }
                },
                itemStyle: {
                  normal: {
                    color: "#63a3f9",
                    borderColor: "#fff",
                    borderWidth: 2
                  }
                }
              },
              {
                type: "scatter",
                coordinateSystem: "geo",
                data: [
                  {
                    name: "莫斯科",
                    value: [37.36, 55.45, 150]
                  }
                ],
                symbolSize: 12,
                label: {
                  normal: {
                    formatter: "{b}",
                    position: "right",
                    show: false
                  },
                  emphasis: {
                    show: true
                  }
                },
                itemStyle: {
                  normal: {
                    color: "#00e395",
                    borderColor: "#fff",
                    borderWidth: 2
                  }
                }
              },
              {
                type: "scatter",
                coordinateSystem: "geo",
                data: [
                  {
                    name: "华盛顿",
                    value: [-77.72, 38.53, 50]
                  }
                ],
                symbolSize: 12,
                label: {
                  normal: {
                    formatter: "{b}",
                    position: "right",
                    show: false
                  },
                  emphasis: {
                    show: true
                  }
                },
                itemStyle: {
                  normal: {
                    color: "#feb119",
                    borderColor: "#fff",
                    borderWidth: 2
                  }
                }
              },
              {
                type: "scatter",
                coordinateSystem: "geo",
                data: [
                  {
                    name: "巴西利亚",
                    value: [-47.92, -15.77, 30]
                  }
                ],
                symbolSize: 12,
                label: {
                  normal: {
                    formatter: "{b}",
                    position: "right",
                    show: false
                  },
                  emphasis: {
                    show: true
                  }
                },
                itemStyle: {
                  normal: {
                    color: "#ff455f",
                    borderColor: "#fff",
                    borderWidth: 2
                  }
                }
              }
            ]
          });
          window.addEventListener("resize", function() {
            map.resize();
          });
        });
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
.card-map-world {
  .ivu-card-head {
    border-bottom: none !important;
  }
  .card-title {
    color: #67757c;
  }
}
</style>