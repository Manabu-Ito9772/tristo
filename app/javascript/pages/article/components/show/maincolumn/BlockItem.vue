<template>
  <div>
    <template v-if="$mq == 'lg'">
      <div class="row mt-4 mb-4 ml-0 mr-0 bg-white info-block">
        <template v-if="block.arriving_time || block.leaving_time">
          <template v-if="block.images_url.length">
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
              <div
                v-for="(image, index) in block.images_url"
                :key="index"
              >
                <img
                  :src="image"
                  class="mb-3 info-block-photo"
                >
              </div>
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
          <template v-if="block.images_url.length">
            <div class="col-7 p-3">
              <MainInfo
                :block="block"
                :currency="currency"
              />
            </div>
            <div class="col-5 pt-3 pl-3 pr-3 info-block-right">
              <div
                v-for="(image, index) in block.images_url"
                :key="index"
              >
                <img
                  :src="image"
                  class="mb-3 info-block-photo"
                >
              </div>
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
      </div>
    </template>

    <template v-else>
      <div class="row mt-4 mb-4 ml-0 mr-0 bg-white info-block">
        <template v-if="block.arriving_time || block.leaving_time">
          <template v-if="block.images_url.length">
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
              <template v-if="block.images_url.length == 1">
                <div
                  v-for="(image, index) in block.images_url"
                  :key="index"
                >
                  <img
                    :src="image"
                    class="info-block-photo"
                  >
                </div>
              </template>

              <template v-else>
                <swiper
                  class="swiper"
                  :options="swiperOption"
                >
                  <swiper-slide
                    v-for="(image, index) in block.images_url"
                    :key="index"
                  >
                    <img
                      :src="image"
                      class="info-block-photo"
                    >
                  </swiper-slide>
                  <div
                    slot="button-prev"
                    class="swiper-button-prev swiper-button-white"
                  />
                  <div
                    slot="button-next"
                    class="swiper-button-next swiper-button-white"
                  />
                  <div
                    slot="pagination"
                    class="swiper-pagination swiper-pagination-white"
                  />
                </swiper>
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
          <template v-if="block.images_url.length">
            <div class="col-12 p-3">
              <MainInfo
                :block="block"
                :currency="currency"
              />
            </div>
            <div class="col-12 pb-3 pl-3 pr-3">
              <template v-if="block.images_url.length == 1">
                <div
                  v-for="(image, index) in block.images_url"
                  :key="index"
                >
                  <img
                    :src="image"
                    class="info-block-photo"
                  >
                </div>
              </template>

              <template v-else>
                <swiper
                  class="swiper"
                  :options="swiperOption"
                >
                  <swiper-slide
                    v-for="(image, index) in block.images_url"
                    :key="index"
                  >
                    <img
                      :src="image"
                      class="info-block-photo"
                    >
                  </swiper-slide>
                  <div
                    slot="button-prev"
                    class="swiper-button-prev swiper-button-white"
                  />
                  <div
                    slot="button-next"
                    class="swiper-button-next swiper-button-white"
                  />
                  <div
                    slot="pagination"
                    class="swiper-pagination swiper-pagination-white"
                  />
                </swiper>
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
    MainInfo,
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
      swiperOption: {
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev'
        },
        pagination: {
          el: '.swiper-pagination',
          clickable: false
        },
        slidesPerView: 1,
        // spaceBetween: 15,
        mousewheel: true,
      }
    }
  }
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

.info-block-right {
  border-left: solid thin #FF00EB;
}

.info-block-photo {
  width: 100%;
}

.info-block-below {
  border-top: solid thin #FF00EB;
}

.info-block-photo {
  width: 100%;
}
</style>
