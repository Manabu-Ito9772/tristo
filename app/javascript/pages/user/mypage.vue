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
                <div class="d-flex justify-content-center align-items-center">
                  <h4 class="mb-0 pr-3 text-dark font-weight-bold word-break">
                    {{ authUser.name }}
                  </h4>
                  <router-link
                    :to="{ name: 'EditMyPage' }"
                  >
                    <button class="btn text-muted button">
                      編集
                    </button>
                  </router-link>
                </div>

                <div class="mt-2 d-flex justify-content-center text-muted">
                  <template v-if="articleLength != null">
                    <div class="pr-3 text-center">
                      <p class="m-0 font-small">
                        投稿
                      </p>
                      <p class="m-0 word-break">
                        {{ articleLength }}
                      </p>
                    </div>
                  </template>

                  <template v-if="followings != null">
                    <div
                      class="pl-4 pr-4 text-center pointer"
                      @click="toFollowingPage"
                    >
                      <p class="m-0 font-small">
                        フォロー
                      </p>
                      <p class="m-0 word-break">
                        {{ followings }}
                      </p>
                    </div>
                  </template>

                  <template v-if="followers != null">
                    <div
                      class="text-center pointer"
                      @click="toFollowerPage"
                    >
                      <p class="m-0 font-small">
                        フォロワー
                      </p>
                      <p class="m-0 word-break">
                        {{ followers }}
                      </p>
                    </div>
                  </template>
                </div>
              </div>
            </div>
            <template v-if="authUser.description">
              <p class="mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro break-line remove-first-line">
                {{ authUser.description }}
              </p>
            </template>
          </div>
        </div>

        <div class="col-12 mt-3 mb-3">
          <div class="row">
            <template v-if="published">
              <div class="col-4">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  投稿
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showDrafts"
                >
                  下書き
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showFavorites"
                >
                  いいね
                </h5>
              </div>
            </template>

            <template v-if="draft">
              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showPublished"
                >
                  投稿
                </h5>
              </div>

              <div class="col-4">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  下書き
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showFavorites"
                >
                  いいね
                </h5>
              </div>
            </template>

            <template v-if="favorite">
              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showPublished"
                >
                  投稿
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showDrafts"
                >
                  下書き
                </h5>
              </div>

              <div class="col-4">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  いいね
                </h5>
              </div>
            </template>
          </div>
        </div>

        <template v-if="published">
          <template v-if="publishedArticles.length">
            <div class="col-12 mb-5">
              <div
                v-for="article in publishedArticles"
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

        <template v-if="draft">
          <template v-if="draftArticles.length">
            <div class="col-12 mb-5">
              <div
                v-for="article in draftArticles"
                :key="article.id"
              >
                <ArticleItem
                  :article="article"
                />
              </div>
            </div>
          </template>

          <template v-if="noDraft">
            <div class="col-12 mt-3 mb-5">
              <h3 class="text-center font-weight-bold text-secondary">
                下書きがありません
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
                <div class="d-flex justify-content-center align-items-center">
                  <h3 class="mb-0 pr-3 text-dark font-weight-bold word-break">
                    {{ authUser.name }}
                  </h3>
                  <router-link
                    :to="{ name: 'EditMyPage' }"
                  >
                    <button class="btn text-muted button">
                      編集
                    </button>
                  </router-link>
                </div>

                <div class="mt-2 d-flex justify-content-center text-muted">
                  <template v-if="articleLength != null">
                    <div class="pr-3 text-center">
                      <p class="m-0">
                        投稿
                      </p>
                      <p class="m-0 word-break">
                        {{ articleLength }}
                      </p>
                    </div>
                  </template>

                  <template v-if="followings != null">
                    <div
                      id="following-count"
                      class="pl-4 pr-4 text-center pointer"
                      @click="toFollowingPage"
                    >
                      <p class="m-0">
                        フォロー
                      </p>
                      <p class="m-0 word-break">
                        {{ followings }}
                      </p>
                    </div>
                  </template>

                  <template v-if="followers != null">
                    <div
                      id="followers-count"
                      class="text-center pointer"
                      @click="toFollowerPage"
                    >
                      <p class="m-0">
                        フォロワー
                      </p>
                      <p class="m-0 word-break">
                        {{ followers }}
                      </p>
                    </div>
                  </template>
                </div>
              </div>
            </div>
            <template v-if="authUser.description">
              <p class="ml-4 mr-4 mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro break-line remove-first-line">
                {{ authUser.description }}
              </p>
            </template>
          </div>
        </div>

        <div class="col-12 mt-3 mb-3 p-0">
          <div class="row">
            <template v-if="published">
              <div class="col-4">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  投稿
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showDrafts"
                >
                  下書き
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showFavorites"
                >
                  いいね
                </h5>
              </div>
            </template>

            <template v-if="draft">
              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showPublished"
                >
                  投稿
                </h5>
              </div>

              <div class="col-4">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  下書き
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showFavorites"
                >
                  いいね
                </h5>
              </div>
            </template>

            <template v-if="favorite">
              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showPublished"
                >
                  投稿
                </h5>
              </div>

              <div class="col-4">
                <h5
                  class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                  @click="showDrafts"
                >
                  下書き
                </h5>
              </div>

              <div class="col-4">
                <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                  いいね
                </h5>
              </div>
            </template>
          </div>
        </div>

        <template v-if="published">
          <template v-if="publishedArticles.length">
            <div class="col-12 p-0">
              <div
                v-for="article in publishedArticles"
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

        <template v-if="draft">
          <template v-if="draftArticles.length">
            <div class="col-12 p-0">
              <div
                v-for="article in draftArticles"
                :key="article.id"
              >
                <ArticleItem
                  :article="article"
                  class="mb-4"
                />
              </div>
            </div>
          </template>

          <template v-if="noDraft">
            <div class="col-12 mt-3 mb-5">
              <h3 class="text-center font-weight-bold text-secondary">
                下書きがありません
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
import { mapGetters } from 'vuex'

export default {
  name: 'MyPage',
  components: {
    ArticleItem
  },
  data() {
    return {
      followings: null,
      followers: null,
      articleLength: null,
      publishedArticles: [],
      draftArticles: [],
      published: true,
      draft: false,
      favorite: false,
      noPublished: false,
      noDraft: false,
      noFavorites: false,
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  created() {
    this.getCurrentUserArticles()
    if (this.$route.params['draft']) {
      this.showDrafts()
    }
  },
  methods: {
    getCurrentUserArticles() {
      this.$axios.get(`users/${this.authUser.id}`)
        .then(res => {
          this.followings = res.data.followings.length
          this.followers = res.data.followers.length
          for (let article of res.data.ordered_articles) {
            if (article.status == 'published') {
              this.publishedArticles.push(article)
            } else {
              this.draftArticles.push(article)
            }
          }
          if (!this.publishedArticles.length) {
            this.noPublished = true
          }
          if (!this.draftArticles.length) {
            this.noDraft = true
          }
          this.articleLength = this.publishedArticles.length
        })
        .catch(err => console.log(err.response))
    },
    toFollowingPage() {
      this.$router.push({ name: 'Following' })
    },
    toFollowerPage() {
      this.$router.push({ name: 'Followers' })
    },
    showFavorites() {
      this.published = false
      this.draft = false
      this.favorite = true
    },
    showDrafts() {
      this.published = false
      this.favorite = false
      this.draft = true
    },
    showPublished() {
      this.favorite = false
      this.draft = false
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

.button {
  white-space: nowrap;
  border-radius: 20px;
  background-color: #D8D8D8;
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

.pointer {
  cursor: pointer;
}

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}
</style>
