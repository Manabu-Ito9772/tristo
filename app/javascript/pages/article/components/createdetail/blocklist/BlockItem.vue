<template>
  <div class="row bg-white">
    <template v-if="$mq == 'xs'">
      <template v-if="block.arriving_time || block.leaving_time">
        <div class="col-2 pt-3 pb-3 pl-1 pr-1 info-block-left">
          <TimeInfo
            :block="block"
          />
        </div>
        <div class="col-10 p-3">
          <MainInfo
            :block="block"
            :currency="currency"
          />
        </div>
        <div class="col-12 pt-3 pl-3 pr-3 info-block-bottom">
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
            :currency="currency"
          />
        </div>
        <div class="col-12 pl-3 pr-3">
          <img
            src="../../../../../images/sample.png"
            class="mb-3 info-block-photo"
          >
        </div>
      </template>
    </template>

    <template v-else-if="$mq == 'sm'">
      <template v-if="block.arriving_time || block.leaving_time">
        <div class="col-2 pt-3 pb-3 pl-1 pr-1 info-block-left">
          <TimeInfo
            :block="block"
          />
        </div>
        <div class="col-10 p-3">
          <MainInfo
            :block="block"
            :currency="currency"
          />
        </div>
        <div class="col-12 pt-3 pl-3 pr-3 info-block-bottom">
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
            :currency="currency"
          />
        </div>
        <div class="col-12 pl-3 pr-3">
          <img
            src="../../../../../images/sample.png"
            class="mb-3 info-block-photo"
          >
        </div>
      </template>
    </template>

    <template v-else>
      <template v-if="block.arriving_time || block.leaving_time">
        <div class="col-1 pt-3 pb-3 pl-1 pr-1 info-block-left">
          <TimeInfo
            :block="block"
          />
        </div>
        <div class="col-6 p-3">
          <MainInfo
            :block="block"
            :currency="currency"
          />
        </div>
        <div class="col-5 pt-3 pl-3 pr-3 info-block-right">
          <img
            src="../../../../../images/sample.png"
            class="mb-3 info-block-photo"
          >
        </div>
      </template>
      <template v-else>
        <div class="col-7 p-3">
          <MainInfo
            :block="block"
            :currency="currency"
          />
        </div>
        <div class="col-5 pt-3 pl-3 pr-3 info-block-right">
          <img
            src="../../../../../images/sample.png"
            class="mb-3 info-block-photo"
          >
        </div>
      </template>
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
    },
    currency: {
      type: String,
      required: true
    }
  },
}
</script>

<style scoped>
.info-block-left {
  border-right: solid thin #FF00EB;
}

.info-block-right {
  border-left: solid thin #FF00EB;
}

.info-block-center {
  border-right: solid thin #FF00EB;
}

.info-block-bottom {
  border-top: solid thin #FF00EB;
}

.info-block-photo {
  width: 100%;
}
</style>
