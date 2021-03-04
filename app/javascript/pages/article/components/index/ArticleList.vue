<template>
  <div class="container-fluid mt-4">
    <div
      v-for="article in articles"
      :key="article.id"
      class="row mt-3"
    >
      <ArticleItem
        :article="article"
      />
    </div>
  </div>
</template>

<script>
import ArticleItem from './ArticleItem'

export default {
  name: 'ArticleList',
  components: {
    ArticleItem
  },
  props: {
    articles: {
      type: Array,
      required: true
    }
  },
}
</script>

<style scoped>
.container-fluid {
  margin-right: auto;
  margin-left: auto;
  max-width: 800px;
}
</style>
