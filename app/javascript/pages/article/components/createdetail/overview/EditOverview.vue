<template>
  <div class="pt-2 pl-2 pr-2 bg-white whole-border">
    <ValidationObserver v-slot="{ handleSubmit }">
      <ValidationProvider
        v-slot="{ errors }"
        rules="required|max:100"
      >
        <p class="col-12 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          タイトル（必須）
        </p>
        <input
          v-model="articleEdit.title"
          name="タイトル"
          class="form-control bg-light"
        >
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <template v-if="countryName != '日本'">
        <ValidationProvider
          v-slot="{ errors }"
          rules="country"
        >
          <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
            国（必須）
          </p>
          <v-select
            v-model="country"
            name="国"
            :options="countries"
            :get-option-label="country => country.name"
            :clearable="false"
            class="bg-light country v-select"
            @input="getRegions"
          >
            <span slot="no-options">該当する国がありません</span>
          </v-select>
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>

        <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          地域
        </p>
        <v-select
          v-model="regionIdArray"
          name="地域"
          :options="regions"
          :reduce="region => region.id"
          :get-option-label="region => region.name"
          multiple
          class="mb-3 bg-light region v-select"
        >
          <span slot="no-options">該当する地域がありません</span>
        </v-select>
      </template>

      <template v-if="countryName == '日本'">
        <ValidationProvider
          v-slot="{ errors }"
          rules="prefecture"
        >
          <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
            都道府県（必須）
          </p>
          <v-select
            v-model="regionIdArray"
            name="都道府県"
            :options="regions"
            :reduce="region => region.id"
            :get-option-label="region => region.name"
            multiple
            class="bg-light prefecture v-select"
          >
            <span slot="no-options">該当する都道府県がありません</span>
          </v-select>
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>
      </template>

      <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
        期間
      </p>
      <div class="d-flex align-items-center justify-content-between">
        <Datepicker
          v-model="articleEdit.start_date"
          :format="datepicker.format"
          :language="datepicker.ja"
          :clear-button="datepicker.clear"
          :bootstrap-styling="datepicker.bootstrap"
          :disabled-dates="datepicker.disabledStartDates"
          input-class="text-center bg-light"
          placeholder="旅行開始日"
          name="旅行開始日"
        />
        <p class="m-0 pl-1 pr-1">
          〜
        </p>
        <Datepicker
          v-model="articleEdit.end_date"
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

      <ValidationProvider
        v-slot="{ errors }"
        rules="max:500"
      >
        <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          コメント
        </p>
        <textarea
          ref="area"
          v-model="articleEdit.description"
          :style="styles"
          name="コメント"
          class="form-control bg-light"
          rows="2"
        />
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <ValidationProvider
        v-slot="{ errors }"
        ref="provider"
        name="アイキャッチ"
        rules="image|size:5242.88"
      >
        <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          アイキャッチ
        </p>
        <template v-if="previewEyecatch">
          <div class="mb-1 image-trim">
            <img
              id="preview-eyecatch"
              :src="previewEyecatch"
            >
          </div>
        </template>
        <template v-else>
          <template v-if="eyecatch">
            <div class="mb-1 image-trim">
              <img :src="eyecatch">
            </div>
          </template>
        </template>
        <template v-if="previewEyecatch || eyecatch">
          <div class="text-center">
            <div
              id="delete-btn"
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

        <template v-if="$mq == 'xs'">
          <div class="text-center">
            <label>
              <p class="mb-0 pl-3 pr-3 file-button">
                画像を選択
              </p>
              <input
                v-if="isVisibleFileInput"
                id="eyecatch"
                type="file"
                accept="image/png,image/jpeg"
                name="アイキャッチ"
                class="d-none"
                @change="handleChange"
              >
            </label>
          </div>
        </template>
        <template v-else>
          <input
            v-if="isVisibleFileInput"
            id="eyecatch"
            type="file"
            accept="image/png,image/jpeg"
            name="アイキャッチ"
            class="form-control-file mx-auto file-input"
            @change="handleChange"
          >
        </template>
        <p class="text-center text-danger">
          {{ errors[0] }}
        </p>
      </ValidationProvider>

      <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
        タグ
      </p>
      <v-select
        v-model="tags"
        multiple
        taggable
        class="bg-light tag v-select"
      >
        <span slot="no-options">タグを登録できます</span>
      </v-select>

      <template v-if="$mq != 'xs' || !isMobile">
        <p class="col-12 mt-4 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          マップ
        </p>
        <input
          v-model="articleEdit.map"
          name="マップ"
          class="form-control bg-light"
        >
        <p class="m-0 text-center text-secondary font-small">
          ※HTMLコードを入力することでGoogle my mapsを埋め込むことができます。
          <a>
            <a class="text-muted">（</a>
            <a
              href="#"
              @click="showModal"
            >
              地図の埋め込み方
            </a>
            <a class="text-muted">）</a>
          </a>
        </p>
      </template>

      <div class="text-center">
        <template v-if="isMobile">
          <p
            class="d-inline-block pt-1 pb-1 pl-4 pr-4 mt-4 mb-4 font-weight-bold edit-button-mobile"
            @click="handleSubmit(updateOverview)"
          >
            保存
          </p>
        </template>
        <template v-else>
          <p
            class="d-inline-block pt-1 pb-1 pl-4 pr-4 mt-4 mb-4 font-weight-bold edit-button"
            @click="handleSubmit(updateOverview)"
          >
            保存
          </p>
        </template>
      </div>
    </ValidationObserver>

    <HowToEmbedMap
      ref="modal"
    />
  </div>
