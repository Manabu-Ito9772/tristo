<template>
  <div class="row padding-bottom">
    <h3 class="col-12 p-2 m-0 text-center text-white font-weight-bold top-title">
      旅行記録作成
    </h3>
    <div class="col-12 overview bg-white">
      <div class="row pt-4 pb-4 pl-3 pr-3">
        <div class="col-6 pl-0 pr-2">
          <div
            v-if="isVisibleDomestic"
            class="p-0 w-100 text-center text-white font-weight-bold domestic-btn"
          >
            国内
          </div>
          <div
            v-if="isVisibleOverseas"
            class="p-0 w-100 text-center font-weight-bold domestic-btn-unselected"
            @click="changeToDomestic"
          >
            国内
          </div>
        </div>
        <div class="col-6 pr-0 pl-2">
          <div
            v-if="isVisibleOverseas"
            class="p-0 w-100 text-center text-white font-weight-bold domestic-btn"
          >
            海外
          </div>
          <div
            v-if="isVisibleDomestic"
            class="p-0 w-100 text-center font-weight-bold domestic-btn-unselected"
            @click="changeToOverseas"
          >
            海外
          </div>
        </div>
      </div>

      <ValidationObserver v-slot="{ handleSubmit }">
        <div class="form-group m-0">
          <ValidationProvider
            v-slot="{ errors }"
            rules="required|max:100"
          >
            <h5
              id="タイトル"
              class="p-1 text-center text-white font-weight-bold form-label"
            >
              タイトル（必須）
            </h5>
            <input
              v-model="article.title"
              name="タイトル"
              class="form-control bg-light"
            >
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>
        </div>

        <div
          v-if="isVisibleOverseas"
          class="form-group mt-4"
        >
          <ValidationProvider
            v-slot="{ errors }"
            rules="country"
          >
            <h5
              class="p-1 text-center text-white font-weight-bold form-label"
            >
              国（必須）
            </h5>
            <v-select
              v-model="country"
              :options="countries"
              :get-option-label="country => country.name"
              :clearable="false"
              class="country v-select"
              @input="getRegions"
            >
              <span slot="no-options">該当する国がありません</span>
            </v-select>
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>
        </div>

        <template v-if="isVisibleOverseas">
          <div class="form-group mt-4">
            <h5
              class="p-1 text-center text-white font-weight-bold form-label"
            >
              地域
            </h5>
            <v-select
              v-model="regionIdArray"
              :options="regions"
              :reduce="region => region.id"
              :get-option-label="region => region.name"
              multiple
              class="region v-select"
            >
              <span slot="no-options">該当する地域がありません</span>
            </v-select>
          </div>
        </template>

        <template v-else>
          <div class="form-group mt-4">
            <ValidationProvider
              v-slot="{ errors }"
              rules="prefecture"
            >
              <h5
                class="p-1 text-center text-white font-weight-bold form-label"
              >
                都道府県（必須）
              </h5>
              <v-select
                v-model="regionIdArray"
                :options="prefectures"
                :reduce="prefecture => prefecture.id"
                label="name"
                multiple
                class="prefecture v-select"
              >
                <span slot="no-options">該当する都道府県がありません</span>
              </v-select>
              <span class="text-danger">{{ errors[0] }}</span>
            </ValidationProvider>
          </div>
        </template>

        <div class="form-group mt-4">
          <h5 class="p-1 text-center text-white font-weight-bold form-label">
            期間
          </h5>
          <div class="d-flex align-items-center justify-content-between">
            <Datepicker
              v-model="article.start_date"
              :format="datepicker.format"
              :language="datepicker.ja"
              :clear-button="datepicker.clear"
              :bootstrap-styling="datepicker.bootstrap"
              :disabled-dates="datepicker.disabledStartDates"
              input-class="text-center bg-light"
              placeholder="旅行開始日"
              name="旅行開始日"
            />
            <h5 class="pl-2 pr-2 m-0">
              〜
            </h5>
            <Datepicker
              v-model="article.end_date"
              :format="datepicker.format"
              :language="datepicker.ja"
              :clear-button="datepicker.clear"
              :bootstrap-styling="datepicker.bootstrap"
              :disabled-dates="datepicker.disabledEndDates"
              input-class="text-center bg-light"
              placeholder="旅行終了日"
              name="旅行終了日"
            />
          </div>
          <template v-if="!article.start_date && !article.end_date">
            <div class="text-center mt-3">
              <p class="p-1 m-0 d-inline text-center text-muted font-weight-bold">
                日数のみ入力
              </p>
            </div>
            <div class="text-center">
              <select
                v-model="days"
                name="日数"
                class="d-inline form-control w-25 bg-light"
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

        <div class="form-group mt-4">
          <ValidationProvider
            v-slot="{ errors }"
            rules="max:500"
          >
            <h5
              id="コメント"
              class="p-1 text-center text-white font-weight-bold form-label"
            >
              コメント
            </h5>
            <textarea
              ref="area"
              v-model="article.description"
              :style="styles"
              name="コメント"
              class="form-control bg-light"
              rows="2"
            />
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>
        </div>

        <div class="form-group mt-4">
          <ValidationProvider
            v-slot="{ errors }"
            ref="provider"
            name="アイキャッチ"
            rules="image|size:5242.88"
          >
            <h5
              id="アイキャッチ"
              class="p-1 text-center text-white font-weight-bold form-label"
            >
              アイキャッチ
            </h5>
            <template v-if="previewEyecatch">
              <div class="mb-1 image-trim">
                <img
                  id="preview-eyecatch"
                  :src="previewEyecatch"
                >
              </div>
              <div class="text-center">
                <div
                  class="d-inline-block mb-2 icon"
                  @click="deleteEyecatch"
                >
                  <font-awesome-icon
                    :icon="['far', 'times-circle']"
                    class="fa-lg"
                  />
                </div>
              </div>
            </template>
            <input
              v-if="isVisibleFileInput"
              id="eyecatch"
              type="file"
              accept="image/png,image/jpeg"
              name="アイキャッチ"
              class="form-control-file mx-auto file-input"
              @change="handleChange"
            >
            <p class="text-center text-danger">
              {{ errors[0] }}
            </p>
          </ValidationProvider>
        </div>

        <div class="form-group mt-4 mb-3">
          <h5 class="p-1 text-center text-white font-weight-bold form-label">
            タグ
          </h5>
          <v-select
            v-model="tags"
            multiple
            taggable
            class="tag v-select"
          >
            <span slot="no-options">タグを登録できます</span>
          </v-select>
        </div>

        <div class="form-group mt-4 mb-0">
          <h5 class="p-1 text-center text-white font-weight-bold form-label">
            マップ
          </h5>
          <input
            v-model="article.map"
            name="マップ"
            class="form-control bg-light"
          >
          <p class="mb-0 text-center text-secondary font-small">
            ※Google My MapsのHTMLを入力することで地図を埋め込むことができます。
          </p>
          <p class="text-center text-muted font-small">
            （
            <a
              href="#"
              class="d-inline-block"
              @click="showModal"
            >
              地図の埋め込み方
            </a>
            ）
          </p>
        </div>

        <div class="pt-4 pb-4 text-center">
          <template v-if="isMobile">
            <div
              class="text-white font-weight-bold button-mobile"
              @click="handleSubmit(createArticleAndRelation)"
            >
              詳細入力ページへ進む
            </div>
          </template>
          <template v-else>
            <div
              class="text-white font-weight-bold button"
              @click="handleSubmit(createArticleAndRelation)"
            >
              詳細入力ページへ進む
            </div>
          </template>
        </div>
      </ValidationObserver>
    </div>

    <HowToEmbedMap
      ref="modal"
    />
  </div>
