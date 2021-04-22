<template>
  <div class="w-100">
    <template v-if="article.title">
      <template v-if="article.title">
        <h5 class="col-12 mb-3 p-2 text-center text-white font-weight-bold article-title word-break">
          {{ article.title }}
        </h5>
      </template>

      <div class="col-12 p-2 mb-3 bg-white article-overview">
        <template v-if="countryname != '日本'">
          <p class="mb-1 p-1 text-center text-white font-weight-bold overview-label">
            国と地域
          </p>
          <div class="pl-2 pr-2 text-dark text-center word-break">
            <p class="d-inline">
              【{{ countryname }}】
            </p>
            <p
              v-for="article_region in article.article_regions"
              :key="article_region.id"
              class="d-inline pl-1 pr-1 article-region"
            >
              {{ article_region.region.name }}
            </p>
          </div>
        </template>

        <template v-else>
          <p class="mb-1 p-1 text-center text-white font-weight-bold overview-label">
            都道府県
          </p>
          <div class="pl-2 pr-2 text-dark text-center word-break">
            <p
              v-for="article_region in article.article_regions"
              :key="article_region.id"
              class="d-inline pl-1 pr-1 article-region"
            >
              {{ article_region.region.name }}
            </p>
          </div>
        </template>

        <template v-if="article.start_date || article.end_date">
          <p class="mt-3 mb-1 p-1 text-center text-white font-weight-bold overview-label">
            日程
          </p>
          <div class="pl-2 pr-2 text-center text-dark word-break">
            <template v-if="article.start_date && article.end_date">
              <template v-if="article.start_date == article.end_date">
                <p class="d-inline article-date">
                  {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
                </p>
              </template>

              <template v-else>
                <p class="d-inline article-date">
                  {{ article.start_date | moment('YYYY年 M/D(ddd)') }} 〜 {{ article.end_date | moment('M/D(ddd)') }}
                </p>
              </template>
            </template>

            <template v-else-if="article.start_date && !article.end_date">
              <p class="d-inline article-date">
                {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
              </p>
            </template>

            <template v-else-if="!article.start_date && article.end_date">
              <p class="d-inline article-date">
                {{ article.end_date | moment('YYYY年 M/D(ddd)') }}
              </p>
            </template>
          </div>
        </template>

        <template v-if="article.description">
          <p class="mt-3 mb-1 p-1 text-center text-white font-weight-bold overview-label">
            コメント
          </p>
          <p class="text-dark pl-2 pr-2 pb-0 word-break break-line remove-first-line">
            {{ article.description }}
          </p>
        </template>
      </div>

      <div class="col-12 mb-3 p-0 d-flex justify-content-center align-items-center user-name">
        <div>
          <img
            :src="user.avatar_url"
            class="user-icon"
            @click="toUserPage(user.id)"
          >
        </div>
        <h5
          class="float-right mb-0 pl-3 text-dark font-weight-bold word-break user-link"
          @click="toUserPage(user.id)"
        >
          {{ user.name }}
        </h5>

        <template v-if="authUser && authUser.id == user.id">
          <DropdownMenu
            v-model="show"
            :right="right"
            :hover="hover"
            :interactive="interactive"
          >
            <template v-if="isMobile">
              <div
                class="ml-3 text-center circle-mobile"
              >
                <font-awesome-icon
                  :icon="['fas', 'ellipsis-h']"
                  class="fa-lg"
                />
              </div>
            </template>
            <template v-else>
              <div
                id="edit-menu"
                class="ml-3 text-center circle"
              >
                <font-awesome-icon
                  :icon="['fas', 'ellipsis-h']"
                  class="fa-lg"
                />
              </div>
            </template>
            <div slot="dropdown">
              <div
                id="edit-btn"
                class="dropdown-item pointer"
                @click="showArticleEdit"
              >
                旅行記録を編集
              </div>
              <div
                class="dropdown-item pointer delete-article"
                @click="deleteArticle"
              >
                旅行記録を削除
              </div>
            </div>
          </DropdownMenu>
        </template>

        <template v-if="authUser">
          <template v-if="$mq == 'lg'">
            <div class="pl-3 text-center">
              <template v-if="favorited != null">
                <template v-if="favorited">
                  <template v-if="isMobile">
                    <div
                      id="heart-favorited"
                      class="heart-favorited-mobile"
                      @click="unfavoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['fas', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                  <template v-else>
                    <div
                      id="heart-favorited"
                      class="heart-favorited"
                      @click="unfavoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['fas', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                </template>

                <template v-else>
                  <template v-if="isMobile">
                    <div
                      id="heart"
                      class="heart-mobile"
                      @click="favoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['far', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                  <template v-else>
                    <div
                      id="heart"
                      class="heart"
                      @click="favoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['far', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                </template>
              </template>
              <template v-if="favorites != 0">
                <p class="m-0 text-muted word-break favorites">
                  {{ favorites }}
                </p>
              </template>
            </div>
          </template>

          <template v-else>
            <div class="pl-3 d-flex justify-content-center align-items-center">
              <template v-if="favorited != null">
                <template v-if="favorited">
                  <template v-if="isMobile">
                    <div
                      class="heart-favorited-mobile"
                      @click="unfavoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['fas', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                  <template v-else>
                    <div
                      class="heart-favorited"
                      @click="unfavoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['fas', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                </template>

                <template v-else>
                  <template v-if="isMobile">
                    <div
                      class="heart-mobile"
                      @click="favoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['far', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                  <template v-else>
                    <div
                      class="heart"
                      @click="favoriteArticle"
                    >
                      <font-awesome-icon
                        :icon="['far', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                </template>
              </template>
              <template v-if="favorites != 0">
                <p class="m-0 pl-1 text-muted word-break favorites">
                  {{ favorites }}
                </p>
              </template>
            </div>
          </template>
        </template>

        <template v-else>
          <template v-if="$mq == 'lg'">
            <div class="pl-3 text-center">
              <div
                id="heart-notlogin"
                class="text-muted"
              >
                <font-awesome-icon
                  :icon="['far', 'heart']"
                  class="fa-lg"
                />
              </div>
              <template v-if="favorites != 0">
                <p class="m-0 text-muted word-break favorites">
                  {{ favorites }}
                </p>
              </template>
            </div>
          </template>

          <template v-else>
            <div class="pl-3 d-flex justify-content-center align-items-center">
              <div class="text-muted">
                <font-awesome-icon
                  :icon="['far', 'heart']"
                  class="fa-lg"
                />
              </div>
              <template v-if="favorites != 0">
                <p class="m-0 pl-1 text-muted word-break favorites">
                  {{ favorites }}
                </p>
              </template>
            </div>
          </template>
        </template>
      </div>

      <div class="col-12 mb-2 p-0 text-muted text-center word-break article-info">
        <p
          v-for="article_tag in article.article_tags"
          :key="article_tag.id"
          :id="'tag-' + article_tag.tag.name"
          class="d-inline-block m-0 pl-1 pr-1 article-tag"
        >
          <template v-if="$mq == 'lg'">
            <template v-if="countryname == '日本'">
              <router-link
                :to="{ name: 'ArticleIndex', params: { sentag: article_tag.tag.name, japan: true } }"
              >
                #{{ article_tag.tag.name }}
              </router-link>
            </template>

            <template v-else>
              <router-link
                :to="{ name: 'ArticleIndex', params: { sentag: article_tag.tag.name, japan: false } }"
              >
                #{{ article_tag.tag.name }}
              </router-link>
            </template>
          </template>

          <template v-else>
            <template v-if="countryname == '日本'">
              <router-link
                :to="{ name: 'ArticleSearch', params: { sentag: article_tag.tag.name, japan: true } }"
              >
                #{{ article_tag.tag.name }}
              </router-link>
            </template>

            <template v-else>
              <router-link
                :to="{ name: 'ArticleSearch', params: { sentag: article_tag.tag.name, japan: false } }"
              >
                #{{ article_tag.tag.name }}
              </router-link>
            </template>
          </template>
        </p>
      </div>
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'Overview',
  props: {
    article: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    },
    countryname: {
      type: String,
      required: true
    },
    favorites: {
      type: Number,
      required: true
    },
    favorited: {
      type: Boolean,
      required: false
    }
  },
  data() {
    return {
      countryName: '',
      tags: [],
      isVisibleMenu: false,
      show: false,
      right: true,
      hover: false,
      interactive: false,
      isMobile: isMobile
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    ...mapGetters('pages', ['currentPage']),
  },
  methods: {
    favoriteArticle() {
      this.$axios.post(`favorites/${this.article.id}/favorite`)
        .then(res => {
          this.$emit('favoriteArticle')
        })
        .catch(err => console.log(err.response))
    },
    unfavoriteArticle() {
      this.$axios.delete(`favorites/${this.article.id}`)
        .then(res => {
          this.$emit('unfavoriteArticle')
        })
        .catch(err => console.log(err.response))
    },
    toUserPage(user_id) {
      if (this.authUser && this.authUser.id == user_id) {
        this.$store.commit('pages/setCurrentPage', 'user')
        this.$router.push({ name: 'MyPage' })
      } else {
        this.$router.push({ name: 'UserShow', query: { id: user_id } })
      }
    },
    async deleteArticle() {
      this.show = false
      if (confirm('旅行記録を削除しますか？')) {
        await this.$axios.delete(`articles/${this.$route.query.id}`)
          .catch(err => console.log(err.response))
        if (this.currentPage == 'home') {
          this.$router.push({ name: 'ArticleIndex' })
        } else if (this.currentPage == 'user') {
          this.$router.push({ name: 'MyPage' })
        }
      }
    },
    showArticleEdit() {
      this.$router.push({
        name: 'ArticleEdit',
        query: {id: this.$route.query.id}
      })
    }
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.article-title {
  background-color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.article-overview {
  border: solid #CBCBCB;
  border-radius: 6px;
}

.overview-label {
  background-color: #6A6A6A;
  border-radius: 4px;
}

.user-name {
  display: inline-block;
  vertical-align: middle;
}

.user-icon {
  width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 50%;
  cursor: pointer;
}

.user-link {
  cursor: pointer;
}

.article-info {
  font-size: 14px;
}

.circle {
  color: gray;
  font-size: 12px;
  position: relative;
  padding: 2px 3px;
  border: solid thin gray;
  object-fit: cover;
	border-radius: 50%;
  cursor: pointer;
}

.circle:hover {
  color: #383838;
  border: solid thin #383838;
}

.circle-mobile {
  color: gray;
  font-size: 12px;
  position: relative;
  padding: 2px 3px;
  border: solid thin gray;
  object-fit: cover;
	border-radius: 50%;
  cursor: pointer;
}

.circle-mobile:active {
  color: #383838;
  border: solid thin #383838;
}

.edit-box {
  width: 110px;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.font-small {
  font-size: 13px;
}

.edit-button {
  border-bottom: solid thin #6A6A6A;
}

.favorites {
  white-space: nowrap;
}

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}

.heart {
  color: #FF58F2;
  cursor: pointer;
}

.heart:hover {
  color: #C400B5;
  cursor: pointer;
}

.heart:active {
  color: #C400B5;
  cursor: pointer;
}

.heart-favorited {
  color: #FF58F2;
  cursor: pointer;
}

.heart-favorited:hover {
  color: #C400B5;
  cursor: pointer;
}

.heart-favorited:active {
  color: #C400B5;
  cursor: pointer;
}

.heart-mobile {
  color: #FF58F2;
  cursor: pointer;
}

.heart-mobile:active {
  color: #C400B5;
  cursor: pointer;
}

.heart-favorited-mobile {
  color: #FF58F2;
  cursor: pointer;
}

.heart-favorited-mobile:active {
  color: #C400B5;
  cursor: pointer;
}

.pointer {
  cursor: pointer;
}

.delete-article {
  color: #dc3545;
}

.delete-article:hover {
  color: #dc3545;
}

.delete-article:active {
  color: white;
}
</style>
