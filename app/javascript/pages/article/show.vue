<template>
  <div class="container-fluid mt-4 bg-white">
    <div
      v-for="info_block in articleDetail.info_blocks"
      :key="info_block.id"
    >
      <div class="row mt-3 mb-3 ml-1 mr-1">
        <template v-if="info_block.arriving_time || info_block.leaving_time">
          <div class="col-2 col-sm-1 pt-3 pb-3 pl-1 pr-1 info-block-left">
            <div class="row">
              <div class="col-12 text-center text-white">
                <p class="col-12 p-0 mb-1 info-block-time">
                  時間
                </p>
              </div>
              <div class="col-12 text-center text-dark">
                <p class="col-12 p-0 mb-1">
                  {{ info_block.arriving_time | moment('H:mm') }}
                </p>
              </div>
              <div class="col-12 text-center text-dark">
                <p class="col-12 p-0 mb-1 time-wave">
                  〜
                </p>
              </div>
              <div class="col-12 text-center text-dark">
                <p class="col-12 p-0 mb-0">
                  {{ info_block.leaving_time | moment('H:mm') }}
                </p>
              </div>
            </div>
          </div>
          <div class="col-10 col-sm-6 p-3 info-block-center">
            <div class="row mb-3">
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  イベント
                </p>
              </div>
              <p class="col-12 pl-4 pt-1 m-0 text-dark word-break">
                {{ info_block.event }}
              </p>
            </div>
            <div
              v-if="info_block.place"
              class="row mb-3"
            >
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  場所
                </p>
              </div>
              <p class="col-12 pl-4 pt-1 m-0 text-dark word-break">
                {{ info_block.place }}
              </p>
              <div
                v-if="info_block.place_info"
                class="col-12 pl-4 pt-1 m-0 text-dark"
              >
                <a
                  :href="info_block.place_info"
                  target="_blank"
                  class="word-break"
                >
                  {{ info_block.place_info }}
                </a>
              </div>
            </div>
            <div
              v-if="info_block.spendings.length"
              class="row mb-3"
            >
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  コスト
                </p>
              </div>
              <div
                v-for="spending in info_block.spendings"
                :key="spending.id"
                class="col-12 pt-1 m-0 text-dark"
              >
                <div class="row ml-2 mr-2 cost-border">
                  <div class="col-8 p-0">
                    <p class="m-0 word-break">
                      {{ spending.description }}
                    </p>
                  </div>
                  <div class="col-4 p-0 text-right">
                    <p class="m-0">
                      {{ spending.cost }}円
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div
              v-if="info_block.comment"
              class="row"
            >
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  コメント
                </p>
              </div>
              <p class="col-12 pl-4 pt-1 m-0 text-dark word-break">
                {{ info_block.comment }}
              </p>
            </div>
          </div>
          <div class="col-12 col-sm-5 pt-3 pl-3 pr-3 info-block-right">
            <img
              src="../../images/sample.png"
              class="mb-3 info-block-photo"
            >
          </div>
        </template>
        <template v-else>
          <div class="col-12 col-sm-7 p-3 info-block-center">
            <div class="row mb-3">
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  イベント
                </p>
              </div>
              <p class="col-12 pl-4 pt-1 m-0 text-dark word-break">
                {{ info_block.event }}
              </p>
            </div>
            <div
              v-if="info_block.place"
              class="row mb-3"
            >
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  場所
                </p>
              </div>
              <p class="col-12 pl-4 pt-1 m-0 text-dark word-break">
                {{ info_block.place }}
              </p>
              <div
                v-if="info_block.place_info"
                class="col-12 pl-4 pt-1 m-0 text-dark"
              >
                <a
                  :href="info_block.place_info"
                  target="_blank"
                  class="word-break"
                >
                  {{ info_block.place_info }}
                </a>
              </div>
            </div>
            <div
              v-if="info_block.spendings.length"
              class="row mb-3"
            >
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  コスト
                </p>
              </div>
              <div
                v-for="spending in info_block.spendings"
                :key="spending.id"
                class="col-12 pt-1 m-0 text-dark"
              >
                <div class="row ml-2 mr-2 cost-border">
                  <div class="col-8 p-0">
                    <p class="m-0 word-break">
                      {{ spending.description }}
                    </p>
                  </div>
                  <div class="col-4 p-0 text-right">
                    <p class="m-0">
                      {{ spending.cost }}円
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div
              v-if="info_block.comment"
              class="row"
            >
              <div class="col-12 text-white">
                <p class="pl-3 info-block-main m-0">
                  コメント
                </p>
              </div>
              <p class="col-12 pl-4 pt-1 m-0 text-dark word-break">
                {{ info_block.comment }}
              </p>
            </div>
          </div>
          <div class="col-12 col-sm-5 pt-3 pl-3 pr-3 info-block-right">
            <img
              src="../../images/sample.png"
              class="mb-3 info-block-photo"
            >
          </div>
        </template>
      </div>
      <div
        v-for="transportation in info_block.transportations"
        :key="transportation.id"
        class="row ml-1 mr-1 mb-3"
      >
        <div class="col-1 p-0 d-flex justify-content-center align-items-center icon-size">
          <font-awesome-icon
            :icon="['fas', 'long-arrow-alt-down']"
            class="fa-lg"
          />
        </div>
        <div class="col-1 p-0 d-flex justify-content-center align-items-center icon-size">
          <font-awesome-icon
            :icon="['fas', transport(transportation.means)]"
            class="fa-lg"
          />
        </div>
        <p class="col-10 d-flex align-items-center m-0 transportaion word-break">
          {{ transportation.description }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'ArticleShow',
  props: {
    article: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      tranport: 'walking',
      date: this.$moment().format()
    }
  },
  computed: {
    ...mapGetters('articles', [
      'articleDetail'
    ])
  },
  created() {
    this.getArticleDetail(this.article.id)
  },
  methods :{
    ...mapActions('articles', [
      'getArticleDetail'
    ]),
    transport(number) {
      if (number == 0) return 'walking'
      if (number == 1) return 'car'
      if (number == 2) return 'subway'
      if (number == 3) return 'bus'
      if (number == 4) return 'plane'
      return 'ship'
    }
  }
}
</script>

<style scoped>
.container-fluid {
  margin-right: auto;
  margin-left: auto;
  max-width: 700px;
  border: solid thin #00FF27;
  border-radius: 6px;
}

.info-block-left {
  border: solid thin #FF00EB;
  /* border: solid #FF00EB;
  border-width: 0.1px 0px 0.1px 0.1px;
  border-radius: 6px 0px 0px 6px / 6px 0px 0px 6px; */
}

.info-block-center {
  border: solid thin #FF00EB;
  /* border: solid 0.1px ;
  border-color: #FF00EB #CBCBCB #FF00EB #CBCBCB; */
}

.info-block-right {
  border: solid thin #FF00EB;
  /* border: solid #FF00EB;
  border-width: 0.1px 0.1px 0.1px 0px;
  border-radius: 0px 6px 6px 0px / 0px 6px 6px 0px; */
}

.info-block-time {
  background-color: #00D320;
  border-radius: 8px;
}

.time-wave {
  transform: rotate(90deg);
}

.info-block-main {
  background-color: #FF00EB;
  border-radius: 8px;
}

.cost-border {
  border-bottom: solid thin #CBCBCB;
}

.info-block-photo {
  width: 100%;
}

.icon-size {
  font-size: 25px;
}

.transportaion {
  font-weight: bold;
}

.word-break {
  word-break: break-all;
}
</style>
