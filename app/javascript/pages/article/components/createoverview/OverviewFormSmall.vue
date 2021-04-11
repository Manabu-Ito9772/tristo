<template>
  <div class="row">
    <div class="col-12 p-3 text-center">
      <h3 class="p-0 m-0 d-inline font-weight-bold top-title">
        旅行記録を作成
      </h3>
    </div>
    <div class="col-12 mb-5 pb-4 pt-2">
      <div class="row pb-4 pl-3 pr-3">
        <div class="col-6 pl-0 pr-2">
          <button
            v-if="isVisibleDomestic"
            class="btn p-0 w-100 text-white font-weight-bold domestic-btn"
          >
            国内
          </button>
          <button
            v-if="isVisibleOverseas"
            class="btn p-0 w-100 bg-white font-weight-bold domestic-btn-unselected"
            @click="changeToDomestic"
          >
            国内
          </button>
        </div>
        <div class="col-6 pr-0 pl-2">
          <button
            v-if="isVisibleOverseas"
            class="btn p-0 w-100 text-white font-weight-bold domestic-btn"
          >
            海外
          </button>
          <button
            v-if="isVisibleDomestic"
            class="btn p-0 w-100 bg-white font-weight-bold domestic-btn-unselected"
            @click="changeToOverseas"
          >
            海外
          </button>
        </div>
      </div>

      <ValidationObserver v-slot="{ handleSubmit }">
        <div class="form-group mb-4">
          <ValidationProvider
            v-slot="{ errors }"
            rules="required|max:100"
          >
            <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
              * タイトル
            </p>
            <input
              v-model="article.title"
              name="タイトル"
              class="form-control"
            >
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>
        </div>

        <div
          v-if="isVisibleOverseas"
          class="form-group mb-4"
        >
          <ValidationProvider
            v-slot="{ errors }"
            rules="country"
          >
            <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
              * 国
            </p>
            <v-select
              v-model="country"
              name="国"
              :options="countries"
              label="name"
              :clearable="false"
              class="bg-white"
            >
              <span slot="no-options">該当する国がありません</span>
            </v-select>
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>
        </div>

        <template v-if="isVisibleOverseas">
          <div class="form-group mb-4">
            <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
              地域
            </p>
            <v-select
              v-model="regionIdArray"
              name="地域"
              :options="country.regions"
              :reduce="region => region.id"
              label="name"
              multiple
              class="bg-white"
            >
              <span slot="no-options">該当する地域がありません</span>
            </v-select>
          </div>
        </template>
        <template v-else>
          <div class="form-group mb-4">
            <ValidationProvider
              v-slot="{ errors }"
              rules="prefecture"
            >
              <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
                * 都道府県
              </p>
              <v-select
                v-model="regionIdArrayJapan"
                :options="japan.regions"
                :reduce="region => region.id"
                label="name"
                multiple
                class="bg-white"
              >
                <span slot="no-options">該当する都道府県がありません</span>
              </v-select>
              <span class="text-danger">{{ errors[0] }}</span>
            </ValidationProvider>
          </div>
        </template>

        <div class="form-group mb-4">
          <ValidationProvider
            v-slot="{ errors }"
            rules="max:3000"
          >
            <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
              説明
            </p>
            <textarea
              ref="area"
              v-model="article.description"
              :style="styles"
              name="説明"
              class="form-control"
              rows="1"
            />
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>
        </div>

        <div class="form-group mb-4">
          <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
            日程
          </p>
          <div class="d-flex align-items-center justify-content-between">
            <Datepicker
              v-model="article.start_date"
              :format="datepicker.format"
              :language="datepicker.ja"
              :clear-button="datepicker.clear"
              :bootstrap-styling="datepicker.bootstrap"
              :disabled-dates="datepicker.disabledStartDates"
              input-class="text-center bg-white"
              placeholder="旅行開始日"
            />
            <p class="pl-2 pr-2 m-0">
              〜
            </p>
            <Datepicker
              v-model="article.end_date"
              :format="datepicker.format"
              :language="datepicker.ja"
              :clear-button="datepicker.clear"
              :bootstrap-styling="datepicker.bootstrap"
              :disabled-dates="datepicker.disabledEndDates"
              input-class="text-center bg-white"
              placeholder="旅行終了日"
            />
          </div>
          <template v-if="!article.start_date && !article.end_date">
            <div class="text-center mt-3">
              <p class="p-1 m-0 d-inline text-center text-dark font-weight-bold">
                日数のみ入力
              </p>
            </div>
            <div class="text-center">
              <select
                v-model="days"
                class="d-inline form-control w-25 bg-white"
              >
                <option
                  v-for="daynum in thirty_days"
                  :key="daynum.value"
                  :value="daynum.value"
                >
                  {{ daynum.name }}
                </option>
              </select>
            </div>
          </template>
        </div>

        <div class="form-group mb-4">
          <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
            タグ
          </p>
          <v-select
            v-model="tags"
            multiple
            taggable
            class="bg-white"
          >
            <span slot="no-options">タグを登録できます</span>
          </v-select>
        </div>

        <div class="form-group mb-3">
          <p class="p-1 mb-2 text-center text-white font-weight-bold form-label">
            マップ
          </p>
          <input
            v-model="article.map"
            class="form-control"
          >
          <p class="mb-0 text-center text-secondary font-small">
            ※HTMLコードを入力することでGoogle my mapsを埋め込むことができます。 詳しくはこちら。
          </p>
        </div>

        <div class="pb-3 text-center">
          <p class="m-0 mb-3 text-secondary">
            * 必須項目
          </p>
          <button
            class="btn text-white font-weight-bold button"
            @click="handleSubmit(createArticle)"
          >
            詳細入力ページへ進む
          </button>
        </div>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import {ja} from 'vuejs-datepicker/dist/locale'

