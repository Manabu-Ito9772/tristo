<template>
  <div class="container-fluid mt-2">
    <template v-if="$mq == 'lg'">
      <div class="row">
        <ArticleList
          :articles="articles"
          class="col-8"
        />
        <SearchColumn
          class="col-4"
        />
      </div>
    </template>
    <template v-else>
      <div class="row">
        <SearchColumn
          class="col-12"
        />
        <ArticleList
          :articles="articles"
          class="col-12"
        />
      </div>
    </template>
  </div>
</template>

<script>
import ArticleList from './components/index/ArticleList'
import SearchColumn from './components/index/SearchColumn'
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'ArticleIndex',
  components: {
    ArticleList,
    SearchColumn
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
.container-fluid {
  max-width: 1000px;
  margin-right: auto;
  margin-left: auto;
}
</style>
