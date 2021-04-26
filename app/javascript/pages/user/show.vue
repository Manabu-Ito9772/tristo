<template>
  <div class="container-fluid d-flex justify-content-center mt-4">
    <template v-if="$mq == 'xs'">
      <template v-if="numOfArticles != null">
        <div class="row">
          <div class="col-12 mt-3">
            <div class="m-0">
              <div class="pb-3 d-flex justify-content-center align-items-center">
                <div>
                  <template v-if="user.avatar_url">
                    <img
                      :src="user.avatar_url"
                      class="user-icon mr-4"
                    >
                  </template>
                  <template v-else>
                    <img
                      src="~default.jpg"
                      class="user-icon mr-4"
                    >
                  </template>
                </div>
                <div>
                  <div class="d-flex justify-content-center align-items-center">
                    <h4 class="mb-0 pr-3 text-dark font-weight-bold word-break">
                      {{ user.name }}
                    </h4>
                    <template v-if="authUser">
                      <template v-if="notFollowing">
                        <div
                          class="bg-white font-weight-bold follow-button"
                          @click="followUser"
                        >
                          フォロー
                        </div>
                      </template>
                      <template v-if="following">
                        <div
                          class="text-white font-weight-bold unfollow-button"
                          @click="unfollowUser"
                        >
                          フォロー中
                        </div>
                      </template>
                    </template>
                  </div>

                  <div class="mt-2 d-flex justify-content-center text-muted">
                    <div class="pr-3 text-center">
                      <p class="m-0 word-unbreak font-small">
                        投稿
                      </p>
                      <template v-if="numOfArticles != null">
                        <p class="m-0 word-break">
                          {{ numOfArticles }}
                        </p>
                      </template>
                      <template v-else>
                        <p class="m-0 word-break invisible">
                          NaN
                        </p>
                      </template>
                    </div>

                    <div
                      class="pl-4 pr-4 text-center pointer"
                      @click="toFollowingPage"
                    >
                      <p class="m-0 font-small">
                        フォロー
                      </p>
                      <template v-if="followings != null">
                        <p class="m-0 word-break">
                          {{ followings }}
                        </p>
                      </template>
                      <template v-else>
                        <p class="m-0 word-break invisible">
                          NaN
                        </p>
                      </template>
                    </div>

                    <div
                      class="text-center pointer"
                      @click="toFollowerPage"
                    >
                      <p class="m-0 font-small">
                        フォロワー
                      </p>
                      <template v-if="followers != null">
                        <p class="m-0 word-break">
                          {{ followers }}
                        </p>
                      </template>
                      <template v-else>
                        <p class="m-0 word-break invisible">
                          NaN
                        </p>
                      </template>
                    </div>
                  </div>
                </div>
              </div>
              <template v-if="user.description">
                <p class="mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro break-line remove-first-line">
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
                  <template v-if="presence || !loading">
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                      @click="showFavorites"
                    >
                      いいね
                    </h5>
                  </template>
                  <template v-else>
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                    >
                      いいね
                    </h5>
                  </template>
                </div>
              </template>

              <template v-if="favorite">
                <div class="col-6 pr-2">
                  <template v-if="presence || !loading">
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                      @click="showPublished"
                    >
                      投稿
                    </h5>
                  </template>
                  <template v-else>
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                    >
                      投稿
                    </h5>
                  </template>
                </div>

                <div class="col-6 pl-2">
                  <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                    いいね
                  </h5>
                </div>
              </template>
            </div>
          </div>

          <template v-if="articles.length">
            <div class="col-12 border-top">
              <div
                v-for="article in articles"
                :key="article.id"
              >
                <ArticleItem
                  :article="article"
                />
              </div>
              <template v-if="page <= kaminariPage">
                <infinite-loading
                  spinner="circles"
                  class="mb-4"
                  @infinite="infiniteHandler"
                />
              </template>
            </div>
          </template>

          <template v-else>
            <template v-if="loading">
              <div class="col-12 mt-4 mb-5">
                <vue-loading
                  type="spiningDubbles"
                  color="#FF58F2"
                  :size="{ width: '80px' }"
                />
              </div>
            </template>
            <template v-else>
              <div class="col-12 mt-5 mb-5">
                <h5 class="text-center font-weight-bold text-secondary">
                  <template v-if="published">
                    投稿がありません
                  </template>
                  <template v-else>
                    いいねした投稿がありません
                  </template>
                </h5>
              </div>
            </template>
          </template>
        </div>
      </template>
    </template>

    <template v-else>
      <template v-if="numOfArticles != null">
        <div class="row column-width">
          <div class="col-12 mt-3 p-0">
            <div class="m-0">
              <div class="pb-3 d-flex justify-content-center align-items-center">
                <div>
                  <template v-if="user.avatar_url">
                    <img
                      :src="user.avatar_url"
                      class="user-icon mr-4"
                    >
                  </template>
                  <template v-else>
                    <img
                      id="default-avatar"
                      src="~default.jpg"
                      class="user-icon mr-4"
                    >
                  </template>
                </div>
                <div>
                  <div class="d-flex justify-content-center align-items-center">
                    <h3 class="mb-0 pr-3 text-dark font-weight-bold word-break">
                      {{ user.name }}
                    </h3>
                    <template v-if="authUser">
                      <template v-if="notFollowing">
                        <div
                          class="bg-white font-weight-bold follow-button"
                          @click="followUser"
                        >
                          フォロー
                        </div>
                      </template>
                      <template v-if="following">
                        <div
                          class="text-white font-weight-bold unfollow-button"
                          @click="unfollowUser"
                        >
                          フォロー中
                        </div>
                      </template>
                    </template>
                  </div>

                  <div class="mt-2 d-flex justify-content-center text-muted">
                    <div class="pr-3 text-center">
                      <p class="m-0">
                        投稿
                      </p>
                      <template v-if="numOfArticles != null">
                        <p class="m-0 word-break">
                          {{ numOfArticles }}
                        </p>
                      </template>
                      <template v-else>
                        <p class="m-0 word-break">
                          NaN
                        </p>
                      </template>
                    </div>

                    <div
                      id="following-count"
                      class="pl-4 pr-4 text-center pointer"
                      @click="toFollowingPage"
                    >
                      <p class="m-0">
                        フォロー
                      </p>
                      <template v-if="followings != null">
                        <p class="m-0 word-break">
                          {{ followings }}
                        </p>
                      </template>
                      <template v-else>
                        <p class="m-0 word-break">
                          NaN
                        </p>
                      </template>
                    </div>

                    <div
                      id="followers-count"
                      class="text-center pointer"
                      @click="toFollowerPage"
                    >
                      <p class="m-0">
                        フォロワー
                      </p>
                      <template v-if="followers != null">
                        <p class="m-0 word-break">
                          {{ followers }}
                        </p>
                      </template>
                      <template v-else>
                        <p class="m-0 word-break">
                          NaN
                        </p>
                      </template>
                    </div>
                  </div>
                </div>
              </div>
              <template v-if="user.description">
                <p class="ml-4 mr-4 mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro break-line remove-first-line">
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
                  <template v-if="presence || !loading">
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                      @click="showFavorites"
                    >
                      いいね
                    </h5>
                  </template>
                  <template v-else>
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                    >
                      いいね
                    </h5>
                  </template>
                </div>
              </template>

              <template v-if="favorite">
                <div class="col-6 pr-2">
                  <template v-if="presence || !loading">
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                      @click="showPublished"
                    >
                      投稿
                    </h5>
                  </template>
                  <template v-else>
                    <h5
                      class="p-1 m-0 text-center font-weight-bold post-changer-unselect"
                    >
                      投稿
                    </h5>
                  </template>
                </div>

                <div class="col-6 pl-2">
                  <h5 class="p-1 m-0 text-center text-white font-weight-bold post-changer">
                    いいね
                  </h5>
                </div>
              </template>
            </div>
          </div>

          <template v-if="articles.length">
            <div class="col-12 mb-5 p-0">
              <div
                v-for="article in articles"
                :key="article.id"
              >
                <ArticleItem
                  :article="article"
                  class="mb-4"
                />
              </div>
              <infinite-loading
                spinner="circles"
                @infinite="infiniteHandler"
              />
            </div>
          </template>

          <template v-else>
            <template v-if="loading">
              <div class="col-12 mt-5 mb-5">
                <vue-loading
                  type="spiningDubbles"
                  color="#FF58F2"
                  :size="{ width: '100px' }"
                />
              </div>
            </template>

            <template v-else>
              <div class="col-12 mt-5 pt-3 mb-5">
                <h3 class="text-center font-weight-bold text-secondary">
                  <template v-if="published">
                    投稿がありません
                  </template>
                  <template v-else>
                    いいねした投稿がありません
                  </template>
                </h3>
              </div>
            </template>
          </template>
        </div>
      </template>
    </template>
  </div>
