<template>
  <div class="pt-2 pl-2 pr-2 bg-white whole-border">
    <p class="col-12 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
      タイトル
    </p>
    <p class="d-flex justify-content-center text-dark word-break">
      {{ article.title }}
    </p>

    <template v-if="article.country.name == '日本'">
      <p class="col-12 mt-4 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        都道府県
      </p>
      <div class="text-center">
        <p
          v-for="article_region in article.article_regions"
          :key="article_region.id"
          class="d-inline text-dark pl-1 pr-1"
        >
          {{ article_region.region.name }}
        </p>
      </div>
    </template>

    <template v-else>
      <p class="col-12 mt-4 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        国と地域
      </p>
      <div class="text-center">
        <p class="d-inline text-dark">
          【{{ article.country.name }}】
        </p>
        <p
          v-for="article_region in article.article_regions"
          :key="article_region.id"
          class="d-inline text-dark pl-1 pr-1"
        >
          {{ article_region.region.name }}
        </p>
      </div>
    </template>

    <template v-if="article.start_date || article.end_date">
      <p class="col-12 mt-4 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        期間
      </p>
      <template v-if="article.start_date && article.end_date">
        <template v-if="article.start_date == article.end_date">
          <p class="text-center text-dark">
            {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
          </p>
        </template>
        <template v-else>
          <p class="text-center text-dark">
            {{ article.start_date | moment('YYYY年 M/D(ddd)') }}&nbsp;〜&nbsp;{{ article.end_date | moment('M/D(ddd)') }}
          </p>
        </template>
      </template>
      <template v-if="article.start_date && !article.end_date">
        <p class="text-center text-dark">
          {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
        </p>
      </template>
      <template v-if="!article.start_date && article.end_date">
        <p class="text-center text-dark">
          {{ article.end_date | moment('YYYY年 M/D(ddd)') }}
        </p>
      </template>
    </template>

    <template v-if="article.description">
      <p class="col-12 mt-4 mb-1 p-1 text-center text-white font-weight-bold article-title">
        コメント
      </p>
      <p class="pl-2 pr-2 text-dark word-break break-line remove-first-line">
        {{ article.description }}
      </p>
    </template>

    <template v-if="article.eyecatch_url">
      <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
        アイキャッチ
      </p>
      <div class="text-center">
        <div class="mb-2 image-trim">
          <img :src="article.eyecatch_url">
        </div>
      </div>
    </template>

    <template v-if="article.article_tags.length">
      <p class="col-12 mt-4 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        タグ
      </p>
      <div class="text-center">
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
      <p class="col-12 mt-4 mb-1 p-1 text-center text-white font-weight-bold article-title word-break">
        マップ
      </p>
      <a
        :href="article.map"
        target="_blank"
        class="d-block pl-2 pr-2 word-break"
      >
        {{ article.map }}
      </a>
    </template>

    <div class="text-center">
      <template v-if="isMobile">
        <p
          class="d-inline-block pt-1 pb-1 pl-4 pr-4 mt-4 mb-4 font-weight-bold edit-button-mobile"
          @click="showOverviewEdit"
        >
          編集
        </p>
      </template>
      <template v-else>
        <p
          class="d-inline-block pt-1 pb-1 pl-4 pr-4 mt-4 mb-4 font-weight-bold edit-button"
          @click="showOverviewEdit"
        >
          編集
        </p>
      </template>
    </div>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect'

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
      isMobile: isMobile
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
  background-color: gray;
  border-radius: 4px;
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

.image-trim {
  position: relative;
  overflow: hidden;
  padding-top: 60%;
}

.image-trim img {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 4px;
}

.edit-button {
  color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}

.edit-button:hover {
  color: #383838;
  border: solid thin #383838;
}

.edit-button-mobile {
  color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}

.edit-button-mobile:active {
  color: #383838;
  border: solid thin #383838;
}
</style>
