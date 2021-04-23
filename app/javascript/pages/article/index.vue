<template>
  <div>
    <div
      v-show="isVisibleMsg"
      class="col-12 mt-2 text-white msg"
    >
      {{ msg }}
    </div>
    <div class="container-fluid mt-2">
      <template v-if="$mq == 'lg'">
        <div class="row">
          <template v-if="articles.length">
            <div class="col-8 mb-5">
              <div
                v-for="article in articles"
                :key="article.id"
              >
                <ArticleList
                  :article="article"
                  @searchByTag="searchByTag"
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
              <vue-loading
                type="spiningDubbles"
                color="#FF58F2"
                :size="{ width: '100px' }"
                class="mt-4 pt-5"
              />
            </template>
            <template v-else>
              <div class="col-8 mt-5 pt-5 mb-5">
                <h3 class="text-center font-weight-bold text-secondary">
                  投稿がありません
                </h3>
              </div>
            </template>
          </template>
          <SearchForm
            ref="form"
            :article="presence"
            :loading="loading"
            :sentag="sentag"
            :japan="japan"
            class="col-4"
            @resetPageJapan="resetPageJapan"
            @resetPageWorld="resetPageWorld"
            @setSearch="setSearch"
          />
        </div>
      </template>

      <template v-else-if="$mq == 'sm'">
        <div class="row">
          <div class="col-12 search-form">
            <AreaChanger
              :article="presence"
              :loading="loading"
              class="ml-5 mr-5 pl-5 pr-5"
              @resetPageJapan="resetPageJapan"
              @resetPageWorld="resetPageWorld"
              @setSearch="setSearch"
            />
          </div>
          <div class="col-12 mb-5">
            <template v-if="articles.length">
              <div
                v-for="article in articles"
                :key="article.id"
                class="ml-5 mr-5 pl-5 pr-5"
              >
                <ArticleList
                  :article="article"
                />
              </div>
              <infinite-loading
                spinner="circles"
                @infinite="infiniteHandler"
              />
            </template>

            <template v-else>
              <template v-if="loading">
                <div class="mt-5 mb-5">
                  <vue-loading
                    type="spiningDubbles"
                    color="#FF58F2"
                    :size="{ width: '80px' }"
                  />
                </div>
              </template>

              <template v-else>
                <div class="mt-5 pt-3 mb-5">
                  <h3 class="text-center font-weight-bold text-secondary">
                    投稿がありません
                  </h3>
                </div>
              </template>
            </template>
          </div>
        </div>
      </template>

      <template v-else>
        <div class="row">
          <div class="col-12">
            <template v-if="authUser">
              <AreaChanger
                :article="presence"
                :loading="loading"
                class="mb-4 search-form"
                @resetPageJapan="resetPageJapan"
                @resetPageWorld="resetPageWorld"
                @setSearch="setSearch"
              />
            </template>
            <template v-else>
              <AreaChanger
                :article="presence"
                :loading="loading"
                class="mb-3 search-form"
                @resetPageJapan="resetPageJapan"
                @resetPageWorld="resetPageWorld"
                @setSearch="setSearch"
              />
            </template>
          </div>
          <template v-if="articles.length">
            <div class="col-12 border-top">
              <div
                v-for="article in articles"
                :key="article.id"
              >
                <ArticleList
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
              <div class="col-12 mt-3">
                <vue-loading
                  type="spiningDubbles"
                  color="#FF58F2"
                  :size="{ width: '80px' }"
                />
              </div>
            </template>

            <template v-else>
              <div class="col-12 mt-4 pt-2">
                <h3 class="text-center font-weight-bold text-secondary">
                  投稿がありません
                </h3>
              </div>
            </template>
          </template>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import ArticleList from './components/index/ArticleList'
import SearchForm from './components/index/SearchForm'
import AreaChanger from './components/index/AreaChanger'
import { mapGetters } from 'vuex'

export default {
  name: 'ArticleIndex',
  components: {
    ArticleList,
    SearchForm,
    AreaChanger
  },
  props: {
    sentag: {
      type: String,
      default: null,
      required: false
    },
    japan: {
      type: Boolean,
      required: false
    },
  },
  data() {
    return {
      articles: [],
      page: 1,
      kaminariPage: null,
      url: 'articles/japan',
      search: null,
      loading: true,
      presence: false,
      searchTag: {
        q: {
          japan: null,
          tags: '',
          sort: 0
        }
      },
      isVisibleMsg: false,
      msg: '退会しました。ご利用ありがとうございました。'
    }
  },
  computed: {
    ...mapGetters('articles', ['articleJapan']),
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
    if (!this.sentag) {
      this.infiniteHandler()
    }
    this.$store.commit('pages/setCurrentPage', 'home')
    this.showMsg()
  },
  methods: {
    async infiniteHandler($state) {
      if (!this.search) {
        if (this.articleJapan == null) {
          this.$store.commit('articles/articleJapanTrue')
        } else if (this.articleJapan == true) {
          this.url = 'articles/japan'
        } else {
          this.url = 'articles'
        }
        await this.getArticles($state)
      } else {
        this.searchArticles($state)
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
    searchArticles($state) {
      this.$axios.post('articles/search', this.search, { params: { page: this.page }})
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
    async resetPageJapan() {
      this.articles = []
      this.search = null
      this.page = 1
      this.loading = true
      this.scrollTop()
      this.$store.commit('articles/articleJapanTrue')
      await this.infiniteHandler()
    },
    async resetPageWorld() {
      this.articles = []
      this.search = null
      this.page = 1
      this.loading = true
      this.scrollTop()
      this.$store.commit('articles/articleJapanFalse')
      await this.infiniteHandler()
    },
    async setSearch(search) {
      this.search = search
      this.articles = []
      this.page = 1
      this.loading = true
      this.scrollTop()
      await this.infiniteHandler()
    },
    searchByTag(tag) {
      this.$refs.form.searchByTag(tag)
    },
    showMsg() {
      if (this.$route.params.msg) {
        this.isVisibleMsg = true
        setTimeout(() => {
          this.isVisibleMsg = false}
          ,3000
        )
      }
    },
    scrollTop(){
      window.scrollTo({
        top: 0,
        behavior: 'instant'
      })
    }
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 1000px;
  margin-right: auto;
  margin-left: auto;
}

.border-top {
  border-top: solid thin #CBCBCB;
  padding-bottom: 70px;
}

.search-form {
  z-index: 1;
}

.msg {
  background-color: #22CDE8;
}
</style>
