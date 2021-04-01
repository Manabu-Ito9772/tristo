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
                    {{ userName }}
                  </h4>
                  <template v-if="authUser">
                    <template v-if="notFollowing">
                      <button
                        class="btn bg-white font-weight-bold follow-button"
                        @click="followUser"
                      >
                        フォロー
                      </button>
                    </template>
                    <template v-if="following">
                      <button
                        class="btn text-white font-weight-bold unfollow-button"
                        @click="unfollowUser"
                      >
                        フォロー中
                      </button>
                    </template>
                  </template>
                </div>

                <div class="mt-2 d-flex justify-content-center text-muted">
                  <template v-if="articleLength != null">
                    <div class="pr-3 text-center">
                      <p class="m-0 word-unbreak font-small">
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
            <template v-if="userDescription">
              <p class="mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro">
                {{ userDescription }}
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
                <div class="d-flex justify-content-center align-items-center">
                  <h3 class="mb-0 pr-3 text-dark font-weight-bold word-break">
                    {{ userName }}
                  </h3>
                  <template v-if="authUser">
                    <template v-if="notFollowing">
                      <button
                        class="btn bg-white font-weight-bold follow-button"
                        @click="followUser"
                      >
                        フォロー
                      </button>
                    </template>
                    <template v-if="following">
                      <button
                        class="btn text-white font-weight-bold unfollow-button"
                        @click="unfollowUser"
                      >
                        フォロー中
                      </button>
                    </template>
                  </template>
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
            <template v-if="userDescription">
              <p class="ml-4 mr-4 mb-0 pt-2 pl-2 pr-2 pb-0 text-dark word-break self-intro">
                {{ userDescription }}
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
import { mapGetters } from 'vuex'

export default {
  name: 'UserShow',
  components: {
    ArticleItem
  },

  data() {
    return {
      userName: '',
      userDescription: '',
      followings: null,
      followers: null,
      articleLength: null,
      articles: [],
      published: true,
      noPublished: false,
      favorite: false,
      noFavorites: false,
      following: null,
      notFollowing: null,
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  created() {
    this.getUserAndArticles()
  },
  methods: {
    getUserAndArticles() {
      this.$axios.get(`users/${this.$route.query.id}`)
        .then(res => {
          this.userName = res.data.name
          this.userDescription = res.data.description
          this.followings = res.data.followings.length
          this.followers = res.data.followers.length
          if (this.authUser) {
            this.following = res.data.followers.some(user => {
              return user.id == this.authUser.id
            })
            if (this.following == true) {
              this.notFollowing = false
            } else {
              this.notFollowing = true
            }
          }
          for (let article of res.data.ordered_articles) {
            if (article.status == 'published') {
              this.articles.push(article)
            }
          }
          if (!res.data.ordered_articles.length) {
            this.noPublished = true
          }
          this.articleLength = this.articles.length
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
    showFavorites() {
      this.published = false
      this.favorite = true
    },
    showPublished() {
      this.favorite = false
      this.published = true
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

.follow-button {
  white-space: nowrap;
  font-size: 13px;
  color: #1D51FF;
  border: solid thin #1D51FF;
  border-radius: 20px;
}

.unfollow-button {
  white-space: nowrap;
  font-size: 13px;
  border: solid thin #1D51FF;
  border-radius: 20px;
  background-color: #1D51FF;
}

.pointer {
  cursor: pointer;
}
</style>
