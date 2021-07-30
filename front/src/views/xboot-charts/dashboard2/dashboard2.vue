<template>
  <div class="dashboard-page2">
    <Row :gutter="20">
      <Col :sm="24" :md="12" :lg="6">
        <cardArea class="margin"/>
      </Col>
      <Col :sm="24" :md="12" :lg="6">
        <cardAreaFill class="margin"/>
      </Col>
      <Col :sm="24" :md="12" :lg="6">
        <cardLine />
      </Col>
      <Col :sm="24" :md="12" :lg="6">
        <cardProgress class="margin"/>
      </Col>
    </Row>
    <Row :gutter="20">
      <Col :lg="24" :xl="12">
        <LineChart class="margin"/>
      </Col>
      <Col :lg="24" :xl="12">
        <bubble class="margin"/>
      </Col>
    </Row>
    <Row :gutter="20">
      <Col :lg="24" :xl="18">
        <mapCard class="margin"/>
      </Col>
      <Col :lg="24" :xl="6">
        <activity class="margin"/>
      </Col>
    </Row>
  </div>
</template>

<script>
import cardArea from "./components/cardArea.vue";
import cardAreaFill from "./components/cardAreaFill.vue";
import cardLine from "./components/cardLine.vue";
import cardProgress from "./components/cardProgress.vue";
import LineChart from "./components/line.vue";
import bubble from "./components/bubble.vue";
import mapCard from "./components/map.vue";
import activity from "./components/activity.vue";
export default {
  name: "dashboard1",
  components: {
    cardArea,
    cardAreaFill,
    LineChart,
    cardLine,
    cardProgress,
    bubble,
    mapCard,
    activity
  },
  data() {
    return {};
  },
  methods: {
    init() {}
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less" scoped>
.dashboard-page2 {
  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, PingFang SC,
    Hiragino Sans GB, Microsoft YaHei, Helvetica Neue, Helvetica, Arial,
    sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol;
  .margin {
    margin-bottom: 20px;
  }
}
</style>