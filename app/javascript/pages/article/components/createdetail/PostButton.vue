<template>
  <div>
    <template v-if="isMobile">
      <h5
        class="p-2 mb-3 w-100 text-center text-white font-weight-bold post-button-mobile"
        @click="postArticle"
      >
        投稿する
      </h5>
      <h5
        class="m-0 p-2 w-100 text-center bg-white font-weight-bold draft-button-mobile"
        @click="saveDraft"
      >
        非公開一覧に追加する
      </h5>
    </template>
    <template v-else>
      <h5
        class="p-2 mb-3 w-100 text-center text-white font-weight-bold post-button"
        @click="postArticle"
      >
        投稿する
      </h5>
      <h5
        class="m-0 p-2 w-100 text-center bg-white font-weight-bold draft-button"
        @click="saveDraft"
      >
        非公開一覧に追加する
      </h5>
    </template>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'PostButton',
  props: {
    country: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      article: {
        status: 'published'
      },
      isMobile: isMobile
    }
  },
  methods: {
    async postArticle() {
      await this.$axios.patch(`articles/${this.$route.query.id}`, this.article)
        .catch(err => console.log(err.response))
      if (this.country == '日本') {
        this.$store.commit('articles/articleJapanTrue')
      } else {
        this.$store.commit('articles/articleJapanFalse')
      }
      this.$store.commit('pages/setCurrentPage', 'home')
      this.$router.push({ name: 'ArticleIndex' })
    },
    saveDraft() {
      this.$store.commit('pages/setCurrentPage', 'user')
      this.$router.push({ name: 'MyPage', params: { draft: true } })
    }
  }
}
</script>

<style scoped>
.post-button {
  background-color: #DF81A2;
  border: solid #DF81A2;
  cursor: pointer;
  border-radius: 6px;
}

.post-button:hover {
  background-color: #BE6081;
  border: solid #BE6081;
  position: relative;
}

.draft-button {
  color: #DF81A2;
  border: solid #DF81A2;
  border-radius: 6px;
  cursor: pointer;
}

.draft-button:hover {
  color: #BE6081;
  border: solid #BE6081;
  position: relative;
}

.post-button-mobile {
  background-color: #DF81A2;
  border: solid #DF81A2;
  cursor: pointer;
  border-radius: 6px;
}

.post-button-mobile:active {
  background-color: #BE6081;
  border: solid #BE6081;
  position: relative;
}

.draft-button-mobile {
  color: #DF81A2;
  border: solid #DF81A2;
  border-radius: 6px;
  cursor: pointer;
}

.draft-button-mobile:active {
  color: #BE6081;
  border: solid #BE6081;
  position: relative;
}
</style>
