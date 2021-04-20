<template>
  <div class="row">
    <template v-if="$mq == 'lg'">
      <div class="col-12">
        <ArticleItem
          :article="article"
          class="mt-4"
          @searchByTag="$listeners['searchByTag']"
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
</template>

<script>
import ArticleItem from './ArticleItem'

export default {
  name: 'ArticleList',
  components: {
    ArticleItem
  },
  props: {
    article: {
      type: Object,
      required: true
    }
  },
}
</script>

<style scoped>
</style>
