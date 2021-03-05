<template>
  <div>
    <template v-if="$mq == 'xs'">
      <div class="row mt-4 bg-white article-xs">
        <div class="col-12">
          <router-link :to="{ name: 'ArticleShow', query: {id: article.id} }">
            <div class="row pt-3 pl-3 pr-3">
              <h4 class="col-12 m-0 pt-1 pb-1 text-center text-white font-weight-bold article-title word-break">
                {{ article.title }}
              </h4>
              <template v-if="article.description">
                <p class="col-12 mt-3 mb-0 p-2 d-flex justify-content-center bg-light text-dark article-description word-break">
                  {{ article.description }}
                </p>
              </template>
              <p class="col-12 m-0 pt-1 pb-1 text-center text-muted article-info word-break">
                {{ article.region.name }}&nbsp;
                日程：{{ article.start_date | moment('M/D(ddd)') }}〜{{ article.end_date | moment('M/D(ddd)') }}
              </p>
            </div>
          </router-link>
        </div>
        <div class="col-12">
          <img
            src="../../../../images/sample.png"
            class="main-image m-0 pt-3 pb-3"
          >
        </div>
        <div class="col-12">
          <div class="pt-1 pb-1 d-flex justify-content-center align-items-center">
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
            <router-link :to="{ name: 'ArticleShow', query: {id: article.id} }">
              <div class="row pt-3 pl-3 pr-3 ">
                <h4 class="col-12 m-0 pt-1 pb-1 text-center text-white font-weight-bold article-title word-break">
                  {{ article.title }}
                </h4>
                <template v-if="article.description">
                  <p class="col-12 mt-3 mb-0 p-2 d-flex justify-content-center bg-light text-dark article-description word-break">
                    {{ article.description }}
                  </p>
                </template>
                <p class="col-12 m-0 pt-1 pb-1 text-center text-muted article-info word-break">
                  {{ article.region.name }}&nbsp;
                  日程：{{ article.start_date | moment('M/D(ddd)') }}〜{{ article.end_date | moment('M/D(ddd)') }}
                </p>
              </div>
            </router-link>
          </div>
          <div class="col-12">
            <img
              src="../../../../images/sample.png"
              class="main-image m-0 pt-3 pb-3"
            >
          </div>
          <div class="col-12">
            <div class="pt-1 pb-1 d-flex justify-content-center align-items-center">
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
import ArticleItem from './ArticleItem'

export default {
  name: 'ArticleItem',
  props: {
    article: {
      type: Object,
      required: true
    }
  }
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
  border-bottom: solid thin #CBCBCB;
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
  border-bottom: solid thin #FF00EB;
}

.article-date {
  font-size: 12px;
  margin-left: auto;
}

.main-image {
  width: 100%;
  border-bottom: solid thin #FF00EB;
}

.user-icon {
  width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 50%;
}
</style>
