<template>
  <div class="pt-2 pl-2 pr-2 bg-white whole-border">
    <h5 class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
      タイトル
    </h5>
    <p class="d-flex justify-content-center text-dark word-break">
      {{ article.title }}
    </p>

    <template v-if="article.description">
      <h5 class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title">
        説明
      </h5>
      <p class="mb-3 pb-2 pl-2 pr-2 text-dark word-break break-line remove-first-line">
        {{ article.description }}
      </p>
    </template>

    <template v-if="article.country.name == '日本'">
      <h5 class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        都道府県
      </h5>
      <div class="mb-3 text-center">
        <p
          v-for="region in article.regions"
          :key="region.id"
          class="d-inline text-dark pl-1 pr-1"
        >
          {{ region.name }}
        </p>
      </div>
    </template>
    <template v-else>
      <h5 class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        国と地域
      </h5>
      <div class="mb-3 text-center">
        <p class="d-inline text-dark">
          【{{ article.country.name }}】
        </p>
        <p
          v-for="region in article.regions"
          :key="region.id"
          class="d-inline text-dark pl-1 pr-1"
        >
          {{ region.name }}
        </p>
      </div>
    </template>

    <template v-if="article.start_date || article.end_date">
      <h5 class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        日程
      </h5>
      <template v-if="article.start_date && article.end_date">
        <template v-if="article.start_date == article.end_date">
          <p class="text-center text-dark">
            {{ article.start_date | moment('M/D(ddd)') }}
          </p>
        </template>
        <template v-else>
          <p class="text-center text-dark">
            {{ article.start_date | moment('M/D(ddd)') }}&nbsp;〜&nbsp;{{ article.end_date | moment('M/D(ddd)') }}
          </p>
        </template>
      </template>
      <template v-if="article.start_date && !article.end_date">
        <p class="text-center text-dark">
          {{ article.start_date | moment('M/D(ddd)') }}
        </p>
      </template>
      <template v-if="!article.start_date && article.end_date">
        <p class="text-center text-dark">
          {{ article.end_date | moment('M/D(ddd)') }}
        </p>
      </template>
    </template>

    <template v-if="article.article_tags.length">
      <h5 class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        タグ
      </h5>
      <div class="mb-3 text-center">
        <p
          v-for="article_tag in article.article_tags"
          :key="article_tag.id"
          class="d-inline text-dark pl-1 pr-1"
        >
          #{{ article_tag.tag.name }}
        </p>
      </div>
    </template>

    <template v-if="article.map">
      <h5 class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        マップ
      </h5>
      <a
        :href="article.map"
        target="_blank"
        class="d-block pb-3 pl-2 pr-2 word-break"
      >
        {{ article.map }}
      </a>
    </template>

    <div class="text-center">
      <p
        class="btn d-inline-block pt-1 pb-1 pl-4 pr-4 mt-2 font-weight-bold edit-button"
        @click="showOverviewEdit"
      >
        編集
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PreviewOverview',
  props: {
    article: {
      type: Object,
      required: true
    },
  },
  data() {
    return {
      countryName: '',
    }
  },
  methods:{
    showOverviewEdit() {
      this.$emit('showOverviewEdit', this.article)
    },
  }
}
</script>

<style scoped>
.whole-border {
  border: solid #CBCBCB;
  border-radius: 6px;
}

.word-break {
  word-break: break-word;
}

.sidebar_fixed {
  position: sticky;
  top: 100px;
}

.article-title {
  background-color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.description-label {
  background-color: #6A6A6A;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.description-main {
  font-size: 14px;
  border: solid thin #6A6A6A;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
  border-width: 0px 0.1px 0.1px 0.1px;
}

.article-info {
  font-size: 13px;
}

.edit-button {
  color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}
</style>
