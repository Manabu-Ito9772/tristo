<template>
  <div>
    <div
      v-for="day in article.days"
      :key="day.id"
      class="d-inline-block"
    >
      <template v-if="article.days.length != 1">
        <template v-if="dayNumber == day.number">
          <button class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold day-number-selected">
            {{ day.number }}日目
          </button>
        </template>
        <template v-else>
          <button
            class="btn mb-2 ml-1 mr-1 p-1 bg-white day-number"
            @click="showMainColumn(day.number)"
          >
            {{ day.number }}日目
          </button>
        </template>
      </template>
      <template v-else>
        <template v-if="dayNumber">
          <button class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold day-number-selected">
            日帰り
          </button>
        </template>
        <template v-else>
          <button
            class="btn mb-2 ml-1 mr-1 p-1 bg-white day-number"
            @click="showMainColumn(1)"
          >
            日帰り
          </button>
        </template>
      </template>
    </div>
    <template v-if="costs.length">
      <template v-if="costButtonSelected">
        <button class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold total-cost-selected">
          コスト
        </button>
      </template>
      <template v-else>
        <button
          class="btn mb-2 ml-1 mr-1 p-1 bg-white total-cost"
          @click="showCostColumn"
        >
          コスト
        </button>
      </template>
    </template>
    <template v-if="article.map">
      <template v-if="mapButtonSelected">
        <button class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold map-selected">
          マップ
        </button>
      </template>
      <template v-else>
        <button
          class="btn mb-2 ml-1 mr-1 p-1 bg-white map"
          @click="showMapColumn"
        >
          マップ
        </button>
      </template>
    </template>
  </div>
</template>

<script>
export default {
  name: 'SwitchButton',
  props: {
    article: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      costs: [],
      dayNumber: 1,
      costButtonSelected: false,
      mapButtonSelected: false
    }
  },
  watch: {
    article: {
      handler() {
        for (let day of this.article.days) {
          for (let block of day.ordered_blocks) {
            for (let spending of block.spendings) {
              this.costs.push(spending)
            }
            for (let transportation of block.transportations) {
              this.costs.push(transportation)
            }
          }
        }
      },
    }
  },
  methods :{
    showMainColumn(dayNumber) {
      this.$emit('showMainColumn', dayNumber)
      this.dayNumber = dayNumber
      this.costButtonSelected = false
      this.mapButtonSelected = false
    },
    showCostColumn() {
      this.$emit('showCostColumn')
      this.dayNumber = null
      this.mapButtonSelected = false
      this.costButtonSelected = true
    },
    showMapColumn() {
      this.$emit('showMapColumn')
      this.dayNumber = null
      this.costButtonSelected = false
      this.mapButtonSelected = true
    },
  }
}
</script>

<style scoped>
.day-number {
  border: solid #00D320;
}

.day-number-selected {
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

.map {
  border: solid #FF990D;
}

.map-selected {
  background-color: #FF990D;
  border: solid #FF990D;
}
</style>
