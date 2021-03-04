<template>
  <ArticleList :articles="articles" />
</template>

<script>
import ArticleList from './components/index/ArticleList'
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'ArticleIndex',
  components: {
    ArticleList,
  },
  computed: {
    ...mapGetters('articles', [
      'articles',
    ])
  },
  created() {
    this.getArticles()
  },
  methods: {
    ...mapActions('articles', [
      'getArticles',
    ])
  }
}
</script>

<style scoped>
</style>