</template>

<script>
import HowToEmbedMap from './form/HowToEmbedMap'
import {ja} from 'vuejs-datepicker/dist/locale'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'OverviewForm',
  components: {
    HowToEmbedMap
  },
  data() {
    return {
      isVisibleDomestic: true,
      isVisibleOverseas: false,
      countries: [],
      country: null,
      regions: [],
      prefectures: [],
      regionIdArray: [],
      article_region: {
        article_id: 0,
        region_id: 0,
      },
      article: {
        country_id: '',
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
          to: '',
          from: ''
        },
        disabledEndDates: {
          to: '',
          from: ''
        },
      },
      thirty_days: [
        { name: '日帰り', value: 1 },
      ],
      height: '',
      previewEyecatch: '',
      uploadEyecatch: '',
      isVisibleFileInput: true,
      isMobile: isMobile
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
      if (this.article.start_date) {
        this.datepicker.disabledEndDates.to = this.article.start_date
        this.datepicker.disabledEndDates.from = new Date(this.article.start_date)
        this.datepicker.disabledEndDates.from.setDate(this.datepicker.disabledEndDates.from.getDate() + 13)
      } else {
        this.datepicker.disabledEndDates.to = ''
        this.datepicker.disabledEndDates.from = ''
      }
    },
    'article.end_date'() {
      if (this.article.end_date) {
        this.datepicker.disabledStartDates.from = this.article.end_date
        this.datepicker.disabledStartDates.to = new Date(this.article.end_date)
        this.datepicker.disabledStartDates.to.setDate(this.datepicker.disabledStartDates.from.getDate() - 13)
      } else {
        this.datepicker.disabledStartDates.from = ''
        this.datepicker.disabledStartDates.to = ''
      }
    },
    'article.description'(){
      this.resize()
    },
    country() {
      this.regionIdArray = []
    }
  },
  created() {
    this.getCountries()
    this.getPrefectures()
    this.countThirty()
    this.scrollTop()
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
      this.$axios.get(`regions/${this.country.id}`)
        .then(res => {
          this.regions = res.data
        })
        .catch(err => console.log(err.response))
    },
    getPrefectures() {
      this.$axios.get(`regions/1`)
        .then(res => {
          this.prefectures = res.data
        })
        .catch(err => console.log(err.response))
    },
    countThirty() {
      for (let i = 2; i < 15; i++) {
        let day = { name: `${i}日間`, value: i }
        this.thirty_days.push(day)
      }
    },
    async handleChange(event) {
      this.previewEyecatch = URL.createObjectURL(event.target.files[0])
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.uploadEyecatch = event.target.files[0]
    },
    async createArticleAndRelation() {
      if (this.isVisibleDomestic) {
        this.article.country_id = 1
      } else {
        this.article.country_id = this.country.id
      }

      const formData = new FormData()
      formData.append('article[country_id]', this.article.country_id)
      formData.append('article[title]', this.article.title)
      if (this.article.description) formData.append('article[description]', this.article.description)
      if (this.article.map) formData.append('article[map]', this.article.map)
      if (this.article.start_date) formData.append('article[start_date]', this.article.start_date)
      if (this.article.end_date) formData.append('article[end_date]', this.article.end_date)
      if (this.uploadEyecatch) formData.append('article[eyecatch]', this.uploadEyecatch)

      await this.$axios.post('articles', formData)
        .then(res => {
          this.day.article_id = res.data.id
          this.article_region.article_id = res.data.id
          this.article_tag.article_id = res.data.id
        })
        .then(async() => {
          await this.createRegions()
          await this.createDays()
          await this.registerTags()
        })
        .then(() => {
          this.$store.commit('pages/setCurrentPage', 'create')
          this.$router.push({
            name: 'ArticleCreateDetail',
            query: {id: this.day.article_id}
          })
        })
        .catch(err => console.log(err.response))
    },
    async createRegions() {
      for (let region_id of this.regionIdArray) {
        this.article_region.region_id = region_id
        await this.$axios.post('article_regions', this.article_region)
          .catch(err => console.log(err.response))
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
      this.regionIdArray = []
    },
    changeToOverseas() {
      this.isVisibleDomestic = false
      this.isVisibleOverseas = true
      this.country = null
      this.regionIdArray = []
    },
    showModal() {
      this.$refs.modal.showModal()
    },
    deleteEyecatch() {
      this.previewEyecatch = ''
      this.uploadEyecatch = ''
      this.isVisibleFileInput = false
      this.$nextTick(() => (this.isVisibleFileInput = true))
    },
    resize(){
      this.height = 'auto'
      this.$nextTick(()=>{
        this.height = this.$refs.area.scrollHeight + 'px'
      })
    },
    scrollTop() {
      window.scrollTo({
        top: 0,
        behavior: 'instant'
      })
    }
  }
}
</script>

