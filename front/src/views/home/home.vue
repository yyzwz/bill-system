<template>
  <div :style="{ height: clientHeight }" class="topDiv">
    <Row :gutter="20">
      <!-- 主体部分 -->
      <div class="body">
        <!--logo标题图片 -->
        <img class="title" src="../../assets/login/logo.png" alt="" />
        <!--第二排内容 -->
        <div class="awayMenu">
          <!--左侧 -->
          <div class="awayLeft">
            <span class="manage2">
              欢迎
              <!--用户名称 -->
              <span>{{ name }}</span>
            </span>
            <!--登入地址 -->
            <div class="manage">登入地址：{{ location }}</div>
          </div>
          <!--时间，上下布局 -->
          <div class="bottom">
            <!--年月日 -->
            <span class="showtime">{{ showtime }}</span>
            <!--时分 -->
            <span class="showtime2">{{ showtime2 }}</span>
          </div>
        </div>
        <!--三层标题 -->
        <div class="bigTips">
          <span style="color:rgba(255,255,255,0.8)"></span>
          <span style="67.5%"> </span>
        </div>
        <!--常用按钮层 -->
        <div class="buttonMenu">
          <!--常用按钮盒子 -->
          <div class="addMenuBox">
            <!--循环遍历按钮 -->
            <div
              class="addMenu"
              v-for="(item, index) in addMenuTempList"
              :key="index"
              @click="selectItem(item)"
            >
              {{ item.title }}
            </div>
          </div>
          <!--分隔线 -->
          <div class="shu"></div>
        </div>
      </div>
    </Row>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import { ipInfo } from "@/api/index";
export default {
  name: "dashboard-2",
  data() {
    return {
      name: "",
      showtime: "",
      showtime2: "",
      ip: "",
      location: "公司内网",
      jonNumber: "",
      addMenuTempList: [],
    };
  },

  methods: {
    init() {
      let user = JSON.parse(Cookies.get("userInfo"));
      this.name = user.nickname;
      this.jonNumber = user.username;
      this.getNowTime();
      ipInfo().then((res) => {
        if (res.success) {
          this.location = res.result;
        }
      });
      this.timer = setInterval(this.getNowTime, 60000);
    },
    getNowTime() {
      this.showtime = this.format(new Date(), "yyyy年MM月dd日");
      this.showtime2 = this.format(new Date(), "HH:mm");
    },
  },
  mounted() {
    this.init();
    this.clientHeight = `${document.documentElement.clientHeight}`; //获取浏览器可视区域高度
    let that = this;
    window.onresize = function() {
      this.clientHeight = `${document.documentElement.clientHeight}`;
      if (that.$refs.page) {
        that.$refs.page.style.minHeight = clientHeight - 100 + "px";
      }
    };
  },
  watch: {
    clientHeight() {
      this.changeFixed(this.clientHeight);
    },
  },
};
</script>

<style lang="less" scoped>
@import "./home.less";
.margin {
  margin-bottom: 20px;
}
.awayLeft {
  width: 60%;
  display: flex;
  align-items: center;
}
.bottom {
  width: 30%;
  margin-left: 10%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.title {
  width: 30%;
  margin: 5vh 0;
}
.awayMenu {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.manage {
  width: 40%;
  height: 100%;
  font-family: Microsoft YaHei;
  font-size: 20px;
  display: flex;
  align-items: center;
  color: rgb(255, 255, 255, 0.7);
}
.manage2 {
  width: 60%;
  height: 100%;
  font-size: 28px;
  display: flex;
  align-items: center;
  color: rgb(255, 255, 255, 0.7);
}
.buttonMenu {
  width: 100%;
  display: flex;
}
.bigTips {
  width: 100%;
  display: flex;
  justify-content: left;
  align-items: center;
  margin-top: 3vh;
  margin-bottom: 3vh;
  font-size: 20px;
}
.addMenuBox {
  width: 50%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  flex-wrap: wrap;
  .addMenu {
    width: 45%;
    // min-width: 180px;
    height: 22%;
    margin: 2% 2.5%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(255, 255, 255, 0.4);
    border-radius: 20px;
    color: #fff;
    font-size: 20px;
  }
}
.addMenu :nth-child(5) {
  margin-bottom: 0;
}
.addMenu :nth-child(6) {
  margin-bottom: 0;
}
.shu {
  width: 0.2%;
  margin: 0 9.9%;
  background-color: #4c4c4c;
}
.threeButton {
  width: 30%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
}
.showtime {
  font-family: Microsoft YaHei;
  font-size: 22px;
  letter-spacing: 1px;
  color: rgb(255, 255, 255);
  font-weight: 100;
  text-align: center;
}
.showtime2 {
  font-family: Microsoft YaHei;
  font-size: 26px;
  font-weight: 500;
  letter-spacing: 1px;
  color: rgb(255, 255, 255);
  text-align: center;
}
.homeThreeIcon {
  opacity: 1;
  height: 25px;
  width: 25px;
  margin-right: 10%;
}
.button {
  width: 60%;
  height: 28%;
  min-width: 210px;
  max-width: 360px;
  max-height: 80px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: rgba(255, 255, 255, 0.3);
  border-radius: 10px;
  padding: 20px;
  z-index: 99;
  .left {
    width: 60%;
    min-width: 120px;
    display: flex;
    align-items: center;
  }
  .text {
    color: #fff;
    font-size: 20px;
    position: relative;
  }
  .shu {
    width: 1px !important;
    height: 100%;
    max-height: 35px;
    background-color: #fff;
  }
  .number {
    font-size: 22px;
    color: #fff;
  }
}
.bottomText {
  opacity: 0.7;
  width: 100%;
  margin-top: 7vh;
  text-align: left;
  font-size: 16px;
  color: #e6e6e6;
  text-decoration: underline;
}
</style>
