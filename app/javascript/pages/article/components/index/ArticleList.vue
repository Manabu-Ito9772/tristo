<template>
  <div>
    <div
      v-for="article in articles"
      :key="article.id"
      class="row"
    >
      <template v-if="$mq == 'lg'">
        <div class="col-12">
          <ArticleItem
            :article="article"
            class="mt-4"
          />
        </div>
      </template>
      <template v-else-if="$mq == 'sm'">
        <div class="col-12">
          <ArticleItem
            :article="article"
            class="mt-4"
          />
        </div>
      </template>
      <template v-else>
        <div class="col-12">
          <ArticleItem
            :article="article"
          />
        </div>
      </template>
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
