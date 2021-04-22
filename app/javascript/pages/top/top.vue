<template>
  <div class="min-vh-100 bg-white">
    <div
      v-show="isVisibleTopPage"
      class="container-fluid w-100"
    >
      <template v-if="$mq == 'xs'">
        <div class="mt-5 d-flex justify-content-center image-trim">
          <img
            src="~toptitle.png"
            class="top-title"
          >
        </div>

        <p class="mt-2 text-center text-muted font-weight-bold">
          TriStoは旅行の記録を詳細に残せる場を提供する<br>旅行の記録・共有サービスです。
        </p>

        <p class="mt-2 pt-3 text-center text-muted font-weight-bold">
          訪れた場所、使った金額、移動手段等を記録することで<br>旅行の詳細を体系的にまとめることができます。
        </p>

        <div class="mt-5 pt-3 mb-5">
          <template v-if="isMobile">
            <h5
              @click="toRegister"
              class="w-100 mb-3 pt-2 pb-2 text-white text-center font-weight-bold register-btn-mobile"
            >
              ユーザー登録
            </h5>
            <h5
              @click="toLogin"
              class="w-100 mb-3 pt-2 pb-2 text-white text-center font-weight-bold login-btn-mobile"
            >
              ログイン
            </h5>
            <h5
              @click="toArticles"
              class="w-100 mb-3 pt-2 pb-2 text-white text-center font-weight-bold articles-btn-mobile"
            >
              投稿一覧
            </h5>
          </template>
          <template v-else>
            <h5
              @click="toRegister"
              class="w-100 pt-2 pb-2 text-white text-center font-weight-bold register-btn"
            >
              ユーザー登録
            </h5>
            <h5
              @click="toLogin"
              class="w-100 mr-2 pt-2 pb-2 text-white text-center font-weight-bold login-btn"
            >
              ログイン
            </h5>
            <h5
              @click="toArticles"
              class="w-100 pt-2 pb-2 text-white text-center font-weight-bold articles-btn"
            >
              投稿一覧
            </h5>
          </template>
        </div>

        <div class="d-flex justify-content-center">
          <h4 class="d-inline-block mt-5 text-muted font-weight-bold">
            【 旅行記録作成の流れ 】
          </h4>
        </div>

        <p class="mt-2 mb-0 pt-3 text-center text-muted font-weight-bold">
          - 旅行の概要を登録 -
        </p>
        <div class="mb-3 ml-5 mr-5 d-flex justify-content-center image-trim-sm">
          <img
            src="~sample-sm.jpg"
            class="sample-image"
          >
        </div>

        <p class="mb-0 pt-3 text-center text-muted font-weight-bold">
          - 旅行の詳細を登録して投稿 -
        </p>
        <div class="mb-3 ml-5 mr-5 d-flex justify-content-center image-trim-xs">
          <img
            src="~sample-sm2.jpg"
            class="sample-image"
          >
        </div>
        <p class="p-0 m-0 font-weight-bold text-center">・<br>・<br>・</p>
        <div class="mb-3 ml-5 mr-5 d-flex justify-content-center image-trim-sm">
          <img
            src="~sample-sm3.jpg"
            class="sample-image"
          >
        </div>

        <p class="mb-0 text-center text-muted font-weight-bold">
          - 旅行記録が作成される -
        </p>
        <div class="mb-3 ml-5 mr-5 d-flex justify-content-center image-trim-xs">
          <img
            src="~sample-sm4.jpg"
            class="sample-image"
          >
        </div>
        <p class="p-0 m-0 font-weight-bold text-center">・<br>・<br>・</p>
        <div class="mb-3 ml-5 mr-5 d-flex justify-content-center image-trim-sm">
          <img
            src="~sample-sm5.jpg"
            class="sample-image"
          >
        </div>

        <p class="mb-0 pt-3 text-center text-muted font-weight-bold">
          - 作成された旅行記録がタイムラインに投稿される -
        </p>
        <div class="ml-5 mr-5 d-flex justify-content-center image-trim-sm">
          <img
            src="~sample-sm6.jpg"
            class="sample-image"
          >
        </div>

        <p class="mb-5 mb-0 text-center text-muted">
          ※ 投稿は非公開にすることができます
        </p>

        <div class="mt-5 mb-5 pb-3 d-flex justify-content-center">
          <h5
            @click="toRegister"
            class="p-2 m-0 text-white text-center font-weight-bold register-btn"
          >
            今すぐ始める
          </h5>
        </div>
      </template>

      <template v-else>
        <div class="d-flex justify-content-center image-trim">
          <img
            src="~toptitle.png"
            class="top-title"
          >
        </div>

        <h4 class="mt-2 text-center text-muted font-weight-bold">
          TriStoは旅行の詳細な記録を保存できる場を提供する<br>旅行の記録・共有サービスです。
        </h4>

        <h4 class="mt-5 pt-3 text-center text-muted font-weight-bold">
          訪れた場所、使った金額、移動手段などを記録することで<br>旅行の詳細を体系的にまとめることができます。
        </h4>

        <div
          id="buttons"
          class="mt-5 pt-3 mb-5 d-flex justify-content-center"
        >
          <template v-if="isMobile">
            <h5
              @click="toRegister"
              class="mr-2 pt-2 pb-2 text-white text-center font-weight-bold register-btn-mobile"
            >
              ユーザー登録
            </h5>
            <h5
              @click="toLogin"
              class="ml-2 mr-2 pt-2 pb-2 text-white text-center font-weight-bold login-btn-mobile"
            >
              ログイン
            </h5>
            <h5
              @click="toArticles"
              class="ml-2 pt-2 pb-2 text-white text-center font-weight-bold articles-btn-mobile"
            >
              投稿一覧
            </h5>
          </template>
          <template v-else>
            <h5
              @click="toRegister"
              class="mr-2 pt-2 pb-2 text-white text-center font-weight-bold register-btn"
            >
              ユーザー登録
            </h5>
            <h5
              @click="toLogin"
              class="ml-2 mr-2 pt-2 pb-2 text-white text-center font-weight-bold login-btn"
            >
              ログイン
            </h5>
            <h5
              @click="toArticles"
              class="ml-2 pt-2 pb-2 text-white text-center font-weight-bold articles-btn"
            >
              投稿一覧
            </h5>
          </template>
        </div>

        <div class="d-flex justify-content-center">
          <h3 class="d-inline-block mt-5 text-muted font-weight-bold">
            【 旅行記録作成の流れ 】
          </h3>
        </div>

        <h5 class="mt-2 mb-0 pt-3 text-center text-muted font-weight-bold">
          ー 旅行の概要を登録 ー
        </h5>
        <div class="mb-5 d-flex justify-content-center image-trim">
          <img
            src="~sample.jpg"
            class="sample-image"
          >
        </div>

        <h5 class="mt-5 mb-0 pt-3 text-center text-muted font-weight-bold">
          ー 旅行の詳細を登録して投稿 ー
        </h5>
        <div class="mb-5 d-flex justify-content-center image-trim">
          <img
            src="~sample2.jpg"
            class="sample-image"
          >
        </div>

        <h5 class="mt-5 mb-0 pt-3 text-center text-muted font-weight-bold">
          ー 旅行記録が作成され、タイムラインに投稿される ー
        </h5>
        <div class="mb-1 d-flex justify-content-center image-trim">
          <img
            src="~sample3.jpg"
            class="sample-image"
          >
        </div>

        <div class="d-flex justify-content-center image-trim">
          <img
            src="~sample4.jpg"
            class="sample-image"
          >
        </div>

        <p class="mb-5 mb-0 text-center text-muted">
          ※ 投稿は非公開にすることができます
        </p>

        <div
          id="click-now"
          class="mt-5 mb-5 pt-1 pb-3 d-flex justify-content-center"
        >
          <h5
            @click="toRegister"
            class="p-2 m-0 text-white text-center font-weight-bold register-btn"
          >
            今すぐ始める
          </h5>
        </div>
      </template>
    </div>

    <template v-if="isVisibleTopPage">
      <FooterTermAndPolicy />
    </template>
  </div>
