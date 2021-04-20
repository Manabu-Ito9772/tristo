<template>
  <div class="row bg-white">
    <template v-if="$mq == 'lg'">
      <template v-if="block.arriving_time || block.leaving_time">
        <template v-if="block.image_url">
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
          <div class="col-5 p-3 info-block-right">
            <img
              :src="block.image_url"
              class="image"
            >
          </div>
        </template>

        <template v-else>
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
        </template>
      </template>

      <template v-else>
        <template v-if="block.image_url">
          <div class="col-7 p-3">
            <MainInfo
              :block="block"
              :currency="currency"
            />
          </div>
          <div class="col-5 p-3 info-block-right">
            <img
              :src="block.image_url"
              class="image"
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
        </template>
      </template>
    </template>

    <template v-else>
      <template v-if="block.arriving_time || block.leaving_time">
        <template v-if="block.image_url">
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
          <div class="col-12 p-3 info-block-bottom">
            <img
              :src="block.image_url"
              class="image"
            >
          </div>
        </template>

        <template v-else>
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
        </template>
      </template>

      <template v-else>
        <template v-if="block.image_url">
          <div class="col-12 p-3">
            <MainInfo
              :block="block"
              :currency="currency"
            />
          </div>
          <div class="col-12 pb-3 pl-3 pr-3">
            <img
              :src="block.image_url"
              class="image"
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
        </template>
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
  border-right: solid thin #FF58F2;
}

.info-block-right {
  border-left: solid thin #FF58F2;
}

.info-block-center {
  border-right: solid thin #FF58F2;
}

.info-block-bottom {
  border-top: solid thin #FF58F2;
}

.image {
  width: 100%;
  border-radius: 4px;
  cursor: pointer;
}
</style>