</template>

<script>
import {ja} from 'vuejs-datepicker/dist/locale'
import HowToEmbedMap from '../../createoverview/form/HowToEmbedMap'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'EditOverview',
  components: {
    HowToEmbedMap
  },
  props: {
    article: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      articleEdit: {},
      countries: [],
      country: {},
      regions: [],
      countryName: '',
      regionIdArray: [],
      article_region: {
        article_id: 0,
        region_id: 0,
      },
      region_id: 0,
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
      height: '',
      previewEyecatch: '',
      uploadEyecatch: '',
      eyecatch: '',
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
    country() {
      if (this.country.id != this.articleEdit.country.id) {
        this.regionIdArray = []
      }
    },
    'articleEdit.start_date'() {
      if (this.articleEdit.start_date) {
        this.datepicker.disabledEndDates.to = new Date(this.articleEdit.start_date)
        this.datepicker.disabledEndDates.from = new Date(this.articleEdit.start_date)
        this.datepicker.disabledEndDates.from.setDate(this.datepicker.disabledEndDates.from.getDate() + 13)
      } else {
        this.datepicker.disabledEndDates.to = ''
        this.datepicker.disabledEndDates.from = ''
      }
    },
    'articleEdit.end_date'() {
      if (this.articleEdit.end_date) {
        this.datepicker.disabledStartDates.from = new Date(this.articleEdit.end_date)
        this.datepicker.disabledStartDates.to = new Date(this.articleEdit.end_date)
        this.datepicker.disabledStartDates.to.setDate(this.datepicker.disabledStartDates.from.getDate() - 13)
      } else {
        this.datepicker.disabledStartDates.from = ''
        this.datepicker.disabledStartDates.to = ''
      }
    },
    'articleEdit.description'(){
      this.resize()
    },
  },
  created() {
    this.getCountries()
    this.articleEdit = this.article
    this.countryName = this.articleEdit.country.name
    for (let article_region of this.articleEdit.article_regions) {
      this.regionIdArray.push(article_region.region.id)
    }
    this.articleEdit.article_tags.sort((a, b) => {
      if (a.id < b.id) {
         return -1;
      } else {
         return 1;
      }
    })
    for (let article_tag of this.articleEdit.article_tags) {
      this.tags.push(article_tag.tag.name)
    }
    if (this.articleEdit.eyecatch_url) this.eyecatch = this.article.eyecatch_url
    this.resize()
  },
  methods:{
    async getCountries() {
      await this.$axios.get('countries')
        .then(res => {
          this.countries = res.data
          this.countries.splice(0, 1)
        })
        .catch(err => console.log(err.response))
      await this.$axios.get(`countries/${this.articleEdit.country.id}`)
        .then(res => {
          this.country = res.data
        })
        .catch(err => console.log(err.response))
      this.getRegions()
    },
    getRegions() {
      this.$axios.get(`regions/${this.country.id}`)
        .then(res => {
          this.regions = res.data
        })
        .catch(err => console.log(err.response))
    },
    async updateOverview() {
      await this.updateRegions()
      await this.updateTags()
      await this.updateArticle()
    },
    async updateRegions() {
      for (let article_region of this.articleEdit.article_regions) {
        let result = this.regionIdArray.some(regionId => {
          return regionId == article_region.region.id
        })
        if (result != true) {
          await this.$axios.delete(`article_regions/${article_region.id}`)
            .catch(err => console.log(err.response))
        }
      }

      for (let regionId of this.regionIdArray) {
        let result = this.articleEdit.article_regions.some(article_region => {
          return article_region.region.id == regionId
        })
        if (result != true) {
          this.article_region.article_id = this.$route.query.id
          this.article_region.region_id = regionId
          await this.$axios.post('article_regions', this.article_region)
            .catch(err => console.log(err.response))
        }
      }
    },
    async updateTags() {
      for (let article_tag of this.articleEdit.article_tags) {
        let result = this.tags.some(tag => {
          return tag == article_tag.tag.name
        })
        if (result != true) {
          await this.$axios.delete(`article_tags/${article_tag.id}`)
            .catch(err => console.log(err.response))
        }
      }

      for (let tag of this.tags) {
        let result = this.articleEdit.article_tags.some(article_tag => {
          return article_tag.tag.name == tag
        })
        if (result != true) {
          this.article_tag.article_id = this.$route.query.id
          await this.$axios.post('tags', { name: tag })
            .then(res => {
              this.article_tag.tag_id = res.data.id
            })
            .catch(err => console.log(err.response))
          await this.$axios.post('article_tags', this.article_tag)
            .catch(err => console.log(err.response))
        }
      }
    },
    async handleChange(event) {
      this.previewEyecatch = URL.createObjectURL(event.target.files[0])
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.uploadEyecatch = event.target.files[0]
    },
    async updateArticle() {
      this.articleEdit.country_id = this.country.id
      const formData = new FormData()
      formData.append('article[country_id]', this.articleEdit.country_id)
      formData.append('article[title]', this.articleEdit.title)
      formData.append('article[start_date]', this.articleEdit.start_date)
      formData.append('article[end_date]', this.articleEdit.end_date)
      formData.append('article[description]', this.articleEdit.description)
      formData.append('article[map]', this.articleEdit.map)
      if (this.uploadEyecatch) formData.append('article[eyecatch]', this.uploadEyecatch)

      await this.$axios.patch(`articles/${this.$route.query.id}`, formData)
        .then(res => {
          this.$emit('updateOverview', res.data)
        })
        .catch(err => console.log(err.response))
    },
    deleteEyecatch() {
      if (this.previewEyecatch) {
        this.previewEyecatch = ''
        this.uploadEyecatch = ''
        this.isVisibleFileInput = false
        this.$nextTick(() => (this.isVisibleFileInput = true))
      } else {
        this.$axios.delete(`articles/${this.$route.query.id}/delete_eyecatch`)
          .catch(err => console.log(err.response))
        this.eyecatch = ''
      }
    },
    showModal() {
      this.$refs.modal.showModal()
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
.whole-border {
  border: solid #CBCBCB;
  border-radius: 6px;
}

.word-break {
  word-break: break-word;
}

.sidebar_fixed {
  position: sticky;
  top: 100px;
}

.article-title {
  background-color: gray;
  border-radius: 4px;
}

.article-info {
  font-size: 13px;
}

.font-small {
  font-size: 13px;
}

.v-select {
  border-radius: 4px;
  background-color: #f8f9fa;
}

.file-input {
  width: 75%;
}

.file-button {
  display: inline-block;
  background-color: #fff;
  border: solid thin rgb(206, 212, 218);
  padding: 2px 25px;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.file-button:hover {
  background-color: rgb(206, 212, 218);
  position: relative;
}

.file-button-mobile {
  display: inline-block;
  background-color: #fff;
  border: solid thin rgb(206, 212, 218);
  padding: 2px 25px;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.file-button-mobile:active {
  background-color: rgb(206, 212, 218);
  position: relative;
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

.icon {
  color: gray;
  font-size: 18px;
  cursor: pointer;
}

.icon:hover {
  color: #383838;
}

.edit-button {
  color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}

.edit-button:hover {
  color: #383838;
  border: solid thin #383838;
}

.edit-button-mobile {
  color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}

.edit-button-mobile:active {
  color: #383838;
  border: solid thin #383838;
}
</style>
