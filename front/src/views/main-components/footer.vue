<template>
  <div class="foot">
    <Row type="flex" justify="center" class="copyright">
      郑为中
      <a
        href="https://blog.csdn.net/qq_41464123"
        target="_blank"
        style="margin:0 5px;"
      >CSDN博客</a>
      <a
        href="https://gitee.com/yyzwz"
        target="_blank"
        style="margin:0 5px;"
      >GitEE</a>
    </Row>
  </div>
</template>

<script>
export default {
  name: "footer"
};
</script>

<style lang="less">
.foot {
  width: 100%;
  margin-top: 5vh;
  margin-bottom: 3vh;
  color: rgba(0, 0, 0, 0.45);
  font-size: 18px;
  .help {
    margin: 0 auto;
    margin-bottom: 1vh;
    width: 60%;
    .item {
      color: rgba(0, 0, 0, 0.45);
    }
    :hover {
      color: rgba(0, 0, 0, 0.65);
    }
  }
}
</style>
