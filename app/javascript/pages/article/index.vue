<template>
  <div class="container-fluid mt-2">
    <template v-if="$mq == 'lg'">
      <div class="row">
        <ArticleList
          :articles="articles"
          class="col-8 mb-5"
        />
        <SearchColumn
          class="col-4"
        />
      </div>
    </template>

    <template v-else-if="$mq == 'sm'">
      <div class="row">
        <div class="col-12">
          <SearchColumn
            class="ml-5 mr-5 pl-5 pr-5"
          />
        </div>
        <div class="col-12">
          <ArticleList
            :articles="articles"
            class="mb-5 ml-5 mr-5 pl-5 pr-5"
          />
        </div>
      </div>
    </template>

    <template v-else>
      <div class="row">
        <SearchColumn
          class="col-12 mb-4"
        />
        <ArticleList
          :articles="articles"
          class="col-12 mb-5 bottom-border"
        />
      </div>
    </template>
  </div>
</template>

<script>
import ArticleList from './components/index/ArticleList'
import SearchColumn from './components/index/SearchColumn'

export default {
  name: 'ArticleIndex',
  components: {
    ArticleList,
    SearchColumn
  },
  data() {
    return {
      articles: [],
    }
  },
  created() {
    this.getArticles()
  },
  methods: {
    getArticles() {
      this.$axios.get('articles')
        .then(res => { this.articles = res.data })
        .catch(err => console.log(err.response))
    }
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 1000px;
  margin-right: auto;
  margin-left: auto;
}

.bottom-border {
  border-bottom: solid thin #CBCBCB;
}
</style>
