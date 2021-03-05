<template>
  <div>
    <div
      v-for="day in article.days"
      :key="day.id"
      class="d-inline-block"
    >
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
    </div>
    <template v-if="checkCostPresence">
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
      dayNumber: 1,
      costButtonSelected: false,
      mapButtonSelected: false
    }
  },
  computed: {
    checkCostPresence() {
      let cost = []
      this.article.days.forEach(day => {
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