<style scoped>
.top-title {
  background-color: #DF81A2;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.overview {
  border: solid #DF81A2;
  border-width: 0rem 0.3rem 0.3rem 0.3rem;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
}

.domestic-btn {
  font-size: 20px;
  background-color: #81D674;
  border: solid #81D674;
  border-radius: 4px;
  cursor: pointer;
}

.domestic-btn-unselected {
  font-size: 20px;
  border: solid #81D674;
  color: #81D674;
  border-radius: 4px;
  cursor: pointer;
}

.form-label {
  background-color: gray;
  border-radius: 4px;
}

.datepicker {
  border-radius: 4px;
}

.button {
  display: inline-block;
  background-color: #DF81A2;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 4px;
}

.button:hover {
  background-color: #BE6081;
  position: relative;
}

.button-mobile {
  display: inline-block;
  background-color: #DF81A2;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 4px;
}

.button-mobile:active {
  background-color: #BE6081;
  position: relative;
}

.font-small {
  font-size: 13px;
}

.v-select {
  border-radius: 4px;
  background-color: #f8f9fa;
}

.file-input {
  width: 65%;
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

.pointer {
  cursor: pointer;
}

.icon {
  color: gray;
  font-size: 18px;
  cursor: pointer;
}

.icon:hover {
  color: #383838;
}

.padding-bottom {
  padding-bottom: 150px;
}
</style>
