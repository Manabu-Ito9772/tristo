<template>
  <div class="col-12">
    <div class="card article-border">
      <div class="card-body pt-1 pb-2">
        <div class="d-flex align-items-center pb-1">
          <img
            src="../../../../images/sample.png"
            class="user-icon"
          >
          <h5 class="card-title d-inline mb-0 pl-2 word-break">
            Manabu Ito
          </h5>
          <p class="text-muted mb-0 pt-4 article-date">
            {{ article.created_at | moment('M/D HH:mm') }}
          </p>
        </div>
        <router-link :to="{ name: 'ArticleShow', query: {id: article.id} }">
          <div class="article-main">
            <h4 class="card-title m-2 article-title word-break">
              {{ article.title }}
            </h4>
            <div class="row">
              <div class="col-sm-8">
                <template v-if="article.description">
                  <p class="card-body bg-light mb-0 p-2 article-border word-break">
                    {{ article.description }}
                  </p>
                </template>
                <div class="text-muted m-2 article-info word-break">
                  <p class="d-inline">
                    {{ article.region.name }}
                  </p>
                  <p class="d-inline ml-2">
                    日程：{{ article.start_date | moment('M/D(ddd)') }}〜{{ article.end_date | moment('M/D(ddd)') }}
                  </p>
                </div>
              </div>
              <div class="col-sm-4">
                <img
                  src="../../../../images/sample.png"
                  class="main-image"
                >
              </div>
            </div>
          </div>
        </router-link>
        <div class="pt-2 pr-2 text-right">
          <font-awesome-icon
            :icon="['far', 'thumbs-up']"
            class="fa-lg"
          />
          <p class="d-inline">
            100
          </p>
        </div>
      </div>
    </div>
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
.container-fluid {
  margin-right: auto;
  margin-left: auto;
  max-width: 700px;
}

.word-break {
  word-break: break-word;
}
.user-icon {
  width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 50%;
}

.article-main {
  border-top: solid thin #FF00EB;
  border-bottom: solid thin #FF00EB;
  cursor: pointer;
}

.article-title {
  font-weight: bold;
}

.article-border {
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
  margin-bottom: 15px;
}
</style>
