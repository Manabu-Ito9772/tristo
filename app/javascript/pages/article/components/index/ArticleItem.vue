<template>
  <div>
    <template v-if="$mq == 'xs'">
      <div class="row bg-white article-xs">
        <div class="col-12">
          <div class="row pt-4 pl-4 pr-4">
            <div class="col-12">
              <router-link :to="{ name: 'ArticleShow', query: {id: article.id} }">
                <h4 class="m-0 pt-1 pb-1 text-center text-white font-weight-bold article-title word-break">
                  {{ article.title }}
                </h4>
                <template v-if="article.description">
                  <p class="mt-3 mb-0 p-2 d-flex justify-content-center bg-light text-dark article-description word-break">
                    {{ article.description }}
                  </p>
                </template>
              </router-link>
            </div>
            <div class="col-12 m-0 pt-2 pb-0 text-center text-muted article-info word-break">
              <template v-if="article.country.name != '日本'">
                <p class="d-inline">
                  【{{ article.country.name }}】
                </p>
              </template>
              <p
                v-for="region in article.regions"
                :key="region.id"
                class="d-inline pl-1 pr-1"
              >
                {{ region.name }}
              </p>
              <template v-if="article.start_date && article.end_date">
                <p class="d-inline pl-1 pr-1">
                  {{ article.start_date | moment('M/D(ddd)') }}〜{{ article.end_date | moment('M/D(ddd)') }}
                </p>
              </template>
              <template v-else-if="article.start_date && !article.end_date">
                <p class="d-inline pl-1 pr-1">
                  {{ article.start_date | moment('M/D(ddd)') }}
                </p>
              </template>
              <template v-else-if="!article.start_date && article.end_date">
                <p class="d-inline pl-1 pr-1">
                  {{ article.end_date | moment('M/D(ddd)') }}
                </p>
              </template>
              <div class="d-flex justify-content-center">
                <p
                  v-for="article_tag in article.article_tags"
                  :key="article_tag.id"
                  class="m-0 pl-1 pr-1 text-primary"
                >
                  #{{ article_tag.tag.name }}
                </p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-12 pt-2 pl-4 pr-4">
          <img
            src="../../../../images/sample.png"
            class="main-image-xs m-0"
          >
        </div>
        <div class="col-12">
          <div class="pt-3 pb-3 d-flex justify-content-center align-items-center">
            <img
              src="../../../../images/sample.png"
              class="user-icon"
            >
            <h5 class="float-right mb-0 pl-3 word-break">
              Ito Manabua
            </h5>
            <div class="text-center pl-3">
              <font-awesome-icon
                :icon="['far', 'thumbs-up']"
                class="fa-lg"
              />
              <p class="m-0 word-break">
                100
              </p>
            </div>
          </div>
        </div>
      </div>
    </template>

    <template v-else>
      <div class="pl-3 pr-3">
        <div class="row mt-4 bg-white article">
          <div class="col-12">
            <div class="row pt-3 pl-3 pr-3">
              <div class="col-12">
                <router-link :to="{ name: 'ArticleShow', query: {id: article.id} }">
                  <h4 class="mb-0 pt-1 pb-1 text-center text-white font-weight-bold article-title word-break">
                    {{ article.title }}
                  </h4>
                  <template v-if="article.description">
                    <p class="mt-3 mb-0 p-2 d-flex justify-content-center bg-light text-dark article-description word-break">
                      {{ article.description }}
                    </p>
                  </template>
                </router-link>
              </div>
              <div class="col-12 mt-2 mb-2 text-muted word-break article-info">
                <div class="text-center text-muted word-break">
                  <template v-if="article.country.name != '日本'">
                    <p class="d-inline">
                      【{{ article.country.name }}】
                    </p>
                  </template>
                  <p
                    v-for="region in article.regions"
                    :key="region.id"
                    class="d-inline pl-1 pr-1 article-region"
                  >
                    {{ region.name }}
                  </p>
                  <template v-if="article.start_date && article.end_date">
                    <p class="d-inline pl-1 pr-1 article-date">
                      {{ article.start_date | moment('M/D(ddd)') }}〜{{ article.end_date | moment('M/D(ddd)') }}
                    </p>
                  </template>
                  <template v-else-if="article.start_date && !article.end_date">
                    <p class="d-inline pl-1 pr-1 article-date">
                      {{ article.start_date | moment('M/D(ddd)') }}
                    </p>
                  </template>
                  <template v-else-if="!article.start_date && article.end_date">
                    <p class="d-inline pl-1 pr-1 article-date">
                      {{ article.end_date | moment('M/D(ddd)') }}
                    </p>
                  </template>
                </div>
                <div class="d-flex justify-content-center">
                  <p
                    v-for="article_tag in article.article_tags"
                    :key="article_tag.id"
                    class="m-0 pl-1 pr-1 text-primary article-tag"
                  >
                    #{{ article_tag.tag.name }}
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="col-12">
            <img
              src="../../../../images/sample.png"
              class="main-image pt-3 pb-3"
            >
          </div>
          <div class="col-12">
            <div class="pt-1 pb-1 d-flex justify-content-center align-items-center user">
              <img
                src="../../../../images/sample.png"
                class="user-icon"
              >
              <h5 class="float-right mb-0 pl-3 word-break">
                Ito Manabua
              </h5>
              <div class="text-center pl-3">
                <font-awesome-icon
                  :icon="['far', 'thumbs-up']"
                  class="fa-lg"
                />
                <p class="m-0 word-break">
                  100
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  name: 'ArticleItem',
  props: {
    article: {
      type: Object,
      required: true
    }
  },
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.article {
  border: solid #FF00EB;
  border-radius: 6px;
}

.article-xs {
  border-top: solid thin #CBCBCB;
}

.article-title {
  background-color: #FF00EB;
  border-radius: 6px;
}

.article-description {
  border: solid thin #FF00EB;
  border-radius: 6px;
}

.article-info {
  font-size: 14px;
}

.article-date {
  font-size: 12px;
  margin-left: auto;
}

.main-image {
  width: 100%;
  border-top: solid thin #FF00EB;
}

.main-image-xs {
  width: 100%;
}

.user {
  border-top: solid thin #FF00EB;
}

.user-icon {
  width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 50%;
}
</style>
