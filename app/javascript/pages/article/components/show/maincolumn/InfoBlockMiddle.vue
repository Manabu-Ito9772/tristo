<template>
  <div class="row mt-4 mb-4 ml-0 mr-0 bg-white info-block">
    <template v-if="block.arriving_time || block.leaving_time">
      <div class="col-2 pt-3 pb-3 pl-1 pr-1 info-block-left">
        <TimeInfo
          :block="block"
        />
      </div>
      <div class="col-10 p-3">
        <MainInfo
          :block="block"
        />
      </div>
      <div class="col-12 pt-3 pl-3 pr-3 info-block-below">
        <img
          src="../../../../../images/sample.png"
          class="mb-3 info-block-photo"
        >
      </div>
    </template>
    <template v-else>
      <div class="col-12 p-3">
        <MainInfo
          :block="block"
        />
      </div>
      <div class="col-12 pl-3 pr-3">
        <img
          src="../../../../../images/sample.png"
          class="mb-3 info-block-photo"
        >
      </div>
    </template>
  </div>
</template>

<script>
import TimeInfo from './infoblock/TimeInfo'
import MainInfo from './infoblock/MainInfo'

export default {
  name: 'InfoBlock',
  components: {
    TimeInfo,
    MainInfo
  },
  props: {
    block: {
      type: Object,
      required: true
    }
  },
}
</script>

<style scoped>
.info-block {
  border: solid #FF00EB;
  border-radius: 6px;
}

.info-block-left {
  border-right: solid thin #FF00EB;
}

.info-block-below {
  border-top: solid thin #FF00EB;
}

.info-block-photo {
  width: 100%;
}
</style>
