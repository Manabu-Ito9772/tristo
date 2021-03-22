<template>
  <div class="container-fluid mt-4">
    <template v-if="$mq == 'lg'">
      <div class="row">
        <div class="col-8 text-center">
          <SwitchButton
            :article="article"
            @showMainColumn="showMainColumn"
            @showCostColumn="showCostColumn"
            @showMapColumn="showMapColumn"
          />
        </div>
        <div class="col-8">
          <div
            v-for="day in article.days"
            :key="day.id"
          >
            <MainColumn
              v-if="dayNumber == day.number"
              :blocks="day.blocks"
            />
          </div>
        </div>
        <CostColumn
          v-if="isVisibleCostColumn"
          :days="article.days"
          class="col-8"
        />
        <MapColumn
          v-if="isVisibleMapColumn"
          :map="article.map"
          class="col-8"
        />
        <div class="col-4">
          <div class="sidebar-fixed">
            <div class="row pl-3 pr-3">
              <SideColumn
                :article="article"
                :countryname="countryname"
              />
            </div>
          </div>
        </div>
      </div>
    </template>

    <template v-else-if="$mq == 'sm'">
      <div class="row">
        <div class="col-12">
          <div class="row d-flex justify-content-center pl-3 pr-3 ml-sm-5 mr-sm-5 pl-sm-5 pr-sm-5">
            <SideColumn
              :article="article"
              :countryname="countryname"
            />
          </div>
        </div>
        <div class="col-12 text-center mt-4">
          <SwitchButton
            :article="article"
            class="ml-5 mr-5 pl-5 pr-5"
            @showMainColumn="showMainColumn"
            @showCostColumn="showCostColumn"
            @showMapColumn="showMapColumn"
          />
        </div>
        <div class="col-12">
          <div
            v-for="day in article.days"
            :key="day.id"
          >
            <MainColumn
              v-if="dayNumber == day.number"
              :blocks="day.blocks"
              class="ml-5 mr-5 pl-5 pr-5"
            />
          </div>
        </div>
        <CostColumn
          v-if="isVisibleCostColumn"
          :days="article.days"
          class="col-12"
        />
        <MapColumn
          v-if="isVisibleMapColumn"
          :map="article.map"
          class="col-12"
        />
      </div>
    </template>

    <template v-else>
      <div class="row">
        <div class="col-12">
          <div class="row pl-3 pr-3">
            <SideColumn
              :article="article"
              :countryname="countryname"
            />
          </div>
        </div>
        <div class="col-12 text-center mt-4">
          <SwitchButton
            :article="article"
            @showMainColumn="showMainColumn"
            @showCostColumn="showCostColumn"
            @showMapColumn="showMapColumn"
          />
        </div>
        <div class="col-12">
          <div
            v-for="day in article.days"
            :key="day.id"
          >
            <MainColumn
              v-if="dayNumber == day.number"
              :blocks="day.blocks"
              class="pb-4"
            />
          </div>
        </div>
        <CostColumn
          v-if="isVisibleCostColumn"
          :days="article.days"
          class="col-12 mb-5 pb-5"
        />
        <MapColumn
          v-if="isVisibleMapColumn"
          :map="article.map"
          class="col-12 mb-5 pb-5"
        />
      </div>
    </template>
  </div>
</template>

<script>
import MainColumn from './components/show/MainColumn'
import SideColumn from './components/show/SideColumn'
import CostColumn from './components/show/CostColumn'
import MapColumn from './components/show/MapColumn'
import SwitchButton from './components/show/SwitchButton'

export default {
  name: 'ArticleShow',
  components: {
    MainColumn,
    SideColumn,
    CostColumn,
    MapColumn,
    SwitchButton
  },
  data() {
    return {
      article: {},
      countryname: '',
      dayNumber: 1,
      isVisibleCostColumn: false,
      isVisibleMapColumn: false
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
          this.countryname = res.data.country.name
          for (let i = 0; i < this.article.days.length; i++) {
            this.article.days[i].number = i + 1
          }
        })
        .catch(err => console.log(err.response))
    },
    showMainColumn(dayNumber) {
      this.dayNumber = dayNumber
      this.isVisibleCostColumn = false
      this.isVisibleMapColumn = false
    },
    showCostColumn() {
      this.dayNumber = null
      this.isVisibleMapColumn = false
      this.isVisibleCostColumn = true
    },
    showMapColumn() {
      this.dayNumber = null
      this.isVisibleCostColumn = false
      this.isVisibleMapColumn = true
    },
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 1000px;
  margin-right: auto;
  margin-left: auto;
}

.sidebar-fixed {
  position: sticky;
  top: 100px;
}
</style>
