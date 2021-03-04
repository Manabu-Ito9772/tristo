<template>
  <div class="row mb-3 bg-white">
    <template v-if="block.arriving_time || block.leaving_time">
      <div class="col-2 pt-3 pb-3 pl-2 pr-2 info-block-left">
        <InfoBlockLeft
          :block="block"
        />
      </div>
      <div class="col-10 p-3 info-block-right">
        <InfoBlockCenter
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
      <div class="col-12 p-3 info-block-above-without-time">
        <InfoBlockCenter
          :block="block"
        />
      </div>
      <div class="col-12 pt-3 pl-3 pr-3 info-block-below-without-time">
        <img
          src="../../../../../images/sample.png"
          class="mb-3 info-block-photo"
        >
      </div>
    </template>
  </div>
</template>

<script>
import InfoBlockLeft from './parts/InfoBlockLeft'
import InfoBlockCenter from './parts/InfoBlockCenter'

export default {
  name: 'InfoBlockSmall',
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
.info-block-left {
  border: solid #FF00EB;
  /* border-color: #FF00EB #CBCBCB #CBCBCB #FF00EB; */
  border-width: 0.1px 0.1px 0.1px 0px;
}

.info-block-right {
  border: solid #FF00EB;
  /* border-color: #FF00EB #FF00EB #CBCBCB #FF00EB; */
  border-width: 0.1px 0px 0.1px 0px;
}

.info-block-below {
  border: solid #FF00EB;
  border-width: 0px 0px 0.1px 0px;
}

.info-block-above-without-time {
  border: solid #FF00EB;
  /* border-color: #FF00EB #FF00EB #CBCBCB #FF00EB; */
  border-width: 0.1px 0px 0.1px 0px;
}

.info-block-below-without-time {
  border: solid #FF00EB;
  border-width: 0px 0px 0.1px 0px;
}

.info-block-photo {
  width: 100%;
}
</style>
