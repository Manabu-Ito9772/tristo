<template>
  <div>
    <div class="mt-4 pl-3 pr-3">
      <div class="row p-3 bg-white search">
        <template v-if="articleJapan">
          <div class="col-6 pr-1 p-0">
            <p class="m-0 p-1 text-white text-center font-weight-bold area-changer">
              国内
            </p>
          </div>
          <div class="col-6 pl-1 p-0">
            <template v-if="article || !loading">
              <p
                class="m-0 p-1 text-muted text-center font-weight-bold area-changer-unselected"
                @click="selectWorld"
              >
                海外
              </p>
            </template>
            <template v-else>
              <p
                class="m-0 p-1 text-muted text-center font-weight-bold area-changer-unselected"
              >
                海外
              </p>
            </template>
          </div>
        </template>

        <template v-else>
          <div class="col-6 pr-1 p-0">
            <template v-if="article || !loading">
              <p
                class="m-0 p-1 text-muted text-center font-weight-bold area-changer-unselected"
                @click="selectJapan"
              >
                国内
              </p>
            </template>
            <template v-else>
              <p
                class="m-0 p-1 text-muted text-center font-weight-bold area-changer-unselected"
              >
                国内
              </p>
            </template>
          </div>
          <div class="col-6 pl-1 p-0">
            <p class="m-0 p-1 text-white text-center font-weight-bold area-changer">
              海外
            </p>
          </div>
        </template>

        <template v-if="articleJapan">
          <div class="col-12 mt-3 p-0 form-group">
            <div class="d-flex align-items-center">
              <p class="p-1 mr-3 m-0 text-muted font-weight-bold form-label">
                都道府県
              </p>
              <v-select
                v-model="regionsIdArray"
                :options="prefectures"
                :reduce="prefecture => prefecture.id"
                label="name"
                multiple
                class="w-100 v-select"
              >
                <span slot="no-options">該当する都道府県がありません</span>
              </v-select>
            </div>
          </div>
        </template>

        <template v-else>
          <div class="col-12 mt-3 p-0 form-group">
            <div class="d-flex align-items-center">
              <p class="p-1 mr-4 m-0 text-muted font-weight-bold form-label">
                国
              </p>
              <v-select
                v-model="country"
                :options="countries"
                :get-option-label="country => country.name"
                class="w-100 v-select"
                @input="getRegions"
              >
                <span slot="no-options">該当する国がありません</span>
              </v-select>
            </div>
          </div>

          <div class="col-12 p-0 form-group">
            <div class="d-flex align-items-center">
              <p class="p-1 mr-2 m-0 text-muted font-weight-bold form-label">
                地域
              </p>
              <v-select
                v-model="regionsIdArray"
                :options="regions"
                :reduce="region => region.id"
                label="name"
                multiple
                class="w-100 v-select"
              >
                <span slot="no-options">該当する地域がありません</span>
              </v-select>
            </div>
          </div>
        </template>

        <div class="col-12 p-0 form-group">
          <div class="d-flex align-items-center">
            <template v-if="articleJapan">
              <template v-if="$mq == 'xs'">
                <p class="p-1 text-muted font-weight-bold form-label-tag">
                  タグ
                </p>
              </template>

              <template v-else>
                <p class="p-1 mr-5 m-0 text-muted font-weight-bold form-label">
                  タグ
                </p>
              </template>
            </template>

            <template v-else>
              <p class="p-1 mr-2 m-0 text-muted font-weight-bold form-label">
                タグ
              </p>
            </template>

            <v-select
              v-model="tags"
              multiple
              taggable
              class="w-100 v-select"
            >
              <span slot="no-options">タグを入力して下さい</span>
            </v-select>
          </div>
        </div>

        <div class="col-12 p-0 form-group">
          <p class="p-1 m-0 text-muted font-weight-bold form-label">
            フリーワード
          </p>
          <template v-if="$mq == 'lg'">
            <input
              v-model="search.q.words"
              placeholder="半角区切りで複数単語検索可"
              class="bg-light form-control w-100"
            >
          </template>

          <template v-else>
            <input
              v-model="search.q.words"
              placeholder="半角区切りで複数の単語を検索できます"
              class="bg-light form-control w-100"
            >
          </template>
        </div>

        <template v-if="$mq == 'lg'">
          <div class="col-12 mt-2 mb-4 p-0">
            <div class="d-flex justify-content-between">
              <div class="d-flex align-items-center">
                <input
                  v-model="search.q.sort"
                  type="radio"
                  name="並び順"
                  value="0"
                  checked
                  class="text-muted"
                >
                <p class="m-0 pl-1 text-muted">
                  新しい順
                </p>
              </div>
              <div class="d-flex align-items-center">
                <input
                  v-model="search.q.sort"
                  type="radio"
                  name="並び順"
                  value="1"
                  class="text-muted"
                >
                <p class="m-0 pl-1 text-muted">
                  古い順
                </p>
              </div>
              <div class="d-flex align-items-center">
                <input
                  v-model="search.q.sort"
                  type="radio"
                  name="並び順"
                  value="2"
                  class="text-muted"
                >
                <p class="m-0 pl-1 text-muted">
                  いいね順
                </p>
              </div>
            </div>
          </div>
        </template>

        <template v-else>
          <div class="col-12 mt-2 mb-4 p-0">
            <div class="d-flex justify-content-center">
              <div class="d-flex align-items-center">
                <input
                  v-model="search.q.sort"
                  type="radio"
                  name="並び順"
                  value="0"
                  checked
                  class="text-muted"
                >
                <p class="m-0 pl-1 text-muted">
                  新しい順
                </p>
              </div>

              <div class="ml-4 mr-4 d-flex align-items-center">
                <input
                  v-model="search.q.sort"
                  type="radio"
                  name="並び順"
                  value="1"
                  class="text-muted"
                >
                <p class="m-0 pl-1 text-muted">
                  古い順
                </p>
              </div>

              <div class="d-flex align-items-center">
                <input
                  v-model="search.q.sort"
                  type="radio"
                  name="並び順"
                  value="2"
                  class="text-muted"
                >
                <p class="m-0 pl-1 text-muted">
                  いいね順
                </p>
              </div>
            </div>
          </div>
        </template>

        <div class="col-12 text-center">
          <template v-if="article || !loading">
            <template v-if="isMobile">
              <div
                class="mb-2 pl-4 pr-4 text-white font-weight-bold button-mobile"
                @click="searchArticles"
              >
                検索
              </div>
            </template>
            <template v-else>
              <div
                class="mb-2 pl-4 pr-4 text-white font-weight-bold button"
                @click="searchArticles"
              >
                検索
              </div>
            </template>
          </template>

          <template v-else>
            <template v-if="isMobile">
              <div
                class="mb-2 pl-4 pr-4 text-white font-weight-bold button-mobile"
              >
                検索
              </div>
            </template>
            <template v-else>
              <div
                class="mb-2 pl-4 pr-4 text-white font-weight-bold button"
              >
                検索
              </div>
            </template>
          </template>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'SearchForm',
  props: {
    article: {
      type: Boolean,
      required: true
    },
    loading: {
      type: Boolean,
      required: true
    },
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
      search: {
        q: {
          japan: null,
          country_id: null,
          regions: '',
          tags: '',
          words: '',
          sort: 0
        }
      },
      countries: [],
      country: {},
      regions: [],
      prefectures: [],
      regionsIdArray: [],
      tags: [],
      isMobile: isMobile
    }
  },
  computed: {
    ...mapGetters('articles', ['articleJapan']),
    ...mapGetters('users', ['authUser']),
  },
  watch: {
    articleJapan() {
      this.search.q.japan = this.articleJapan
    },
    country() {
      if (this.country) {
        this.search.q.country_id = this.country.id
        this.regionsIdArray = []
      } else {
        this.search.q.country_id = null
        this.regionsIdArray = []
        this.regions = []
      }
    },
    regionsIdArray() {
      this.search.q.regions = this.regionsIdArray.join(' ')
    },
    tags() {
      this.search.q.tags = this.tags.join(' ')
    },
  },
  created() {
    this.sentag ? this.searchBySentag() : this.search.q.japan = this.articleJapan
    this.getCountries()
    this.getPrefectures()
  },
  methods: {
    getCountries() {
      this.$axios.get('countries')
        .then(res => {
          this.countries = res.data
          this.countries.splice(0, 1)
        })
        .catch(err => console.log(err.response))
    },
    getRegions() {
      if (this.country) {
        this.$axios.get(`regions/${this.country.id}`)
          .then(res => {
            this.regions = res.data
          })
          .catch(err => console.log(err.response))
      }
    },
    getPrefectures() {
      this.$axios.get(`regions/1`)
        .then(res => {
          this.prefectures = res.data
        })
        .catch(err => console.log(err.response))
    },
    searchArticles() {
      this.$emit('setSearch', this.search)
    },
    async selectJapan() {
      this.country = {}
      this.tags = []
      this.search.q.words = ''
      this.search.q.sort = 0
      this.$store.commit('articles/articleJapanTrue')
    },
    async selectWorld() {
      this.country = {}
      this.tags = []
      this.search.q.words = ''
      this.search.q.sort = 0
      this.$store.commit('articles/articleJapanFalse')
    },
    searchBySentag() {
      this.tags.push(this.sentag)
      this.search.q.japan = this.japan
      this.search.q.tags = this.sentag
      if (this.japan) {
        this.$store.commit('articles/articleJapanTrue')
      } else {
        this.$store.commit('articles/articleJapanFalse')
      }
      this.$emit('setSearch', this.search)
    }
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.sidebar_fixed {
  position: sticky;
  top: 60px;
}

.search {
  border: solid #CBCBCB;
  border-radius: 6px;
}

.area-changer {
  background-color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}

.area-changer-unselected {
  border: solid thin #CBCBCB;
  border-radius: 6px;
  cursor: pointer;
}

.form-label {
  white-space: nowrap;
}

.form-label-tag {
  white-space: nowrap;
  margin-bottom: 0px;
  margin-right: 46px;
}

.checkbox {
  border: solid #CBCBCB;
  border-radius: 6px;
}

.button {
  display: inline-block;
  background-color: #FF990D;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.button:hover {
  background-color: #D37C04;
  position: relative;
}

.button-mobile {
  display: inline-block;
  background-color: #FF990D;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.button-mobile:active {
  background-color: #D37C04;
  position: relative;
}

.v-select {
  border-radius: 4px;
  background-color: #f8f9fa;
}
</style>
