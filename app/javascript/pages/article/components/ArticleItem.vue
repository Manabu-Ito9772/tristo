<template>
  <div class="col-12">
    <div class="card article-border">
      <div class="card-body pt-1 pb-2">
        <div class="d-flex align-items-center pb-1">
          <img
            src="../../../images/sample.png"
            class="user-icon"
          >
          <h5 class="card-title d-inline mb-0 pl-2 user-name">
            Manabu Ito
          </h5>
          <p class="text-muted mb-0 pt-4 article-date">
            {{ article.created_at | moment('M/D HH:mm') }}
          </p>
        </div>
        <div
          class="article-main"
          @click="showArticleDetail"
        >
          <h4 class="card-title m-2 article-title">
            {{ article.title }}
          </h4>
          <div class="row">
            <div class="col-sm-8">
              <p class="card-body bg-light mb-0 article-border article-info">
                {{ article.description }}
              </p>
              <div class="text-muted m-2 article-info">
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
                src="../../../images/sample.png"
                class="main-image"
              >
            </div>
          </div>
        </div>
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
  },
  data() {
    return {
      date: this.$moment().format()
    }
  },
  methods :{
    showArticleDetail() {
      this.$router.push({
        name: 'ArticleShow',
        params: {article : this.article}
      })
    },
  }
}
</script>

<style scoped>
.container-fluid {
  margin-right: auto;
  margin-left: auto;
  max-width: 700px;
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
  font-size: 12px;
}

.article-date {
  font-size: 12px;
  margin-left: auto;
}

.main-image {
  width: 100%;
  margin-bottom: 15px;
}

.word-break {
  word-break: break-all;
}
</style>
