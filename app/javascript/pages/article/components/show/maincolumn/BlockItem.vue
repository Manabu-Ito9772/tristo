<template>
  <div>
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
              class="image pointer"
              @click="showImage"
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
              class="image pointer"
              @click="showImage"
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
          <div class="col-2 pt-3 pb-3 pl-2 pr-2 info-block-left">
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

          <div class="col-12 p-3 info-block-below">
            <template v-if="$mq == 'sm'">
              <img
                :src="block.image_url"
                class="image pointer"
                @click="showImage"
              >
            </template>
            <template v-else>
              <img
                :src="block.image_url"
                class="image"
              >
            </template>
          </div>
        </template>

        <template v-else>
          <div class="col-2 pt-3 pb-3 pl-2 pr-2 info-block-left">
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
            <template v-if="$mq == 'sm'">
              <img
                :src="block.image_url"
                class="image pointer"
                @click="showImage"
              >
            </template>
            <template v-else>
              <img
                :src="block.image_url"
                class="image"
              >
            </template>
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

    <ImageModal
      v-if="isVisibleImage"
      :image="block.image_url"
      @closeImage="closeImage"
    />
  </div>
</template>

<script>
import TimeInfo from './blockitem/TimeInfo'
import MainInfo from './blockitem/MainInfo'
import ImageModal from './blockitem/ImageModal'

export default {
  name: 'InfoBlock',
  components: {
    TimeInfo,
    MainInfo,
    ImageModal
  },
  props: {
    block: {
      type: Object,
      required: true
    },
    currency: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      isVisibleImage: false
    }
  },
  methods: {
    showImage() {
      this.isVisibleImage = true
      this.$emit('fixPage')
    },
    closeImage() {
      this.isVisibleImage = false
      this.$emit('flowPage')
    }
  }
}
</script>

<style scoped>
.info-block-left {
  border-right: solid thin #FF58F2;
}

.info-block-right {
  border-left: solid thin #FF58F2;
}

.info-block-below {
  border-top: solid thin #FF58F2;
}

.pointer {
  cursor: pointer;
}

.image {
  width: 100%;
  border-radius: 4px;
}
</style>
