<template>
  <div class="min-vh-100 bg-white">
    <div
      v-show="isVisibleTopPage"
      class="container-fluid w-100"
    >
      <template v-if="$mq == 'xs'">
        <div class="mt-5 d-flex justify-content-center image-trim">
          <img
            :src="require('../../../assets/images/toptitle.png')"
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
              class="w-100 mb-3 pt-2 pb-2 text-white text-center font-weight-bold register-btn-mobile"
              @click="toRegister"
            >
              ユーザー登録
            </h5>
            <h5
              class="w-100 mb-3 pt-2 pb-2 text-white text-center font-weight-bold login-btn-mobile"
              @click="toLogin"
            >
              ログイン
            </h5>
            <h5
              class="w-100 mb-3 pt-2 pb-2 text-white text-center font-weight-bold articles-btn-mobile"
              @click="toArticles"
            >
              投稿一覧
            </h5>
          </template>
          <template v-else>
            <h5
              class="w-100 pt-2 pb-2 text-white text-center font-weight-bold register-btn"
              @click="toRegister"
            >
              ユーザー登録
            </h5>
            <h5
              class="w-100 mr-2 pt-2 pb-2 text-white text-center font-weight-bold login-btn"
              @click="toLogin"
            >
              ログイン
            </h5>
            <h5
              class="w-100 pt-2 pb-2 text-white text-center font-weight-bold articles-btn"
              @click="toArticles"
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
        <div class="mb-5 d-flex justify-content-center image-trim">
          <img
            :src="require('../../../assets/images/sample.jpg')"
            class="sample-image"
          >
        </div>

        <p class="mt-5 mb-0 pt-3 text-center text-muted font-weight-bold">
          - 旅行の詳細を登録して投稿 -
        </p>
        <div class="mb-5 d-flex justify-content-center image-trim">
          <img
            :src="require('../../../assets/images/sample2.jpg')"
            class="sample-image"
          >
        </div>

        <p class="mt-5 mb-0 pt-3 text-center text-muted font-weight-bold">
          - 旅行記録が作成されタイムラインに投稿される -
        </p>
        <div class="d-flex justify-content-center image-trim">
          <img
            :src="require('../../../assets/images/sample3.jpg')"
            class="sample-image"
          >
        </div>

        <p class="mb-5 mb-0 text-center text-muted">
          ※ 投稿は非公開にすることができます
        </p>

        <h3 class="pt-5 mb-5 mb-0 text-center font-weight-bold lets-use">
          TriStoで旅行の全てを<br>記録しましょう！
        </h3>

        <div class="mb-5 pb-5 d-flex justify-content-center">
          <h5
            class="p-2 m-0 text-white text-center font-weight-bold register-btn"
            @click="toRegister"
          >
            今すぐ始める
          </h5>
        </div>
      </template>

      <template v-else>
        <div class="d-flex justify-content-center image-trim">
          <img
            :src="require('../../../assets/images/toptitle.png')"
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
              class="mr-2 pt-2 pb-2 text-white text-center font-weight-bold register-btn-mobile"
              @click="toRegister"
            >
              ユーザー登録
            </h5>
            <h5
              class="ml-2 mr-2 pt-2 pb-2 text-white text-center font-weight-bold login-btn-mobile"
              @click="toLogin"
            >
              ログイン
            </h5>
            <h5
              class="ml-2 pt-2 pb-2 text-white text-center font-weight-bold articles-btn-mobile"
              @click="toArticles"
            >
              投稿一覧
            </h5>
          </template>
          <template v-else>
            <h5
              class="mr-2 pt-2 pb-2 text-white text-center font-weight-bold register-btn"
              @click="toRegister"
            >
              ユーザー登録
            </h5>
            <h5
              class="ml-2 mr-2 pt-2 pb-2 text-white text-center font-weight-bold login-btn"
              @click="toLogin"
            >
              ログイン
            </h5>
            <h5
              class="ml-2 pt-2 pb-2 text-white text-center font-weight-bold articles-btn"
              @click="toArticles"
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
            :src="require('../../../assets/images/sample.jpg')"
            class="sample-image"
          >
        </div>

        <h5 class="mt-5 mb-0 pt-3 text-center text-muted font-weight-bold">
          ー 旅行の詳細を登録して投稿 ー
        </h5>
        <div class="mb-5 d-flex justify-content-center image-trim">
          <img
            :src="require('../../../assets/images/sample2.jpg')"
            class="sample-image"
          >
        </div>

        <h5 class="mt-5 mb-0 pt-3 text-center text-muted font-weight-bold">
          ー 旅行記録が作成されタイムラインに投稿される ー
        </h5>
        <div class="d-flex justify-content-center image-trim">
          <img
            :src="require('../../../assets/images/sample3.jpg')"
            class="sample-image"
          >
        </div>

        <p class="mb-5 mb-0 text-center text-muted">
          ※ 投稿は非公開にすることができます
        </p>

        <h3 class="pt-5 mb-5 mb-0 text-center font-weight-bold lets-use">
          TriStoで旅行の全てを記録しましょう！
        </h3>

        <div
          id="click-now"
          class="mb-5 pt-1 pb-5 d-flex justify-content-center"
        >
          <h5
            class="p-2 m-0 text-white text-center font-weight-bold register-btn"
            @click="toRegister"
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
    if (this.authUser) {
      this.$router.push({ name: 'ArticleIndex' })
    } else {
      setTimeout(() => {
        this.isVisibleTopPage = true
      }, 500)
    }
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
  border: solid #DF81A2;
  border-radius: 6px;
  width: 100%;
}

.create-flow {
  color: #DF81A2;
  border: solid #DF81A2;
  border-radius: 6px;
}

.register-btn {
  width: 150px;
  border-radius: 6px;
  background-color: #6EB7DB;
  cursor: pointer;
}

.login-btn {
  width: 150px;
  border-radius: 6px;
  background-color: #81D674;
  cursor: pointer;
}

.articles-btn {
  width: 150px;
  border-radius: 6px;
  background-color: #DF81A2;
  cursor: pointer;
}

.register-btn:hover {
  background-color: #208DC3;
}

.login-btn:hover {
  background-color: #3EBA2B;
}

.articles-btn:hover {
  background-color: #BE6081;
}

.register-btn-mobile {
  width: 150px;
  border-radius: 6px;
  background-color: #6EB7DB;
  cursor: pointer;
}

.login-btn-mobile {
  width: 150px;
  border-radius: 6px;
  background-color: #81D674;
  cursor: pointer;
}

.articles-btn-mobile {
  width: 150px;
  border-radius: 6px;
  background-color: #DF81A2;
  cursor: pointer;
}

.register-btn-mobile:active {
  background-color: #208DC3;
}

.login-btn-mobile:active {
  background-color: #3EBA2B;
}

.articles-btn-mobile:active {
  background-color: #BE6081;
}

.lets-use {
  color: #DF81A2;
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
</style>
