<template>
  <div class="container-fluid d-flex justify-content-center mt-4">
    <template v-if="$mq == 'xs'">
      <div class="row">
        <div class="col-12 mt-3">
          <div class="m-0">
            <div class="pb-3 d-flex justify-content-center align-items-center">
              <img
                src="../../images/sample.png"
                class="user-icon mr-4"
              >
              <div>
                <div class="d-flex justify-content-center">
                  <h4 class="mb-0 pr-3 text-dark font-weight-bold word-break">
                    {{ user.name }}
                  </h4>
                </div>

                <div class="mt-2 d-flex justify-content-between text-muted">
                  <div class="text-center">
                    <p class="m-0 word-unbreak font-small">
                      投稿
                    </p>
                    <p class="m-0 word-break">
                      20
                    </p>
                  </div>
                  <div class="pl-4 pr-4 text-center">
                    <p class="m-0 font-small">
                      フォロー
                    </p>
                    <p class="m-0 word-break">
                      20
                    </p>
                  </div>
                  <div class="text-center">
                    <p class="m-0 font-small">
                      フォロワー
                    </p>
                    <p class="m-0 word-break">
                      20
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <template v-if="user.description">
              <p class="mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro">
                {{ user.description }}
              </p>
            </template>
          </div>
        </div>

        <div class="col-12 mt-3 mb-3">
          <div class="row">
            <template v-if="published">
              <div class="col-6 pr-2">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  投稿
                </h5>
              </div>

              <div class="col-6 pl-2">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showFavorites"
                >
                  いいね
                </h5>
              </div>
            </template>

            <template v-if="favorite">
              <div class="col-6 pr-2">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showPublished"
                >
                  投稿
                </h5>
              </div>

              <div class="col-6 pl-2">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  いいね
                </h5>
              </div>
            </template>
          </div>
        </div>

        <template v-if="published">
          <template v-if="articles.length">
            <div class="col-12 mb-5">
              <div
                v-for="article in articles"
                :key="article.id"
              >
                <ArticleItem
                  :article="article"
                />
              </div>
            </div>
          </template>

          <template v-if="noPublished">
            <div class="col-12 mt-3 mb-5">
              <h3 class="text-center font-weight-bold text-secondary">
                投稿がありません
              </h3>
            </div>
          </template>
        </template>
      </div>
    </template>

    <template v-else>
      <div class="row column-width">
        <div class="col-12 mt-3 p-0">
          <div class="m-0">
            <div class="pb-3 d-flex justify-content-center align-items-center">
              <img
                src="../../images/sample.png"
                class="user-icon mr-4"
              >
              <div>
                <div class="d-flex justify-content-center">
                  <h3 class="mb-0 pr-3 text-dark font-weight-bold word-break">
                    {{ user.name }}
                  </h3>
                </div>

                <div class="mt-2 d-flex justify-content-between text-muted">
                  <div class="text-center">
                    <p class="m-0">
                      投稿
                    </p>
                    <p class="m-0 word-break">
                      20
                    </p>
                  </div>
                  <div class="pl-4 pr-4 text-center">
                    <p class="m-0">
                      フォロー
                    </p>
                    <p class="m-0 word-break">
                      20
                    </p>
                  </div>
                  <div class="text-center">
                    <p class="m-0">
                      フォロワー
                    </p>
                    <p class="m-0 word-break">
                      20
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <template v-if="user.description">
              <p class="ml-4 mr-4 mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro">
                {{ user.description }}
              </p>
            </template>
          </div>
        </div>

        <div class="col-12 mt-3 mb-3 p-0">
          <div class="row">
            <template v-if="published">
              <div class="col-6 pr-2">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  投稿
                </h5>
              </div>

              <div class="col-6 pl-2">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showFavorites"
                >
                  いいね
                </h5>
              </div>
            </template>

            <template v-if="favorite">
              <div class="col-6 pr-2">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showPublished"
                >
                  投稿
                </h5>
              </div>

              <div class="col-6 pl-2">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  いいね
                </h5>
              </div>
            </template>
          </div>
        </div>

        <template v-if="published">
          <template v-if="articles.length">
            <div class="col-12 p-0">
              <div
                v-for="article in articles"
                :key="article.id"
              >
                <ArticleItem
                  :article="article"
                  class="mb-4"
                />
              </div>
            </div>
          </template>

          <template v-if="noPublished">
            <div class="col-12 mt-3 mb-5">
              <h3 class="text-center font-weight-bold text-secondary">
                投稿がありません
              </h3>
            </div>
          </template>
        </template>
      </div>
    </template>
  </div>
</template>

<script>
import ArticleItem from '../article/components/index/ArticleItem'

export default {
  name: 'UserShow',
  components: {
    ArticleItem
  },
  data() {
    return {
      user: {},
      articles: [],
      published: true,
      favorite: false,
      noPublished: false,
      noFavorites: false,
    }
  },
  created() {
    this.getUserAndArticles()
  },
  methods: {
    async getUserAndArticles() {
      await this.$axios.get(`users/${this.$route.query.id}`)
        .then(res => this.user = res.data)
        .catch(err => console.log(err.response))
      await this.$axios.get(`articles/${this.$route.query.id}/user_articles`)
        .then(res => {
          for (let article of res.data) {
            if (article.status == 'published') {
              this.articles.push(article)
            }
          }
        })
        .catch(err => console.log(err.response))
      if (!this.articles.length) {
        this.noPublished = true
      }
    },
    showFavorites() {
      this.published = false
      this.favorite = true
    },
    showPublished() {
      this.favorite = false
      this.published = true
    }
  }
}
</script>

<style scoped>
.column-width {
  max-width: 500px;
}

.word-break {
  word-break: break-word;
}

.word-unbreak {
  white-space: nowrap;
}

.font-small {
  font-size: 13px;
}

.user-icon {
  width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
}

.self-intro {
  border-top: solid thin #FF00EB;
}

.post-changer {
  border: solid #6A6A6A;
  background-color: #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}

.post-changer-unselect {
  color: #6A6A6A;
  border: solid #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}
</style>
