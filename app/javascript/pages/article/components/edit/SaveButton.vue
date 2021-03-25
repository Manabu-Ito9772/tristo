<template>
  <div class="mb-4">
    <h5
      class="p-2 mb-3 text-center text-white font-weight-bold post-button"
      @click="postArticle"
    >
      保存する
    </h5>
    <h5 class="p-2 text-center bg-white font-weight-bold draft-button">
      下書き保存
    </h5>
  </div>
</template>

<script>
export default {
  name: 'PostButton',
  data() {
    return {
      article: {
        status: 'published'
      },
    }
  },
  methods: {
    async postArticle() {
      await this.$axios.patch(`articles/${this.$route.query.id}`, this.article)
        .catch(err => console.log(err.response))
      this.$router.push({
        name: 'ArticleShow',
        query: {id: this.$route.query.id}
      })
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
