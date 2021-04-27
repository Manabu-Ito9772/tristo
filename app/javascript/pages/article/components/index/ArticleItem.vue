<template>
  <div>
    <template v-if="$mq == 'xs'">
      <div class="row pt-4 pl-4 pr-4 bg-white border-bottom">
        <div class="col-12 p-0">
          <div class="row">
            <div
              class="col-12 pointer"
              @click="toArticleShow(article.id)"
            >
              <h4 class="m-0 pt-1 pb-1 text-center text-white font-weight-bold article-title word-break">
                {{ article.title }}
              </h4>
              <template v-if="article.description">
                <p class="mt-3 mb-0 pt-2 pb-2 pl-3 pr-3 bg-light text-dark word-break article-description break-line remove-first-line">
                  {{ article.description }}
                </p>
              </template>
            </div>
            <div class="col-12 m-0 pt-2 pb-0 text-center text-muted article-info word-break">
              <template v-if="article.country.name != '日本'">
                <p class="d-inline">
                  【{{ article.country.name }}】
                </p>
              </template>

              <p
                v-for="article_region in article.article_regions"
                :key="article_region.id"
                class="d-inline pl-1 pr-1"
              >
                {{ article_region.region.name }}
              </p>

              <template v-if="article.start_date && article.end_date">
                <template v-if="article.start_date == article.end_date">
                  <p class="d-inline pl-1 pr-1">
                    {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
                  </p>
                </template>

                <template v-else>
                  <p class="d-inline pl-1 pr-1">
                    {{ article.start_date | moment('YYYY年 M/D(ddd)') }} 〜 {{ article.end_date | moment('M/D(ddd)') }}
                  </p>
                </template>
              </template>

              <template v-else-if="article.start_date && !article.end_date">
                <p class="d-inline pl-1 pr-1">
                  {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
                </p>
              </template>

              <template v-else-if="!article.start_date && article.end_date">
                <p class="d-inline pl-1 pr-1">
                  {{ article.end_date | moment('YYYY年 M/D(ddd)') }}
                </p>
              </template>

              <div class="mt-1 mb-1 text-center">
                <div
                  v-for="article_tag in article.article_tags"
                  :key="article_tag.id"
                  class="d-inline-block pl-1 pr-1 text-primary"
                >
                  <template v-if="article.country.name == '日本'">
                    <router-link
                      :to="{ name: 'ArticleSearch', params: { sentag: article_tag.tag.name, japan: true } }"
                    >
                      <p class="m-0 pointer">
                        #{{ article_tag.tag.name }}
                      </p>
                    </router-link>
                  </template>

                  <template v-else>
                    <router-link
                      :to="{ name: 'ArticleSearch', params: { sentag: article_tag.tag.name, japan: false } }"
                    >
                      <p class="m-0 pointer">
                        #{{ article_tag.tag.name }}
                      </p>
                    </router-link>
                  </template>
                </div>
              </div>
            </div>
          </div>
        </div>

        <template v-if="article.eyecatch_url">
          <div class="col-12 pt-1 p-0">
            <div class="image-trim">
              <img :src="article.eyecatch_url">
            </div>
          </div>
        </template>

        <div class="col-12 pt-3 pb-3 p-0">
          <div class="d-flex justify-content-center align-items-center">
            <div>
              <template v-if="article.user.avatar_url">
                <img
                  :src="article.user.avatar_url"
                  class="user-icon pointer"
                  @click="toUserPage(article.user.id)"
                >
              </template>
              <template v-else>
                <img
                  :src="require('../../../../../assets/images/default.jpg')"
                  class="user-icon pointer"
                  @click="toUserPage(article.user.id)"
                >
              </template>
            </div>
            <h5
              class="float-right mb-0 pl-3 text-dark font-weight-bold word-break user-name"
              @click="toUserPage(article.user.id)"
            >
              {{ article.user.name }}
            </h5>
            <template v-if="article.status == 'published'">
              <div class="pl-3">
                <template v-if="authUser">
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

                <template v-else>
                  <div class="text-muted">
                    <font-awesome-icon
                      :icon="['far', 'heart']"
                      class="fa-lg"
                    />
                  </div>
                </template>
              </div>
              <template v-if="favoritesCount != 0">
                <p class="m-0 pl-1 text-muted word-break">
                  {{ favoritesCount }}
                </p>
              </template>
            </template>
          </div>
        </div>
      </div>
    </template>

    <template v-else>
      <div class="pl-3 pr-3">
        <div class="row p-3 bg-white article">
          <div class="col-12 p-0">
            <div class="row">
              <div
                :id="'article-item-' + article.id"
                class="col-12 pointer"
                @click="toArticleShow(article.id)"
              >
                <h4 class="mb-0 pt-1 pb-1 text-center text-white font-weight-bold article-title word-break">
                  {{ article.title }}
                </h4>

                <template v-if="article.description">
                  <p class="mt-3 mb-0 pt-2 pb-2 pl-3 pr-3 bg-light text-dark article-description word-break break-line remove-first-line">
                    {{ article.description }}
                  </p>
                </template>
              </div>

              <div class="col-12 mt-2 text-muted word-break article-info">
                <div class="text-center text-muted word-break">
                  <template v-if="article.country.name != '日本'">
                    <p class="d-inline">
                      【{{ article.country.name }}】
                    </p>
                  </template>

                  <p
                    v-for="article_region in article.article_regions"
                    :key="article_region.id"
                    class="d-inline pl-1 pr-1 article-region"
                  >
                    {{ article_region.region.name }}
                  </p>

                  <template v-if="article.start_date && article.end_date">
                    <template v-if="article.start_date == article.end_date">
                      <p class="d-inline pl-1 pr-1">
                        {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
                      </p>
                    </template>
                    <template v-else>
                      <p class="d-inline pl-1 pr-1">
                        {{ article.start_date | moment('YYYY年 M/D(ddd)') }} 〜 {{ article.end_date | moment('M/D(ddd)') }}
                      </p>
                    </template>
                  </template>
                  <template v-else-if="article.start_date && !article.end_date">
                    <p class="d-inline pl-1 pr-1">
                      {{ article.start_date | moment('YYYY年 M/D(ddd)') }}
                    </p>
                  </template>
                  <template v-else-if="!article.start_date && article.end_date">
                    <p class="d-inline pl-1 pr-1">
                      {{ article.end_date | moment('YYYY年 M/D(ddd)') }}
                    </p>
                  </template>
                </div>

                <div class="mt-1 mb-1 text-center">
                  <div
                    v-for="article_tag in article.article_tags"
                    :id="'tag-' + article_tag.tag.name"
                    :key="article_tag.id"
                    class="d-inline-block pl-1 pr-1 text-primary article-tag"
                  >
                    <template v-if="$mq == 'lg'">
                      <template v-if="$route.path == '/trip_notes'">
                        <a
                          class="m-0 pointer"
                          href="#"
                          @click="searchByTag(article_tag.tag.name)"
                        >
                          #{{ article_tag.tag.name }}
                        </a>
                      </template>
                      <template v-else>
                        <template v-if="article.country.name == '日本'">
                          <router-link
                            :to="{ name: 'ArticleIndex', params: { sentag: article_tag.tag.name, japan: true } }"
                          >
                            <p class="m-0 pointer">
                              #{{ article_tag.tag.name }}
                            </p>
                          </router-link>
                        </template>
                        <template v-else>
                          <router-link
                            :to="{ name: 'ArticleIndex', params: { sentag: article_tag.tag.name, japan: false } }"
                          >
                            <p class="m-0 pointer">
                              #{{ article_tag.tag.name }}
                            </p>
                          </router-link>
                        </template>
                      </template>
                    </template>
                    <template v-else>
                      <template v-if="article.country.name == '日本'">
                        <router-link
                          :to="{ name: 'ArticleSearch', params: { sentag: article_tag.tag.name, japan: true } }"
                        >
                          <p class="m-0 pointer">
                            #{{ article_tag.tag.name }}
                          </p>
                        </router-link>
                      </template>
                      <template v-else>
                        <router-link
                          :to="{ name: 'ArticleSearch', params: { sentag: article_tag.tag.name, japan: false } }"
                        >
                          <p class="m-0 pointer">
                            #{{ article_tag.tag.name }}
                          </p>
                        </router-link>
                      </template>
                    </template>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <template v-if="article.eyecatch_url">
            <div class="col-12 pt-1 p-0">
              <div class="image-trim">
                <img :src="article.eyecatch_url">
              </div>
            </div>
          </template>

          <div class="col-12 pt-3 p-0">
            <div class="d-flex justify-content-center align-items-center user">
              <div>
                <template v-if="article.user.avatar_url">
                  <img
                    :src="article.user.avatar_url"
                    class="user-icon pointer"
                    @click="toUserPage(article.user.id)"
                  >
                </template>
                <template v-else>
                  <img
                    id="default-avatar"
                    :src="require('../../../../../assets/images/default.jpg')"
                    class="user-icon pointer"
                    @click="toUserPage(article.user.id)"
                  >
                </template>
              </div>
              <h5
                :id="'article-user-' + article.user.id"
                class="float-right mb-0 pl-3 text-dark font-weight-bold word-break user-name"
                @click="toUserPage(article.user.id)"
              >
                {{ article.user.name }}
              </h5>
              <template v-if="article.status == 'published'">
                <div class="pl-3">
                  <template v-if="authUser">
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

                  <template v-else>
                    <div
                      id="heart-notlogin"
                      class="text-muted"
                    >
                      <font-awesome-icon
                        :icon="['far', 'heart']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                </div>
                <template v-if="favoritesCount != 0">
                  <p class="m-0 pl-1 text-muted word-break favorite-count">
                    {{ favoritesCount }}
                  </p>
                </template>
              </template>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { isMobile } from 'mobile-device-detect'

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
      favoritesCount: null,
      favorited: null,
      isMobile: isMobile
    }
  },
  computed: {
    ...mapGetters('users', ['authUser'])
  },
  created() {
    this.favoritesCount = this.article.favorites.length
    this.favoriteOrNot()
  },
  methods: {
    favoriteArticle() {
      this.$axios.post(`favorites/${this.article.id}/favorite`)
        .then(res => {
          this.favoritesCount += 1
          this.favorited = true
        })
        .catch(err => console.log(err.response))
    },
    unfavoriteArticle() {
      this.$axios.delete(`favorites/${this.article.id}`)
        .then(res => {
          this.favoritesCount -= 1
          this.favorited = false
        })
        .catch(err => console.log(err.response))
    },
    favoriteOrNot() {
      if (this.authUser) {
        let result = this.article.favorites.some(favorite => {
          return favorite.user_id == this.authUser.id
        })
        if (result == true) {
          this.favorited = true
        } else {
          this.favorited = false
        }
      }
    },
    toArticleShow(article_id) {
      this.$router.push({ name: 'ArticleShow', query: {id: article_id} })
    },
    toUserPage(user_id) {
      if (this.authUser && this.authUser.id == user_id) {
        if (this.$route.path != '/mypage') {
          this.$store.commit('pages/setCurrentPage', 'user')
          this.$router.push({ name: 'MyPage' })
        }
      } else {
        this.$router.push({ name: 'UserShow', query: { id: user_id } })
      }
    },
    searchByTag(tag) {
      this.$emit('searchByTag', tag)
    }
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.article {
  border: solid #FF58F2;
  border-radius: 6px;
}

.article-title {
  background-color: #FF58F2;
  border-radius: 6px;
}

.article-description {
  border: solid thin #FF58F2;
  border-radius: 6px;
}

.article-info {
  font-size: 14px;
}

.user-icon {
  width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 50%;
}

.user-name {
  color: black;
  cursor: pointer;
}

.pointer {
  cursor: pointer;
}

.heart {
  color: #FF58F2;
  cursor: pointer;
}

.heart:hover {
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

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}

.bottom-border {
  border-bottom: solid thin #CBCBCB;
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
</style>
