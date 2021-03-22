<template>
  <div class="pt-2 pl-2 pr-2 bg-white whole-border">
    <ValidationObserver v-slot="{ handleSubmit }">
      <ValidationProvider
        v-slot="{ errors }"
        rules="required|max:100"
      >
        <h5 class="col-12 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          * タイトル
        </h5>
        <input
          v-model="articleEdit.title"
          name="タイトル"
          class="form-control bg-light"
        >
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <ValidationProvider
        v-slot="{ errors }"
        rules="max:3000"
      >
        <h5 class="col-12 mt-3 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          説明
        </h5>
        <textarea
          ref="adjust_textarea"
          v-model="articleEdit.description"
          name="説明"
          class="mb-3 form-control bg-light"
          rows="1"
          @keydown="adjustHeight"
        />
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <template v-if="countryName != '日本'">
        <ValidationProvider
          v-slot="{ errors }"
          rules="country"
        >
          <h5 class="col-12 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
            * 国
          </h5>
          <v-select
            v-model="country"
            name="国"
            :options="countries"
            :get-option-label="country => country.name"
            :clearable="false"
            class="bg-light country"
          />
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>

        <h5 class="col-12 mt-3 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
          地域
        </h5>
        <v-select
          v-model="regionIdArray"
          name="地域"
          :options="country.regions"
          :reduce="region => region.id"
          :get-option-label="region => region.name"
          multiple
          class="mb-3 bg-light region"
        />
      </template>

      <template v-if="countryName == '日本'">
        <ValidationProvider
          v-slot="{ errors }"
          rules="prefecture"
        >
          <h5 class="col-12 mt-3 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
            * 都道府県
          </h5>
          <v-select
            v-model="regionIdArray"
            name="都道府県"
            :options="country.regions"
            :reduce="region => region.id"
            :get-option-label="region => region.name"
            multiple
            class="bg-light prefecture"
          />
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>
      </template>

      <h5 class="col-12 mt-3 mb-2 p-1 text-center text-white font-weight-bold article-title word-break">
        日程
      </h5>
      <div class="mb-3 d-flex align-items-center justify-content-between">
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

      <h5 class="col-12 p-1 text-center text-white font-weight-bold article-title word-break">
        タグ
      </h5>
      <v-select
        v-model="tags"
        multiple
        taggable
        class="mb-3 bg-light tag"
      >
        <span slot="no-options">タグを登録できます</span>
      </v-select>

      <h5 class="col-12 p-1 text-center text-white font-weight-bold article-title word-break">
        マップ
      </h5>
      <input
        v-model="articleEdit.map"
        name="マップ"
        class="form-control bg-light"
      >
      <p class="mb-3 text-center text-secondary font-small">
        ※HTMLコードを入力することでGoogle my mapsを埋め込むことができます。詳しくはこちら。
      </p>

      <p class="col-12 m-0 text-center text-secondary font-small">
        * 必須項目
      </p>

      <div class="text-center">
        <p
          class="btn d-inline-block pt-1 pb-1 pl-4 pr-4 mt-3 font-weight-bold edit-button"
          @click="handleSubmit(updateOverview)"
        >
          保存
        </p>
      </div>
    </ValidationObserver>
  </div>
</template>

<script>
import {ja} from 'vuejs-datepicker/dist/locale'

export default {
  name: 'EditOverview',
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
          from: '',
        },
        disabledEndDates: {
          to: '',
        },
      },
    }
  },
  watch: {
    country() {
      if (this.country.id != this.articleEdit.country.id) {
        this.regionIdArray.length = 0
      }
    },
    'articleEdit.start_date'() {
      if (this.articleEdit.start_date != null) {
        this.datepicker.disabledEndDates.to = new Date(this.articleEdit.start_date)
      } else {
        this.datepicker.disabledEndDates.to = ''
      }
    },
    'articleEdit.end_date'() {
      if (this.articleEdit.end_date != null) {
        this.datepicker.disabledStartDates.from = new Date(this.articleEdit.end_date)
      } else {
        this.datepicker.disabledStartDates.from = ''
      }
    }
  },
  created() {
    this.getCountries()
    this.articleEdit = this.article
    this.countryName = this.articleEdit.country.name
    for (let region of this.articleEdit.regions) {
      this.regionIdArray.push(region.id)
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
    },
    async updateOverview() {
      await this.deleteArticleRegions()
      await this.createArticleRegions()
      await this.deleteArticleTags()
      await this.createArticleTags()
      await this.updateArticle()
    },
    async deleteArticleRegions() {
      for (let article_region of this.articleEdit.article_regions) {
        await this.$axios.delete(`article_regions/${article_region.id}`)
      }
    },
    async createArticleRegions() {
      if (this.regionIdArray.length) {
        this.article_region.article_id = this.$route.query.id
        for (let region_id of this.regionIdArray) {
          this.article_region.region_id = region_id
          await this.$axios.post('article_regions', this.article_region)
            .catch(err => console.log(err.response))
        }
      }
    },
    async deleteArticleTags() {
      for (let article_tag of this.articleEdit.article_tags) {
        await this.$axios.delete(`article_tags/${article_tag.id}`)
          .catch(err => console.log(err.response))
      }
    },
    async createArticleTags() {
      this.article_tag.article_id = this.$route.query.id
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
    async updateArticle() {
      this.articleEdit.country_id = this.country.id
      delete this.articleEdit.country
      delete this.articleEdit.regions
      delete this.articleEdit.article_regions
      delete this.articleEdit.article_tags
      delete this.articleEdit.days
      await this.$axios.patch(`articles/${this.$route.query.id}`, this.articleEdit)
        .then(res => {
          this.$emit('updateOverview', res.data)
        })
        .catch(err => console.log(err.response))
    },
    adjustHeight(){
      let textarea = this.$refs.adjust_textarea
      let resetHeight = new Promise(function(resolve) {
        resolve(textarea.style.height = 'auto')
      })
      resetHeight.then(function(){
        textarea.style.height = textarea.scrollHeight + 'px'
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
  background-color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 4px;
}

.description-label {
  background-color: #6A6A6A;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.description-main {
  font-size: 14px;
  border: solid thin #6A6A6A;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
  border-width: 0px 0.1px 0.1px 0.1px;
}

.article-info {
  font-size: 13px;
}

.edit-button {
  color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.font-small {
  font-size: 13px;
}
</style>
