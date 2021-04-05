<template>
  <div class="mb-4">
    <template v-if="state == 'published'">
      <h5
        class="p-2 mb-3 text-center text-white font-weight-bold post-button"
        @click="saveArticle"
      >
        保存する
      </h5>
      <h5
        class="p-2 text-center bg-white font-weight-bold draft-button"
        @click="unPublish"
      >
        下書き状態にする
      </h5>
    </template>
    <template v-if="state == 'draft'">
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
    </template>
  </div>
</template>

<script>
export default {
  name: 'SaveButton',
  props: {
    state: {
      type: String,
      default: 'published',
      required: true
    }
  },
  data() {
    return {
      article: {
        status: 'published',
      },
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
