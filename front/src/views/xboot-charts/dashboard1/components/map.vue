<template>
  <div class="card-map">
    <Card>
      <p slot="title" class="card-title">访问统计</p>
      <Row>
        <Col span="16">
          <div style="height:350px;" id="map"></div>
        </Col>
        <Col span="8">
          <Row type="flex" justify="center" align="middle" class="right">
            <div class="content">
              <progressItem value="1,12,540" title="北京" :data="72" color="#5089de" />
              <progressItem value="51,480" title="上海" :data="39" color="#23b397" />
              <progressItem value="45,760 " title="深圳" :data="61" color="#56c2d6" />
              <progressItem value="98,512" title="广州" :data="52" color="#f8cc6b" />
              <progressItem value="2,154" title="成都" :data="28" color="#f0643b" />
            </div>
          </Row>
        </Col>
      </Row>
    </Card>
  </div>
</template>

<script>
import echarts from "echarts";
import progressItem from "./progress";
import geoData from "../../map-data/get-geography-value.js";
import cityData from "../../map-data/get-city-value.js";
var chinaJson = require("../../map-data/china.json");
export default {
  name: "card-map",
  components: {
    progressItem
  },
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
      var map = echarts.init(document.getElementById("map"));
      echarts.registerMap("china", chinaJson);
      map.setOption({
        backgroundColor: "#FFF",
        toolbox: {
          show: true,
          left: "left",
          top: "top",
          feature: {
            dataView: { readOnly: false },
            restore: {},
            saveAsImage: {}
          }
        },
        geo: {
          map: "china",
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
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          containLabel: true
        },
        series: [
          {
            type: "scatter",
            coordinateSystem: "geo",
            data: this.convertData(cityData),
            symbolSize: function(val) {
              return val[2] / 10;
            },
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
                color: "#63a3f9"
              }
            }
          }
        ]
      });

      window.addEventListener("resize", function() {
        map.resize();
      });
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
.card-map {
  .ivu-card-head {
    border-bottom: none !important;
  }
  .card-title {
    color: #67757c;
  }
  .right {
    height: 350px;
    .content {
      height: 290px;
      width: 100%;
      margin-right: 10px;
    }
  }
}
</style>