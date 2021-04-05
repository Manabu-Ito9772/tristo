<template>
  <div>
    <div class="d-inline-block">
      <template v-if="buttonUnselected">
        <button
          class="btn mb-2 ml-1 pl-2 pr-2 pt-1 pb-1 d-flex align-items-center font-weight-bold text-muted bg-white overview"
          @click="showOverview"
        >
          概要
        </button>
      </template>
      <template v-else>
        <button
          class="btn mb-2 ml-1 pl-2 pr-2 pt-1 pb-1 d-flex align-items-center font-weight-bold text-white overview-selected"
        >
          概要
        </button>
      </template>
    </div>
    <div
      v-for="day in days"
      :key="day.id"
      class="d-inline-block"
    >
      <template v-if="dayNumber == day.number">
        <button class="btn mb-2 ml-1 mr-1 p-1 d-flex align-items-center text-white font-weight-bold day-number-selected">
          {{ day.number }}日目&nbsp;
          <template v-if="days.length > 1">
            <div
              class="p-0 m-0 btn btn-white"
              @click="deleteDay(day)"
            >
              <font-awesome-icon
                :icon="['far', 'times-circle']"
                class="fa-lg"
              />
            </div>
          </template>
        </button>
      </template>
      <template v-else>
        <button
          class="btn mb-2 ml-1 mr-1 p-1 d-flex align-items-center font-weight-bold text-muted bg-white day-number"
          @click.self="showMainColumn(day)"
        >
          {{ day.number }}日目&nbsp;
          <div
            class="p-0 m-0 btn btn-green"
            @click="deleteDay(day)"
          >
            <font-awesome-icon
              :icon="['far', 'times-circle']"
              class="fa-lg"
            />
          </div>
        </button>
      </template>
    </div>
    <div
      class="p-1 d-inline-block text-dark add-day-button"
      @click="addDay"
    >
      <font-awesome-icon
        :icon="['fas', 'plus-circle']"
        class="fa-lg"
      />
    </div>
  </div>
</template>

<script>
export default {
  name: 'SwitchButton',
  props: {
    days: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      buttonUnselected: true,
      dayNumber: 1,
      mapButtonSelected: false
    }
  },
  methods :{
    showMainColumn(day) {
      this.$emit('showMainColumn', day)
      this.dayNumber = day.number
      this.buttonUnselected = true
    },
    showOverview() {
      this.$emit('showOverview')
      this.dayNumber = null
      this.buttonUnselected = false
    },
    deleteDay(day) {
      this.dayNumber = 1
      this.$emit('deleteDay', day)
    },
    addDay() {
      this.$emit('addDay')
    },
    resetDayNum() {
      this.dayNumber = 1
    }
  }
}
</script>

<style scoped>
.overview {
  border: solid #6A6A6A;
}

.overview-selected {
  background-color: #6A6A6A;
  border: solid #6A6A6A;
}

.day-number {
  border: solid #00D320;
}

.day-number-selected {
  background-color: #00D320;
  border: solid #00D320;
}

.btn-white {
  color: white;
}

.btn-green {
  color: green;
}

.add-day-button {
  cursor: pointer;
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
