<template>
  <div class="container-fluid">
    <div class="row pl-3 pr-3">
      <template v-if="$mq == 'lg'">
        <template v-if="article">
          <template v-if="days.length">
            <div class="col-8 pt-4 pb-5 pl-0 main">
              <SwitchButton
                ref="button"
                :days="days"
                class="text-center"
                @showMainColumn="showMainColumnLg"
                @deleteDay="deleteDay"
                @addDay="addDay"
                @showOverview="showOverviewLg"
              />
              <div class="row pl-3 pr-3">
                <BlockList
                  ref="list"
                  :days="days"
                  :currency="currency"
                  class="col-12 pt-4 pb-0 pl-4 pr-4 main-column"
                  @getArticle="getArticle"
                  @getArticleAndCloseForm="getArticleAndCloseForm"
                />
              </div>
              <div class="d-flex justify-content-center pl-3 pr-3 mb-4">
                <Overview
                  ref="overview"
                  :article="article"
                  class="overview-column"
                />
              </div>
            </div>
            <div class="col-4 pb-5 pr-0 main block-form">
              <BlockForm
                v-if="isVisibleForm"
                ref="form"
                :dayid="day_id"
                :currency="currency"
                :blockcount="blockcount"
                @addBlock="addBlock"
              />
              <SaveButton
                :state="article.status"
                :country="article.country.name"
              />
            </div>
          </template>
        </template>

        <template v-else>
          <vue-loading
            type="spiningDubbles"
            color="#FF58F2"
            :size="{ width: '100px' }"
            class="mt-5 pt-5"
          />
        </template>
      </template>

      <template v-else-if="$mq == 'sm'">
        <template v-if="article">
          <template v-if="days.length">
            <div class="col-12 pt-1 pl-5 pr-5">
              <SaveButton
                :state="article.status"
                :country="article.country.name"
                class="mt-4 ml-5 mr-5"
              />
            </div>
            <div class="col-12 pt-4 pl-5 pr-5">
              <SwitchButton
                ref="button"
                :days="days"
                class="ml-5 mr-5 text-center"
                @showMainColumn="showMainColumn"
                @deleteDay="deleteDay"
                @addDay="addDay"
                @showOverview="showOverview"
              />
              <BlockList
                ref="list"
                :days="days"
                :currency="currency"
                class="ml-5 mr-5 pt-4 pb-0 pr-4 pl-4 main-column"
                @getArticle="getArticle"
                @getArticleAndCloseForm="getArticleAndCloseForm"
              />
              <div class="d-flex justify-content-center pl-3 pr-3 mb-5">
                <Overview
                  ref="overview"
                  :article="article"
                  class="overview-column"
                />
              </div>
            </div>
            <div class="col-12 pt-1 pb-5 pl-5 pr-5">
              <BlockForm
                v-if="isVisibleForm"
                ref="form"
                :dayid="day_id"
                :currency="currency"
                :blockcount="blockcount"
                class="ml-5 mr-5"
                @addBlock="addBlock"
              />
            </div>
          </template>
        </template>

        <template v-else>
          <vue-loading
            type="spiningDubbles"
            color="#FF58F2"
            :size="{ width: '100px' }"
            class="mt-5 pt-5"
          />
        </template>
      </template>

      <template v-else>
        <template v-if="article">
          <template v-if="days.length">
            <div class="col-12 pt-1 pl-0 pr-0">
              <SaveButton
                :state="article.status"
                :country="article.country.name"
                class="mt-4"
              />
            </div>
            <div class="col-12 pt-4 pr-0 pl-0">
              <SwitchButton
                ref="button"
                :days="days"
                class="text-center"
                @showMainColumn="showMainColumn"
                @deleteDay="deleteDay"
                @addDay="addDay"
                @showOverview="showOverview"
              />
              <BlockList
                ref="list"
                :days="days"
                :currency="currency"
                @getArticle="getArticle"
                @getArticleAndCloseForm="getArticleAndCloseForm"
              />
              <div class="row pl-3 pr-3 mb-5">
                <Overview
                  ref="overview"
                  :article="article"
                  class="col-12 p-0"
                />
              </div>
            </div>
            <div class="col-12 mb-5 pb-5 pl-0 pr-0">
              <BlockForm
                v-if="isVisibleForm"
                ref="form"
                :dayid="day_id"
                :currency="currency"
                :blockcount="blockcount"
                @addBlock="addBlock"
              />
            </div>
          </template>
        </template>

        <template v-else>
          <vue-loading
            type="spiningDubbles"
            color="#FF58F2"
            :size="{ width: '80px' }"
            class="mt-5 pt-5"
          />
        </template>
      </template>
    </div>
  </div>
</template>

<script>
import BlockList from './components/createdetail/BlockList'
import Overview from './components/createdetail/Overview'
import SwitchButton from './components/createdetail/SwitchButton'
import BlockForm from './components/createdetail/BlockForm'
import SaveButton from './components/edit/SaveButton'