</template>

<script>
import 'default.jpg'
import ArticleItem from '../article/components/index/ArticleItem'
import { mapGetters } from 'vuex'

export default {
  name: 'UserShow',
  components: {
    ArticleItem
  },

  data() {
    return {
      user: {},
      followings: null,
      followers: null,
      numOfArticles: null,
      published: true,
      favorite: false,
      following: null,
      notFollowing: null,
      articles: [],
      url: null,
      page: 1,
      kaminariPage: null,
      loading: true,
      presence: false
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  watch: {
    articles() {
      if (this.articles.length) {
        this.presence = true
      } else {
        this.presence = false
      }
    }
  },
  created() {
    this.getUserInfo()
    this.checkFollowOrNot()
    this.getFollowCount()
    this.getNumOfArticles()
    this.infiniteHandler()
  },
  methods: {
    getUserInfo() {
      this.$axios.get(`users/${this.$route.query.id}`)
        .then(res => {
          this.user = res.data
        })
        .catch(err => console.log(err.response))
    },
    checkFollowOrNot() {
      this.$axios.get(`relationships/${this.$route.query.id}/follow_or_not`)
        .then(res => {
          if (res.data == true) {
            this.following = true
            this.notFollowing = false
          } else {
            this.following = false
            this.notFollowing = true
          }
        })
        .catch(err => console.log(err.response))
    },
    getFollowCount() {
      this.$axios.get(`relationships/${this.$route.query.id}/count`)
        .then(res => {
          this.followings = res.data.following
          this.followers = res.data.followers
        })
        .catch(err => console.log(err.response))
    },
    getNumOfArticles() {
      this.$axios.get(`articles/${this.$route.query.id}/user_articles_count`)
        .then(res => {
          this.numOfArticles = res.data
        })
        .catch(err => console.log(err.response))
    },
    async infiniteHandler($state) {
      if (this.published) {
        this.url = `articles/${this.$route.query.id}/user_articles`
        await this.getArticles($state)
      } else {
        this.url = `articles/${this.$route.query.id}/user_favorites`
        await this.getArticles($state)
      }
    },
    getArticles($state) {
      this.$axios.get(`${this.url}`, { params: { page: this.page }})
        .then(res => {
          if (res.data.articles.length) {
            setTimeout(() => {
              if (this.page <= res.data.kaminari.pagenation.pages) {
                this.kaminariPage = res.data.kaminari.pagenation.pages
                this.page += 1
                this.articles.push(...res.data.articles)
                if (this.page != 2) {
                  $state.loaded()
                }
              } else {
                $state.complete()
              }
            }, 800)
          } else {
            setTimeout(() => {
              this.loading = false
            }, 800)
            $state.complete()
          }
        })
        .catch(err => console.log(err.response))
    },
    followUser() {
      this.following = true
      this.notFollowing = false
      this.followers += 1
      this.$axios.post(`relationships/${this.$route.query.id}/follow`)
        .catch(err => {
          this.following = false
          this.notFollowing = true
          console.log(err.response)
        })
    },
    unfollowUser() {
      if (confirm(`${this.userName}さんのフォローを解除しますか？`)) {
        this.notFollowing = true
        this.following = false
        this.followers -= 1
        this.$axios.delete(`relationships/${this.$route.query.id}`)
          .catch(err => {
            this.notFollowing = false
            this.following = true
            console.log(err.response)
          })
      }
    },
    async showPublished() {
      this.favorite = false
      this.published = true
      this.articles = []
      this.page = 1
      this.loading = true
      await this.infiniteHandler()
    },
    async showFavorites() {
      this.published = false
      this.favorite = true
      this.articles = []
      this.page = 1
      this.loading = true
      await this.infiniteHandler()
    },
    toFollowingPage() {
      this.$router.push({ name: 'Following', query: { user_id: this.$route.query.id } })
    },
    toFollowerPage() {
      this.$router.push({ name: 'Followers', query: { user_id: this.$route.query.id } })
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
  border-top: solid thin #FF58F2;
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

.follow-button {
  white-space: nowrap;
  font-size: 13px;
  padding: 6px 14px;
  color: #1D51FF;
  border: solid thin #1D51FF;
  border-radius: 20px;
  cursor: pointer;
}

.unfollow-button {
  white-space: nowrap;
  font-size: 13px;
  padding: 6px 14px;
  border: solid thin #1D51FF;
  border-radius: 20px;
  background-color: #1D51FF;
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

.border-top {
  border-top: solid thin #CBCBCB;
  padding-bottom: 70px;
}

.invisible {
  opacity: 0;
}
</style>