</template>

<script>
import 'toptitle.png'
import 'sample.jpg'
import 'sample2.jpg'
import 'sample3.jpg'
import 'sample4.jpg'
import 'sample-sm.jpg'
import 'sample-sm2.jpg'
import 'sample-sm3.jpg'
import 'sample-sm4.jpg'
import 'sample-sm5.jpg'
import 'sample-sm6.jpg'
import FooterTermAndPolicy from '../../components/FooterTermAndPolicy'
import { mapGetters } from 'vuex'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'TopPage',
  components: {
    FooterTermAndPolicy
  },
  data() {
    return {
      isVisibleTopPage: false,
      isMobile: isMobile
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  created() {
    if (this.authUser) this.$router.push({ name: 'ArticleIndex' })
    setTimeout(() => {
      this.isVisibleTopPage = true
    }, 500)
  },
  methods: {
    toRegister() {
      this.$router.push({ name: 'Register' })
    },
    toLogin() {
      this.$router.push({ name: 'Login' })
    },
    toArticles() {
      this.$router.push({ name: 'ArticleIndex' })
    },
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 800px;
}

.top-title {
  width: 100%;
}

.sample-image {
  border: solid #FF58F2;
  border-radius: 6px;
  width: 100%;
}

.create-flow {
  color: #FF58F2;
  border: solid #FF58F2;
  border-radius: 6px;
}

.register-btn {
  width: 150px;
  border-radius: 6px;
  background-color: #1D51FF;
  cursor: pointer;
}

.login-btn {
  width: 150px;
  border-radius: 6px;
  background-color: #00C61E;
  cursor: pointer;
}

.articles-btn {
  width: 150px;
  border-radius: 6px;
  background-color: #FF58F2;
  cursor: pointer;
}

.register-btn:hover {
  background-color: #173BB2;
}

.login-btn:hover {
  background-color: #008B15;
}

.articles-btn:hover {
  background-color: #C642BC;
}

.register-btn-mobile {
  width: 150px;
  border-radius: 6px;
  background-color: #1D51FF;
  cursor: pointer;
}

.articles-btn-mobile {
  width: 150px;
  border-radius: 6px;
  background-color: #FF58F2;
  cursor: pointer;
}

.login-btn-mobile {
  width: 150px;
  border-radius: 6px;
  background-color: #00C61E;
  cursor: pointer;
}

.register-btn-mobile:active {
  background-color: #173BB2;
}

.login-btn-mobile:active {
  background-color: #008B15;
}

.articles-btn-mobile:active {
  background-color: #C642BC;
}

.image-trim {
  position: relative;
  overflow: hidden;
  padding-top: 60%;
}

.image-trim img {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  width: 100%;
  object-fit: cover;
}

.image-trim-sm {
  position: relative;
  overflow: hidden;
  padding-top: 141%;
}

.image-trim-sm img {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  width: 100%;
  object-fit: cover;
}

.image-trim-xs {
  position: relative;
  overflow: hidden;
  padding-top: 128%;
}

.image-trim-xs img {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  width: 100%;
  object-fit: cover;
}
</style>
