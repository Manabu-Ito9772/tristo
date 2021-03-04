<template>
  <div>
    <div
      v-for="transportation in block.transportations"
      :key="transportation.id"
      class="row ml-1 mr-1 mb-3"
    >
      <div class="col-1 p-0 d-flex justify-content-center align-items-center icon-size">
        <font-awesome-icon
          :icon="['fas', 'long-arrow-alt-down']"
          class="fa-lg"
        />
      </div>
      <template v-if="transportation.means == 'other'">
        <p class="col-10 d-flex align-items-center m-0 p-0 transportaion word-break">
          <template v-if="transportation.description">
            {{ transportation.description }}&nbsp;&nbsp;&nbsp;
          </template>
          <template v-if="transportation.cost">
            {{ separateWithComma(transportation.cost) }}円
          </template>
        </p>
      </template>
      <template v-else>
        <div class="col-1 p-0 d-flex justify-content-center align-items-center icon-size">
          <font-awesome-icon
            :icon="['fas', transportation.means]"
            class="fa-lg"
          />
        </div>
        <p class="col-10 d-flex align-items-center m-0 transportaion word-break">
          <template v-if="transportation.description">
            {{ transportation.description }}&nbsp;&nbsp;&nbsp;
          </template>
          <template v-if="transportation.cost">
            {{ separateWithComma(transportation.cost) }}円
          </template>
        </p>
      </template>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MainColumn',
  props: {
    block: {
      type: Object,
      required: true
    }
  },
  methods: {
    separateWithComma(num) {
      let cost = Number(num)
      return cost.toLocaleString()
    },
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.icon-size {
  font-size: 25px;
}

.transportaion {
  font-weight: bold;
}

.transportation-cost {
  width: 100%;
}
</style>
