<template>
  <div>
    <div
      v-for="article in articles"
      :key="article.id"
      class="row"
    >
      <div class="col-12">
        <ArticleItem
          :article="article"
        />
      </div>
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
</style>
