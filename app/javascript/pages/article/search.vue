<template>
  <div class="container-fluid mt-2">
    <template v-if="$mq == 'sm'">
      <div class="row">
        <div class="col-12 search-form">
          <SearchForm
            :article="presence"
            :loading="loading"
            :sentag="sentag"
            :japan="japan"
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
                  color="#FF00EB"
                  :size="{ width: '100px' }"
                />
              </div>
            </template>

            <template v-if="nan">
              <div class="mt-5 mb-5">
                <h3 class="text-center font-weight-bold text-secondary">
                  投稿がありません
                </h3>
              </div>
            </template>
          </template>
        </div>
      </div>
    </template>

    <template v-if="$mq == 'xs'">
      <div class="row">
        <div class="col-12">
          <SearchForm
            :article="presence"
            :loading="loading"
            :sentag="sentag"
            :japan="japan"
            class="mb-4 search-form"
            @resetPageJapan="resetPageJapan"
            @resetPageWorld="resetPageWorld"
            @setSearch="setSearch"
          />
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

          <template v-if="nan">
            <div class="col-12 mt-4">
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
import ArticleList from './components/index/ArticleList'
import SearchForm from './components/search/SearchForm'
import { mapGetters } from 'vuex'

export default {
  name: 'ArticleIndex',
  components: {
    ArticleList,
    SearchForm
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
      nan: false
    }
  },
  computed: {
    ...mapGetters('articles', ['articleJapan'])
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
    this.loading = false
    this.$store.commit('pages/setCurrentPage', 'search')
    this.scrollTop()
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
              this.nan = true
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
              this.nan = true
            }, 800)
            $state.complete()
          }
        })
        .catch(err => console.log(err.response))
    },
    async resetPageJapan() {
      this.$store.commit('articles/articleJapanTrue')
    },
    async resetPageWorld() {
      this.$store.commit('articles/articleJapanFalse')
    },
    async setSearch(search) {
      this.search = search
      this.articles = []
      this.page = 1
      this.loading = true
      this.nan = false
      this.scrollTop()
      await this.infiniteHandler()
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
</style>
