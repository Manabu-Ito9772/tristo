<template>
  <div class="mb-4">
    <h5
      class="p-2 mb-3 text-center text-white font-weight-bold post-button"
      @click="postArticle"
    >
      投稿する
    </h5>
    <h5
      class="p-2 text-center bg-white font-weight-bold draft-button"
      @click="saveDraft"
    >
      下書き保存
    </h5>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

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
    }
  },
  methods: {
    ...mapActions('articles', [
      'getArticlesJapan',
      'getArticlesWorld',
    ]),
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
  background-color: #FF00EB;
  border-radius: 6px;
  cursor: pointer;
}

.draft-button {
  border: solid #FF00EB;
  color: #FF00EB;
  border-radius: 6px;
  cursor: pointer;
}
</style>
