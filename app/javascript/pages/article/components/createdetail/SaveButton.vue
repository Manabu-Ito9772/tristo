<template>
  <div>
    <template v-if="state == 'published'">
      <template v-if="isMobile">
        <h5
          class="p-2 mb-3 text-center text-white font-weight-bold post-button-mobile"
          @click="saveArticle"
        >
          保存する
        </h5>
        <h5
          class="m-0 p-2 text-center bg-white font-weight-bold draft-button-mobile"
          @click="unPublish"
        >
          非公開にする
        </h5>
      </template>
      <template v-else>
        <h5
          class="p-2 mb-3 text-center text-white font-weight-bold post-button"
          @click="saveArticle"
        >
          保存する
        </h5>
        <h5
          class="m-0 p-2 text-center bg-white font-weight-bold draft-button"
          @click="unPublish"
        >
          非公開にする
        </h5>
      </template>
    </template>

    <template v-if="state == 'draft'">
      <template v-if="isMobile">
        <h5
          class="p-2 mb-3 text-center text-white font-weight-bold post-button-mobile"
          @click="postArticle"
        >
          公開する
        </h5>
        <h5
          class="m-0 p-2 text-center bg-white font-weight-bold draft-button-mobile"
          @click="saveDraft"
        >
          保存する
        </h5>
      </template>
      <template v-else>
        <h5
          class="p-2 mb-3 text-center text-white font-weight-bold post-button"
          @click="postArticle"
        >
          公開する
        </h5>
        <h5
          class="m-0 p-2 text-center bg-white font-weight-bold draft-button"
          @click="saveDraft"
        >
          保存する
        </h5>
      </template>
    </template>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'SaveButton',
  props: {
    state: {
      type: String,
      default: 'published',
      required: true
    },
    country: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      article: {
        status: 'published',
      },
      isMobile: isMobile
    }
  },
  methods: {
    async saveArticle() {
      await this.$axios.patch(`articles/${this.$route.query.id}`, this.article)
        .catch(err => console.log(err.response))
      this.$router.push({
        name: 'ArticleShow',
        query: {id: this.$route.query.id}
      })
    },
    async postArticle() {
      this.article.created_at = new Date()
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
    async unPublish() {
      this.article.status = 'draft'
      this.article.created_at = new Date()
      await this.$axios.patch(`articles/${this.$route.query.id}`, this.article)
        .catch(err => console.log(err.response))
      this.$store.commit('pages/setCurrentPage', 'user')
      this.$router.push({ name: 'MyPage', params: { draft: true } })
    },
    saveDraft() {
      this.$router.push({ name: 'MyPage', params: { draft: true } })
    }
  }
}
</script>

<style scoped>
.post-button {
  background-color: #D95986;
  border: solid #D95986;
  cursor: pointer;
  border-radius: 6px;
}

.post-button:hover {
  background-color: #B14F71;
  border: solid #B14F71;
  position: relative;
}

.draft-button {
  color: #D95986;
  border: solid #D95986;
  border-radius: 6px;
  cursor: pointer;
}

.draft-button:hover {
  color: #B14F71;
  border: solid #B14F71;
  position: relative;
}

.post-button-mobile {
  background-color: #D95986;
  border: solid #D95986;
  cursor: pointer;
  border-radius: 6px;
}

.post-button-mobile:active {
  background-color: #B14F71;
  border: solid #B14F71;
  position: relative;
}

.draft-button-mobile {
  color: #D95986;
  border: solid #D95986;
  border-radius: 6px;
  cursor: pointer;
}

.draft-button-mobile:active {
  color: #B14F71;
  border: solid #B14F71;
  position: relative;
}
</style>
