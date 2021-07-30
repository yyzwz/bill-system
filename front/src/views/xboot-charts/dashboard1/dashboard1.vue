<template>
  <div class="dashboard-page">
    <Row :gutter="20">
      <Col :sm="24" :md="12" :lg="6">
        <cardInfo id="income" :icon="icons.icon1" title="总收入" :value="953000" class="margin"/>
      </Col>
      <Col :sm="24" :md="12" :lg="6">
        <cardInfo id="out" :icon="icons.icon2" title="总支出" :value="236000" class="margin"/>
      </Col>
      <Col :sm="24" :md="12" :lg="6">
        <cardInfo id="order" :icon="icons.icon3" title="订单总数" :value="987563" class="margin"/>
      </Col>
      <Col :sm="24" :md="12" :lg="6">
        <cardInfo id="users" :icon="icons.icon4" title="会员总数" :value="987563" class="margin"/>
      </Col>
    </Row>
    <Row :gutter="20">
      <Col :lg="24" :xl="12">
        <LineChart class="margin"/>
      </Col>
      <Col :lg="24" :xl="12">
        <bar class="margin"/>
      </Col>
    </Row>
    <Row :gutter="20">
      <Col :lg="24" :xl="16">
        <mapCard class="margin"/>
      </Col>
      <Col :lg="24" :xl="8">
        <radar class="margin"/>
      </Col>
    </Row>
    
  </div>
</template>

<script>
import cardInfo from "./components/cardInfo.vue";
import LineChart from "./components/line.vue";
import bar from "./components/bar.vue";
import mapCard from "./components/map.vue";
import radar from "./components/radar.vue";
export default {
  name: "dashboard1",
  components: {
    cardInfo,
    LineChart,
    bar,
    mapCard,
    radar
  },
  data() {
    return {
      icons: {
        icon1: require("@/assets/dashboard/fee.png"),
        icon2: require("@/assets/dashboard/department.png"),
        icon3: require("@/assets/dashboard/console.png"),
        icon4: require("@/assets/dashboard/user.png")
      }
    };
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
.dashboard-page {
  font-family: Montserrat, sans-serif;
  .margin {
    margin-bottom: 20px;
  }
}
</style>