export default {
  name: 'OverviewFormSmall',
  data() {
    return {
      isVisibleDomestic: true,
      isVisibleOverseas: false,
      countries: [],
      country: '',
      japan: {},
      regionIdArray: [],
      regionIdArrayJapan: [],
      article_region: {
        article_id: 0,
        region_id: 0,
      },
      article: {
        region_id: '',
        title: '',
        description: '',
        map: '',
        start_date: '',
        end_date: ''
      },
      day: {
        article_id: null,
      },
      days: 1,
      tags: [],
      article_tag: {
        article_id: 0,
        tag_id: 0
      },
      datepicker: {
        format: 'M月d日(D)',
        ja: ja,
        clear: true,
        bootstrap: true,
        disabledStartDates: {
          from: '',
        },
        disabledEndDates: {
          to: '',
        },
      },
      thirty_days: [
        { name: '日帰り', value: 1 },
      ],
      height: '',
    }
  },
  computed: {
    styles(){
      return {
        'height': this.height
      }
    }
  },
  watch: {
    'article.start_date'() {
      this.datepicker.disabledEndDates.to = this.article.start_date
    },
    'article.end_date'() {
      this.datepicker.disabledStartDates.from = this.article.end_date
    },
    'article.description'(){
      this.resize()
    },
    country() {
      this.regionIdArray.length = 0
    }
  },
  created() {
    this.getCountries()
    this.countThirty()
  },
  methods: {
    getCountries() {
      this.$axios.get('countries')
        .then(res => {
          this.japan = res.data[0]
          this.countries = res.data
          this.countries.splice(0, 1)
        })
        .catch(err => console.log(err.response))
    },
    countThirty() {
      for (let i = 2; i < 31; i++) {
        let day = { name: `${i}日間`, value: i }
        this.thirty_days.push(day)
      }
    },
    async createArticle() {
      if (this.isVisibleDomestic) {
        this.article.country_id = this.japan.id
      } else {
        this.article.country_id = this.country.id
      }
      if (this.article.start_date) {
        this.article.start_date.setHours(this.article.start_date.getHours() + 9)
      }
      if (this.article.end_date) {
        this.article.end_date.setHours(this.article.end_date.getHours() + 9)
      }
      await this.$axios.post('articles', this.article)
        .then(res => {
          this.day.article_id = res.data.id
          this.article_region.article_id = res.data.id
          this.article_tag.article_id = res.data.id
        })
        .catch(err => console.log(err.response))
      await this.createRegions()
      await this.createDays()
      await this.registerTags()
      this.$router.push({
        name: 'ArticleCreateDetail',
        query: {id: this.day.article_id}
      })
    },
    async createRegions() {
      if (this.isVisibleDomestic) {
        for (let region_id of this.regionIdArrayJapan) {
          this.article_region.region_id = region_id
          await this.$axios.post('article_regions', this.article_region)
            .catch(err => console.log(err.response))
        }
      } else {
        for (let region_id of this.regionIdArray) {
          this.article_region.region_id = region_id
          await this.$axios.post('article_regions', this.article_region)
            .catch(err => console.log(err.response))
        }
      }
    },
    async createDays() {
      if (this.article.start_date && this.article.end_date) {
        var days = ( this.article.end_date - this.article.start_date ) / 86400000 + 1
      } else if (this.article.start_date && !this.article.end_date) {
        var days = 1
      } else if (!this.article.start_date && this.article.end_date) {
        var days = 1
      } else if (!this.article.start_date && !this.article.end_date) {
        var days = this.days
      }
      for (let i = 0; i < days; i++) {
        await this.$axios.post('days', this.day)
          .catch(err => console.log(err.response))
      }
    },
    async registerTags() {
      for (let tag of this.tags) {
        await this.$axios.post('tags', { name: tag })
          .then(res => {
            this.article_tag.tag_id = res.data.id
          })
          .catch(err => console.log(err.response))
        await this.$axios.post('article_tags', this.article_tag)
          .catch(err => console.log(err.response))
      }
    },
    changeToDomestic() {
      this.isVisibleOverseas = false
      this.isVisibleDomestic = true
    },
    changeToOverseas() {
      this.isVisibleDomestic = false
      this.isVisibleOverseas = true
    },
    resize(){
      this.height = 'auto'
      this.$nextTick(()=>{
        this.height = this.$refs.area.scrollHeight + 'px'
      })
    }
  }
}
</script>

<style scoped>
.top-title {
  /* border-bottom: solid #FF00EB; */
  color: #FF00EB;
}

.overview {
  border: solid #FF00EB;
  border-width: 0rem 0.3rem 0.3rem 0.3rem;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
}

.domestic-btn {
  font-size: 20px;
  background-color: #00D320;
  border: solid #00D320;
}

.domestic-btn-unselected {
  font-size: 20px;
  border: solid #00D320;
  color: #00D320;
}

.overseas-btn {
  font-size: 20px;
  background-color: #00D320;
  border: solid #00D320;
}

.overseas-btn-unselected {
  font-size: 20px;
  border: solid #00D320;
  color: #00D320;
}

.form-label {
  background-color: #6A6A6A;
  border-radius: 4px;
}

.datepicker {
  border-radius: 4px;
}

.button {
  background-color: #FF00EB;
}

.font-small {
  font-size: 13px;
}
</style>
