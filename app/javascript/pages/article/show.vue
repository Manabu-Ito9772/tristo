<template>
  <div class="container-fluid mt-4">
    <template v-if="$mq == 'lg'">
      <div class="row">
        <div class="col-8 text-center">
          <SwitchButton
            :article="articleDetail"
            @showMainColumn="showMainColumn"
            @showCostColumn="showCostColumn"
            @showMapColumn="showMapColumn"
          />
        </div>
        <div class="col-8">
          <div
            v-for="day in articleDetail.days"
            :key="day.id"
          >
            <MainColumn
              v-if="dayNumber == day.number"
              :blocks="day.info_blocks"
            />
          </div>
        </div>
        <CostColumn
          v-if="isVisibleCostColumn"
          :days="articleDetail.days"
          class="col-8"
        />
        <MapColumn
          v-if="isVisibleMapColumn"
          :map="articleDetail.map"
          class="col-8"
        />
        <div class="col-4">
          <div class="row pl-3 pr-3">
            <SideColumn
              :article="articleDetail"
            />
          </div>
        </div>
      </div>
    </template>
    <template v-else>
      <div class="row">
        <div class="col-12">
          <template v-if="$mq == 'sm'">
            <div class="row pl-3 pr-3 ml-sm-5 mr-sm-5 pl-sm-5 pr-sm-5">
              <SideColumn
                :article="articleDetail"
              />
            </div>
          </template>
          <template v-else>
            <div class="row pl-3 pr-3">
              <SideColumn
                :article="articleDetail"
              />
            </div>
          </template>
        </div>
        <div class="col-12 mt-4">
          <div class="row">
            <div class="col-12 text-center">
              <SwitchButton
                :article="articleDetail"
                @showMainColumn="showMainColumn"
                @showCostColumn="showCostColumn"
                @showMapColumn="showMapColumn"
              />
            </div>
          </div>
        </div>
        <div class="col-12">
          <div
            v-for="day in articleDetail.days"
            :key="day.id"
          >
            <MainColumn
              v-if="dayNumber == day.number"
              :blocks="day.info_blocks"
            />
          </div>
        </div>
        <CostColumn
          v-if="isVisibleCostColumn"
          :days="articleDetail.days"
          class="col-12"
        />
        <template v-if="$mq == 'xs'">
          <MapColumn
            v-if="isVisibleMapColumn"
            :map="articleDetail.map"
            class="col-12 p-0"
          />
        </template>
        <template v-else>
          <MapColumn
            v-if="isVisibleMapColumn"
            :map="articleDetail.map"
            class="col-12"
          />
        </template>
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
import { mapGetters, mapActions } from 'vuex'

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
      dayNumber: 1,
      isVisibleCostColumn: false,
      isVisibleMapColumn: false
    }
  },
  computed: {
    ...mapGetters('articles', [
      'articleDetail'
    ]),
  },
  created() {
    this.getArticleDetail(this.$route.query.id)
  },
  methods :{
    ...mapActions('articles', [
      'getArticleDetail'
    ]),
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
</style>
