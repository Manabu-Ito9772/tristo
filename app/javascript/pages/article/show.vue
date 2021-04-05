<template>
  <div class="container-fluid">
    <template v-if="$mq == 'lg'">
      <div
        v-scroll-lock="fixScroll"
        class="row"
      >
        <div class="col-8 pb-4 main">
          <SwitchButton
            :article="article"
            class="text-center mt-4"
            @showBlockList="showBlockList"
            @showCost="showCost"
            @showGmap="showGmap"
            @showComment="showComment"
          />
          <div
            v-for="day in article.days"
            :key="day.id"
          >
            <BlockList
              v-if="dayNumber == day.number"
              :blocks="day.ordered_blocks"
              :currency="article.country.currency"
            />
          </div>
          <Cost
            v-if="isVisibleCost"
            :days="article.days"
            :currency="article.country.currency"
          />
          <Gmap
            v-if="isVisibleGmap"
            :map="article.map"
          />
          <CommentArea
            v-if="isVisibleComment"
          />
        </div>
        <div class="col-4 pb-5 main side-column">
          <div class="row mt-4 pl-3 pr-3">
            <Overview
              :article="article"
              :countryname="countryname"
              :user="user"
              @fixPage="fixPage"
              @flowPage="flowPage"
            />
          </div>
        </div>
      </div>
    </template>

    <template v-else-if="$mq == 'sm'">
      <div
        v-scroll-lock="fixScroll"
        class="row mt-4 pb-4"
      >
        <div class="col-12">
          <div class="row d-flex justify-content-center pl-3 pr-3 ml-sm-5 mr-sm-5 pl-sm-5 pr-sm-5">
            <Overview
              :article="article"
              :countryname="countryname"
              :user="user"
              class="front-top"
              @fixPage="fixPage"
              @flowPage="flowPage"
            />
          </div>
        </div>
        <div class="col-12 text-center mt-4">
          <SwitchButton
            :article="article"
            class="ml-5 mr-5 pl-5 pr-5"
            @showBlockList="showBlockList"
            @showCost="showCost"
            @showGmap="showGmap"
            @showComment="showComment"
          />
        </div>
        <div class="col-12">
          <div
            v-for="day in article.days"
            :key="day.id"
          >
            <BlockList
              v-if="dayNumber == day.number"
              :blocks="day.ordered_blocks"
              :currency="article.country.currency"
              class="ml-5 mr-5 pl-5 pr-5"
            />
          </div>
        </div>
        <Cost
          v-if="isVisibleCost"
          :days="article.days"
          :currency="article.country.currency"
          class="col-12"
        />
        <Gmap
          v-if="isVisibleGmap"
          :map="article.map"
          class="col-12"
        />
        <CommentArea
          v-if="isVisibleComment"
          class="col-12"
        />
      </div>
    </template>

    <template v-else>
      <div
        v-scroll-lock="fixScroll"
        class="row mt-4 pb-4"
      >
        <div class="col-12">
          <div class="row pl-3 pr-3">
            <Overview
              :article="article"
              :countryname="countryname"
              :user="user"
              class="front-top"
              @fixPage="fixPage"
              @flowPage="flowPage"
            />
          </div>
        </div>
        <div class="col-12 text-center mt-4">
          <SwitchButton
            :article="article"
            @showBlockList="showBlockList"
            @showCost="showCost"
            @showGmap="showGmap"
            @showComment="showComment"
          />
        </div>
        <div class="col-12">
          <div
            v-for="day in article.days"
            :key="day.id"
          >
            <BlockList
              v-if="dayNumber == day.number"
              :blocks="day.ordered_blocks"
              :currency="article.country.currency"
              class="pb-4"
            />
          </div>
        </div>
        <Cost
          v-if="isVisibleCost"
          :days="article.days"
          :currency="article.country.currency"
          class="col-12 mb-5 pb-5"
        />
        <Gmap
          v-if="isVisibleGmap"
          :map="article.map"
          class="col-12 mb-5 pb-5"
        />
        <CommentArea
          v-if="isVisibleComment"
          class="col-12 mb-5 pb-5 pl-4 pr-4"
        />
      </div>
    </template>
  </div>
</template>

<script>
import BlockList from './components/show/BlockList'
import Overview from './components/show/Overview'
import SwitchButton from './components/show/SwitchButton'
import Cost from './components/show/Cost'
import Gmap from './components/show/Gmap'
import CommentArea from './components/show/CommentArea'

export default {
  name: 'ArticleShow',
  components: {
    BlockList,
    Overview,
    SwitchButton,
    Cost,
    Gmap,
    CommentArea
  },
  data() {
    return {
      article: {},
      user: {},
      countryname: '',
      dayNumber: 1,
      isVisibleCost: false,
      isVisibleGmap: false,
      isVisibleComment: false,
      fixScroll: false,
    }
  },
  created() {
    this.getArticle()
  },
  methods :{
    getArticle() {
      this.$axios.get(`articles/${this.$route.query.id}`)
        .then(res => {
          this.article = res.data
          this.user = res.data.user
          this.countryname = res.data.country.name
          for (let i = 0; i < this.article.days.length; i++) {
            this.article.days[i].number = i + 1
          }
        })
        .catch(err => console.log(err.response))
    },
    showBlockList(dayNumber) {
      this.dayNumber = dayNumber
      this.isVisibleCost = false
      this.isVisibleGmap = false
      this.isVisibleComment = false
    },
    showCost() {
      this.dayNumber = null
      this.isVisibleGmap = false
      this.isVisibleComment = false
      this.isVisibleCost = true
    },
    showGmap() {
      this.dayNumber = null
      this.isVisibleCost = false
      this.isVisibleComment = false
      this.isVisibleGmap = true
    },
    showComment() {
      this.dayNumber = null
      this.isVisibleCost = false
      this.isVisibleGmap = false
      this.isVisibleComment = true
    },
    fixPage() {
      this.fixScroll = true
    },
    flowPage() {
      this.fixScroll = false
    },
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

.side-column {
  padding-top: 46px;
}

.front-top {
  z-index: 1;
}
</style>
