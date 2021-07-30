<style lang="less">
@import "./home.less";
@import "../../styles/common.less";
</style>

<template>
  <div>
    <div v-show="currNav=='xboot'" class="home">
      <Row :gutter="10">
        <Col :lg="24" :xl="8">
          <Row :gutter="10">
            <Col :lg="12" :xl="24" :style="{marginBottom: '10px'}">
              <Card>
                <Row type="flex" class="user-info">
                  <Col span="8">
                    <Row class-name="made-child-con-middle" type="flex" align="middle">
                      <img class="avator-img" :src="avatarPath" />
                    </Row>
                  </Col>
                  <Col span="16" style="padding-left:6px;">
                    <Row class-name="made-child-con-middle" type="flex" align="middle">
                      <div>
                        <b class="card-user-info-name">{{ username }}</b>
                        <p>您好，超市账单管理系统 欢迎您的使用</p>
                      </div>
                    </Row>
                  </Col>
                </Row>
                <div class="line-gray"></div>
                <Row class="margin-top-8">
                  <Col span="8">
                    <p class="notwrap">本次登录地点:</p>
                  </Col>
                  <Col span="16" class="padding-left-8">{{city}}</Col>
                </Row>
              </Card>
            </Col>
          </Row>
        </Col>
        <Col :lg="24" :xl="16">
          <Row :gutter="5">
            <Col :sm="24" :md="12" :lg="6" :style="{marginBottom: '10px'}">
              <info-card
                id-name="user_created_count"
                :end-val="count.createUser"
                iconType="md-person-add"
                color="#2d8cf0"
                intro-text="今日新增用户"
              ></info-card>
            </Col>
            <Col :sm="24" :md="12" :lg="6" :style="{marginBottom: '10px'}">
              <info-card
                id-name="visit_count"
                :end-val="count.visit"
                iconType="ios-eye"
                color="#64d572"
                :iconSize="50"
                intro-text="今日浏览量"
              ></info-card>
            </Col>
            <Col :sm="24" :md="12" :lg="6" :style="{marginBottom: '10px'}">
              <info-card
                id-name="collection_count"
                :end-val="count.collection"
                iconType="md-cloud-upload"
                color="#ffd572"
                intro-text="今日数据采集量"
              ></info-card>
            </Col>
            <Col :sm="24" :md="12" :lg="6" :style="{marginBottom: '10px'}">
              <info-card
                id-name="transfer_count"
                :end-val="count.transfer"
                iconType="md-shuffle"
                color="#f25e43"
                intro-text="今日服务调用量"
              ></info-card>
            </Col>
          </Row>
        </Col>
      </Row>
      <Row :gutter="10">
        <Col :lg="24" :xl="16" :style="{marginBottom: '10px'}">
          <visit-volume />
        </Col>
        <Col :lg="24" :xl="8" :style="{marginBottom: '10px'}">
          <visit-separation />
        </Col>
      </Row>
    </div>
    <div v-show="currNav=='doc'||currNav=='xboot-show'||currNav=='xpay'||currNav=='xmall'">
      <show />
    </div>
    <div v-show="currNav=='app'">
      <dashboard2 />
    </div>

    <Modal
      v-model="showVideo"
      title="作者亲自制作XBoot炫酷文字快闪宣传片"
      :styles="{top: '30px'}"
      footer-hide
      width="1000"
    >
      <iframe
        src="//player.bilibili.com/player.html?aid=30284667&cid=52827707&page=1"
        scrolling="no"
        border="0"
        frameborder="no"
        framespacing="0"
        allowfullscreen="true"
        style="width:100%;height:550px;"
      ></iframe>
    </Modal>
  </div>
</template>

<script>
import { ipInfo, getNotice } from "@/api/index";
import visitVolume from "./components/visitVolume.vue";
import visitSeparation from "./components/visitSeparation.vue";
import infoCard from "./components/infoCard.vue";
import show from "./show.vue";
import dashboard2 from "../xboot-charts/dashboard2/dashboard2.vue";
import Cookies from "js-cookie";
import "gitalk/dist/gitalk.css";
import Gitalk from "gitalk";

export default {
  name: "home",
  components: {
    visitVolume,
    visitSeparation,
    infoCard,
    show,
    dashboard2
  },
  data() {
    return {
      showVideo: false,
      count: {
        createUser: 496,
        visit: 3264,
        collection: 24389305,
        transfer: 39503498
      },
      city: "",
      username: ""
    };
  },
  computed: {
    currNav() {
      return this.$store.state.app.currNav;
    },
    avatarPath() {
      return localStorage.avatorImgPath;
    }
  },
  methods: {
    init() {
      let userInfo = JSON.parse(Cookies.get("userInfo"));
      this.username = userInfo.nickname;
      ipInfo().then(res => {
        if (res.success) {
          this.city = res.result;
        }
      });
    },
    showNotice() {
      getNotice().then(res => {
        if (res.success) {
          if (!res.result) {
            return;
          }
          let data = res.result;
          if (
            data.open &&
            (data.title || data.content) &&
            data.position == "HOME"
          ) {
            this.$Notice.info({
              title: data.title,
              desc: data.content,
              duration: data.duration
            });
          }
        }
      });
    }
  },
  mounted() {
    this.init();
    // 通知
    let noticeFlag = "noticeShowed";
    let notice = Cookies.get(noticeFlag);
    if (notice != noticeFlag) {
      this.showNotice();
      Cookies.set(noticeFlag, noticeFlag);
    }
    // Gitalk
    var gitalk = new Gitalk({
      clientID: "a128de2dd7383614273a",
      clientSecret: "a77691ecb662a8303a6c686ae651ae035868da6e",
      repo: "xboot-comments",
      owner: "Exrick",
      admin: ["Exrick"],
      distractionFreeMode: false // 遮罩效果
    });
    gitalk.render("comments");
    // 宣传视频
    let videoFlag = "videoShowed";
    let xbootVideo = Cookies.get(videoFlag);
    if (xbootVideo != videoFlag) {
      this.showVideo = true;
      Cookies.set(videoFlag, videoFlag);
    }
  }
};
</script>
