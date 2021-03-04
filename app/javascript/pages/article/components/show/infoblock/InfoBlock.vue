<template>
  <div class="row mt-3 mb-3 ml-1 mr-1 bg-white info-block">
    <template v-if="block.arriving_time || block.leaving_time">
      <div class="col-1 pt-3 pb-3 pl-1 pr-1 info-block-left">
        <InfoBlockLeft
          :block="block"
        />
      </div>
      <div class="col-6 p-3 info-block-center">
        <InfoBlockCenter
          :block="block"
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
      <div class="col-7 p-3 info-block-left">
        <InfoBlockCenter
          :block="block"
        />
      </div>
      <div class="col-5 pt-3 pl-3 pr-3 info-block-right">
        <img
          src="../../../../../images/sample.png"
          class="mb-3 info-block-photo"
        >
      </div>
    </template>
  </div>
</template>

<script>
import InfoBlockCenter from './parts/InfoBlockCenter'
import InfoBlockLeft from './parts/InfoBlockLeft'

export default {
  name: 'InfoBlock',
  components: {
    InfoBlockLeft,
    InfoBlockCenter
  },
  props: {
    block: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      date: this.$moment().format()
    }
  },
}
</script>

<style scoped>
.info-block {
  border-radius: 6px;
}

.info-block-left {
  border: solid #FF00EB;
  border-width: 0.3rem 0rem 0.3rem 0.3rem;
  border-radius: 6px 0px 0px 6px / 6px 0px 0px 6px;
}

.info-block-center {
  border: solid #FF00EB;
  border-width: 0.3rem 0rem 0.3rem 0.1rem;
}

.info-block-right {
  border: solid #FF00EB;
  border-width: 0.3rem 0.3rem 0.3rem 0.1rem;
  border-radius: 0px 6px 6px 0px / 0px 6px 6px 0px;
}

.info-block-photo {
  width: 100%;
}
</style>
