<template>
  <div class="container-fluid mt-4">
    <template v-if="$mq == 'lg'">
      <div class="row">
        <div class="col-8 text-center">
          <div
            v-for="day in articleDetail.days"
            :key="day.id"
            class="d-inline-block"
          >
            <template v-if="dayNumber == day.number">
              <button
                class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold day-number-selected"
                @click="showArticleDetail(day.number)"
              >
                {{ day.number }}日目
              </button>
            </template>
            <template v-else>
              <button
                class="btn mb-2 ml-1 mr-1 p-1 bg-white day-number"
                @click="showArticleDetail(day.number)"
              >
                {{ day.number }}日目
              </button>
            </template>
          </div>
          <template v-if="checkCostPresence">
            <template v-if="isVisibleCostColumn">
              <button
                class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold total-cost-selected"
                @click="showCostColumn"
              >
                総コスト
              </button>
            </template>
            <template v-else>
              <button
                class="btn mb-2 ml-1 mr-1 p-1 bg-white total-cost"
                @click="showCostColumn"
              >
                総コスト
              </button>
            </template>
          </template>
        </div>
      </div>

      <div class="row">
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
        <SideColumn
          :article="articleDetail"
          class="col-4"
        />
      </div>
    </template>

    <template v-else>
      <div class="row">
        <SideColumn
          :article="articleDetail"
          class="col-12"
        />

        <div class="col-12 mt-4">
          <div class="row">
            <div class="col-12 text-center">
              <div
                v-for="day in articleDetail.days"
                :key="day.id"
                class="d-inline-block"
              >
                <template v-if="dayNumber == day.number">
                  <button
                    class="btn mb-2 mr-1 ml-1 p-1 text-white font-weight-bold day-number-selected"
                    @click="showArticleDetail(day.number)"
                  >
                    {{ day.number }}日目
                  </button>
                </template>
                <template v-else>
                  <button
                    class="btn mb-2 mr-1 ml-1 p-1 bg-white day-number"
                    @click="showArticleDetail(day.number)"
                  >
                    {{ day.number }}日目
                  </button>
                </template>
              </div>
              <template v-if="checkCostPresence">
                <template v-if="isVisibleCostColumn">
                  <button
                    class="btn mb-2 p-1 ml-1 mr-1 text-white font-weight-bold total-cost-selected"
                    @click="showCostColumn"
                  >
                    総コスト
                  </button>
                </template>
                <template v-else>
                  <button
                    class="btn mb-2 ml-1 mr-1 p-1 bg-white total-cost"
                    @click="showCostColumn"
                  >
                    総コスト
                  </button>
                </template>
              </template>
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
      </div>
    </template>
  </div>
</template>

<script>
import MainColumn from './components/show/MainColumn'
import SideColumn from './components/show/SideColumn'
import CostColumn from './components/show/CostColumn'
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'ArticleShow',
  components: {
    MainColumn,
    SideColumn,
    CostColumn
  },
  data() {
    return {
      dayNumber: 1,
      isVisibleCostColumn: false
    }
  },
  computed: {
    ...mapGetters('articles', [
      'articleDetail'
    ]),
    checkCostPresence() {
      let cost = []
      this.articleDetail.days.forEach(day => {
        day.info_blocks.forEach(info_block => {
          info_block.spendings.forEach(spending => {
            cost.push(spending)
          })
          info_block.transportations.forEach(transportation => {
            cost.push(transportation)
          })
        })
      })
      return cost.length? true : false
    }
  },
  created() {
    this.getArticleDetail(this.$route.query.id)
  },
  methods :{
    ...mapActions('articles', [
      'getArticleDetail'
    ]),
    showArticleDetail(dayNumber) {
      this.dayNumber = dayNumber
      this.isVisibleCostColumn = false
    },
    showCostColumn() {
      this.dayNumber = null
      this.isVisibleCostColumn = true
    },
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 1100px;
  margin-right: auto;
  margin-left: auto;
}

.main-column {
  border: solid thin #00FF27;
  border-radius: 6px;
}

.day-number {
  border: solid #00D320;
}

.day-number-selected {
  background-color: #00D320;
  border: solid #00D320;
}

.day-number-selected-xs {
  background-color: #00D320;
  border: solid #00D320;
}

.total-cost {
  border: solid #1D51FF;
}

.total-cost-selected {
  background-color: #1D51FF;
  border: solid #1D51FF;
}
</style>