export default {
  name: 'ArticleEdit',
  components: {
    BlockList,
    Overview,
    SwitchButton,
    BlockForm,
    SaveButton
  },
  data() {
    return {
      article: null,
      days: [],
      currency: '',
      day_id: 0,
      day: {
        article_id: null,
      },
      block_id: null,
      spendings: [],
      blockAndCost: {},
      isVisibleForm: true,
      blockcount: 0
    }
  },
  watch: {
    article: {
      handler() {
        this.currency = this.article.country.currency
        this.days = this.article.days
        for (let day of this.article.days) {
          if (day.id == this.day_id) {
            this.blockcount = day.ordered_blocks.length
          }
        }
      },
    }
  },
  created() {
    this.getArticleAndSetDayId()
    this.day.article_id = this.$route.query.id
  },
  methods :{
    async getArticleAndSetDayId() {
      await this.$axios.get(`articles/${this.$route.query.id}`)
        .then(res => {
          this.article = res.data
          this.day_id = res.data.days[0].id
          for (let i = 0; i < this.article.days.length; i++) {
            this.article.days[i].number = i + 1
          }
        })
        .catch(err => console.log(err.response))
    },
    getArticle() {
      this.$axios.get(`articles/${this.$route.query.id}`)
        .then(res => {
          this.article = res.data
          for (let i = 0; i < this.article.days.length; i++) {
            this.article.days[i].number = i + 1
          }
        })
        .catch(err => console.log(err.response))
    },
    async getArticleAndCloseForm() {
      await this.$axios.get(`articles/${this.$route.query.id}`)
        .then(res => {
          this.article = res.data
          for (let i = 0; i < this.article.days.length; i++) {
            this.article.days[i].number = i + 1
          }
        })
        .catch(err => console.log(err.response))
      this.$refs.list.closeBlockEditForm()
    },
    async addDay() {
      await this.$axios.post('days', this.day)
        .catch(err => console.log(err.response))
      this.getArticle()
    },
    async deleteDay(day) {
      if (confirm(`${day.number}日目を削除しますか？`)) {
        await this.$axios.delete(`days/${day.id}`)
          .catch(err => console.log(err.response))
        await this.getArticleAndSetDayId()
        this.$refs.button.resetDayNum()
        this.$refs.list.changeNumber(1)
      }
    },
    async addBlock(blockAndCost) {
      this.blockAndCost = Object.assign({}, blockAndCost)
      const formData = new FormData()
      formData.append('block[day_id]', this.blockAndCost.block.day_id)
      formData.append('block[title]', this.blockAndCost.block.title)
      if (this.blockAndCost.block.place) formData.append('block[place]', this.blockAndCost.block.place)
      if (this.blockAndCost.block.place_info) formData.append('block[place_info]', this.blockAndCost.block.place_info)
      if (this.blockAndCost.block.comment) formData.append('block[comment]', this.blockAndCost.block.comment)
      if (this.blockAndCost.block.arriving_time) formData.append('block[arriving_time]', this.blockAndCost.block.arriving_time)
      if (this.blockAndCost.block.leaving_time) formData.append('block[leaving_time]', this.blockAndCost.block.leaving_time)
      if (this.blockAndCost.block.uploadImage) formData.append('block[image]', this.blockAndCost.block.uploadImage)

      await this.$axios.post('blocks', formData)
        .then(res => {
          this.block_id = res.data.id
        })
        .catch(err => console.log(err.response))
      for (let spending of this.blockAndCost.spendings) {
        if (spending.description) {
          spending.block_id = this.block_id
          await this.$axios.post('spendings', spending)
            .catch(err => console.log(err.response))
        }
      }
      for (let transportation of this.blockAndCost.transportations) {
        if (transportation.means) {
          transportation.block_id = this.block_id
          await this.$axios.post('transportations', transportation)
            .catch(err => console.log(err.response))
        }
      }
      this.getArticle()
      this.isVisibleForm = false
      this.$nextTick(() => (this.isVisibleForm = true))
    },
    async showMainColumn(day) {
      await this.getArticle()
      this.$refs.overview.closeOverview()
      this.$refs.list.changeNumber(day.number)
      this.$refs.form.showForm()
      this.day_id = day.id
      this.isVisibleOverview = false
      this.isVisibleMainColumn = true
    },
    showOverview() {
      this.day_id = 0
      this.$refs.list.closeBlockList()
      this.$refs.form.closeForm()
      this.$refs.overview.showOverview()
    },
    async showMainColumnLg(day) {
      await this.getArticle()
      this.$refs.overview.closeOverview()
      this.$refs.list.changeNumber(day.number)
      this.$refs.form.openAddBlockButton()
      this.day_id = day.id
      this.isVisibleOverview = false
      this.isVisibleMainColumn = true
    },
    showOverviewLg() {
      this.day_id = 0
      this.$refs.list.closeBlockList()
      this.$refs.form.closeAddBlockButton()
      this.$refs.overview.showOverview()
    }
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 1000px;
}

.main {
  max-height: 100vh;
  overflow: auto;
}

.box {
  height: 150vh;
}

.main-column {
  background-color: white;
  border: solid #00D320;
  border-radius: 6px;
}

.overview-column {
  width: 400px;
}

.block-list {
  background-color: white;
  border: solid #00D320;
  border-radius: 6px;
}

.block-form {
  padding-top: 54px;
}
</style>
