<template>
  <div>
    <div class="d-inline-block">
      <template v-if="buttonUnselected">
        <div
          class="mb-2 ml-1 pl-2 pr-2 pt-1 pb-1 d-flex align-items-center font-weight-bold text-muted bg-white overview"
          @click="showOverview"
        >
          概要
        </div>
      </template>
      <template v-else>
        <div
          class="mb-2 ml-1 pl-2 pr-2 pt-1 pb-1 d-flex align-items-center font-weight-bold text-white overview-selected"
        >
          概要
        </div>
      </template>
    </div>
    <div
      v-for="day in days"
      :key="day.id"
      class="d-inline-block"
    >
      <template v-if="dayNumber == day.number">
        <div class="mb-2 ml-1 mr-1 p-1 d-flex align-items-center text-white font-weight-bold day-number-selected">
          {{ day.number }}日目&nbsp;
          <template v-if="days.length > 1">
            <template v-if="isMobile">
              <div
                class="p-0 m-0 icon-white-mobile"
                @click="deleteDay(day)"
              >
                <font-awesome-icon
                  :icon="['far', 'times-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
            <template v-else>
              <div
                class="p-0 m-0 icon-white"
                @click="deleteDay(day)"
              >
                <font-awesome-icon
                  :icon="['far', 'times-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
          </template>
        </div>
      </template>
      <template v-else>
        <div
          class="mb-2 ml-1 mr-1 p-1 d-flex align-items-center font-weight-bold text-muted bg-white day-number"
          @click.self="showMainColumn(day)"
        >
          {{ day.number }}日目&nbsp;
          <template v-if="days.length > 1">
            <template v-if="isMobile">
              <div
                class="p-0 m-0 icon-mobile"
                @click="deleteDay(day)"
              >
                <font-awesome-icon
                  :icon="['far', 'times-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
            <template v-else>
              <div
                class="p-0 m-0 icon"
                @click="deleteDay(day)"
              >
                <font-awesome-icon
                  :icon="['far', 'times-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
          </template>
        </div>
      </template>
    </div>

    <template v-if="days.length < 14">
      <template v-if="isMobile">
        <div
          class="p-1 d-inline-block add-button-mobile"
          @click="addDay"
        >
          <font-awesome-icon
            :icon="['fas', 'plus-circle']"
            class="fa-lg"
          />
        </div>
      </template>
      <template v-else>
        <div
          id="add-day-button"
          class="p-1 d-inline-block add-button"
          @click="addDay"
        >
          <font-awesome-icon
            :icon="['fas', 'plus-circle']"
            class="fa-lg"
          />
        </div>
      </template>
    </template>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect'

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
      mapButtonSelected: false,
      isMobile: isMobile
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
      if (this.days.length < 14) {
        this.$emit('addDay')
      }
    },
    resetDayNum() {
      this.dayNumber = 1
      this.buttonUnselected = true
    },
  }
}
</script>

<style scoped>
.overview {
  border: solid gray;
  border-radius: 4px;
  cursor: pointer;
}

.overview-selected {
  background-color: gray;
  border: solid gray;
  border-radius: 4px;
  cursor: pointer;
}

.day-number {
  border: solid #81D674;
  border-radius: 4px;
  cursor: pointer;
}

.day-number-selected {
  background-color: #81D674;
  border: solid #81D674;
  border-radius: 4px;
  cursor: pointer;
}

.icon {
  color: #81D674;
  cursor: pointer;
}

.icon:hover {
  color: gray;
  cursor: pointer;
}

.icon-mobile {
  color: #81D674;
  cursor: pointer;
}

.icon-mobile:active {
  color: gray;
  cursor: pointer;
}

.icon-white {
  color: #FFF;
  cursor: pointer;
}

.icon-white:hover {
  color: gray;
  cursor: pointer;
}

.icon-white-mobile {
  color: #FFF;
  cursor: pointer;
}

.icon-white-mobile:active {
  color: gray;
  cursor: pointer;
}

.add-button {
  color: gray;
  cursor: pointer;
}

.add-button:hover {
  color: #383838;
  cursor: pointer;
}

.add-button-mobile {
  color: gray;
  cursor: pointer;
}

.add-button-mobile:active {
  color: #383838;
  cursor: pointer;
}
</style>
