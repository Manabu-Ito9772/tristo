<template>
  <div class="container-fluid pt-5 d-flex justify-content-center text-muted">
    <div>
      <h1 class="mb-4 font-weight-thin">
        404 NotFound
      </h1>
      <div class="mb-5">
        <p>お探しのページが見つかりませんでした。</p>
        <p>一時的にアクセスができない状況にあるか<br>移動もしくは削除された可能性があります。</p>
        <p>URLにお間違いがないか再度ご確認ください。</p>
      </div>
      <template v-if="isMobile">
        <div
          class="text-white font-weight-bold button-mobile"
          @click="toArticleIndex"
        >
          トップページに戻る
        </div>
      </template>
      <template v-else>
        <div
          class="text-white font-weight-bold button"
          @click="toArticleIndex"
        >
          トップページに戻る
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'NotFound',
  data() {
    return {
      isMobile: isMobile
    }
  },
  methods: {
    toArticleIndex() {
      this.$router.push({ name: 'ArticleIndex' })
    }
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 500px;
}

.button {
  display: inline-block;
  background-color: #DF81A2;
  padding: 8px 15px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 6px;
}

.button:hover {
  background-color: #BE6081;
  position: relative;
}

.button-mobile {
  display: inline-block;
  background-color: #DF81A2;
  padding: 8px 15px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 6px;
}

.button-mobile:active {
  background-color: #BE6081;
  position: relative;
}
</style>
