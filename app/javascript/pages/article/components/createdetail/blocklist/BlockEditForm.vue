<template>
  <div>
    <ValidationObserver v-slot="{ handleSubmit }">
      <template v-if="$mq == 'lg'">
        <div class="row bg-white mb-4 ml-0 mr-0 info-block-form block-form-to-edit">
          <div class="col-2 p-3 info-block-left">
            <div class="row">
              <div class="col-12 text-center text-white">
                <p class="col-12 p-0 mb-2 content-lavel">
                  時間
                </p>
              </div>
              <div class="col-12 text-center text-dark">
                <Timepicker
                  v-model="blockEdit.arriving_time"
                  format="H:mm"
                  input-class="form-control p-1 bg-light"
                  input-width="100%"
                  placeholder=" "
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
                  class="timepicker"
                />
              </div>
              <div class="col-12 pt-1 text-center text-dark">
                <h5 class="col-12 p-0 mb-1 time-wave">
                  〜
                </h5>
              </div>
              <div class="col-12 text-center text-dark">
                <Timepicker
                  v-model="blockEdit.leaving_time"
                  format="H:mm"
                  input-class="form-control p-1 bg-light"
                  input-width="100%"
                  placeholder=" "
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
                  class="timepicker"
                />
              </div>
            </div>
          </div>

          <div class="col-10 p-3">
            <div class="row">
              <div class="col-12">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:100"
                >
                  <p class="pl-3 mb-2 text-white content-lavel m-0">
                    * イベント
                  </p>
                  <input
                    v-model="blockEdit.title"
                    name="イベント"
                    class="form-control bg-light"
                  >
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <div class="col-12">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="max:100"
                >
                  <p class="pl-3 mt-4 mb-2 text-white content-lavel m-0">
                    場所
                  </p>
                  <input
                    v-model="blockEdit.place"
                    name="場所"
                    class="form-control bg-light"
                  >
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>

                <ValidationProvider
                  v-slot="{ errors }"
                  rules="max:500"
                >
                  <p class="mt-2 pl-2 m-0">
                    ホームページURL
                  </p>
                  <input
                    v-model="blockEdit.place_info"
                    name="ホームページURL"
                    class="form-control bg-light"
                  >
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <div class="col-12">
                <p class="pl-3 mt-4 mb-2 text-white content-lavel m-0">
                  コスト
                </p>
                <div
                  v-for="spending in blockEdit.spendings"
                  :key="`e-${spending.index}`"
                >
                  <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border spending">
                    <div class="row">
                      <div class="col-12 mb-2">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required|max:100"
                        >
                          <p class="pl-2 m-0">
                            * 内容
                          </p>
                          <input
                            v-model="spending.description"
                            name="内容"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>

                      <div class="col-6">
                        <p class="pl-2 m-0">
                          ジャンル
                        </p>
                        <select
                          v-model="spending.genre"
                          name="ジャンル"
                          class="form-control"
                        >
                          <option
                            v-for="spend in spendingGenre"
                            :key="`f-${spend.id}`"
                            :value="spend.value"
                          >
                            {{ spend.name }}
                          </option>
                        </select>
                      </div>

                      <div class="col-6">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required|max:50|numeric"
                        >
                          <p class="pl-2 m-0">
                            * 価格({{ currency }})
                          </p>
                          <input
                            v-model="spending.cost"
                            name="価格"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>
                    </div>
                    <div class="mt-3 mb-2 text-right">
                      <div
                        class="pt-3 pr-1 btn d-inline icon-color"
                        @click="deleteSpending(spending)"
                      >
                        <font-awesome-icon
                          :icon="['fas', 'trash-alt']"
                          class="fa-lg"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="mt-4 text-center">
                  <button
                    class="btn text-white font-weight-bold save-button"
                    @click="addSpendingForm"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'plus-circle']"
                      class="fa-lg"
                    />
                  </button>
                </div>
              </div>

              <div class="col-12">
                <p class="pl-3 mt-4 mb-2 text-white content-lavel m-0">
                  次のスポットまでの移動手段
                </p>
                <div
                  v-for="transportation in blockEdit.transportations"
                  :key="`g-${transportation.index}`"
                >
                  <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border transport">
                    <div class="row">
                      <div class="col-12 mb-2">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="max:100"
                        >
                          <p class="pl-2 m-0">
                            内容
                          </p>
                          <input
                            v-model="transportation.description"
                            name="内容"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>

                      <div class="col-6">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required"
                        >
                          <p class="pl-2 m-0">
                            * 手段
                          </p>
                          <select
                            v-model="transportation.means"
                            name="手段"
                            class="form-control"
                          >
                            <option
                              v-for="transport in transportationMeans"
                              :key="`h-${transport.id}`"
                              :value="transport.value"
                            >
                              {{ transport.name }}
                            </option>
                          </select>
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>

                      <div class="col-6">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="max:50|numeric"
                        >
                          <p class="pl-2 m-0">
                            価格({{ currency }})
                          </p>
                          <input
                            v-model="transportation.cost"
                            name="価格"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>
                    </div>
                    <div class="mt-3 mb-2 text-right">
                      <div
                        class="pt-3 pr-1 btn d-inline icon-color"
                        @click="deleteTransportation(transportation)"
                      >
                        <font-awesome-icon
                          :icon="['fas', 'trash-alt']"
                          class="fa-lg"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="mt-4 text-center">
                  <button
                    class="btn text-white font-weight-bold save-button"
                    @click="addTransportationForm"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'plus-circle']"
                      class="fa-lg"
                    />
                  </button>
                </div>
              </div>

              <div class="col-12">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="max:1000"
                >
                  <p class="pl-3 mt-4 mb-2 text-white content-lavel m-0">
                    コメント
                  </p>
                  <textarea
                    ref="adjust_textarea"
                    v-model="blockEdit.comment"
                    name="コメント"
                    class="form-control bg-light"
                    rows="2"
                    @keydown="adjustHeight"
                  />
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
            </div>
          </div>

          <div class="col-12 pt-3 pl-3 pr-3 info-block-bottom">
            <img
              src="../../../../../images/sample.png"
              class="mb-3 info-block-photo"
            >
          </div>

          <div class="col-12 pt-2 pb-3 pl-3 pr-3 text-center info-block-bottom">
            <p class="m-0 text-secondary">
              * 必須項目
            </p>
            <button
              class="btn d-inline-block pl-5 pr-5 mt-1 text-white font-weight-bold save-button"
              @click="handleSubmit(updateBlock)"
            >
              保存
            </button>
          </div>
        </div>
      </template>

      <template v-else>
        <div class="row bg-white mb-4 ml-0 mr-0 info-block-form">
          <div class="col-12 pt-3 pb-0 pl-3 pr-3">
            <div class="row">
              <div class="col-12 text-center text-white">
                <p class="col-12 p-0 mb-2 content-lavel">
                  時間
                </p>
              </div>
              <div class="col-12 d-flex justify-content-between align-items-center text-dark">
                <Timepicker
                  v-model="blockEdit.arriving_time"
                  format="H:mm"
                  input-class="form-control p-1 text-center bg-light"
                  input-width="100%"
                  placeholder="到着時間"
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
                />
                <h5 class="pl-2 pr-2 m-0">
                  〜
                </h5>
                <Timepicker
                  v-model="blockEdit.leaving_time"
                  format="H:mm"
                  input-class="form-control p-1 text-center bg-light"
                  input-width="100%"
                  placeholder="出発時間"
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
                />
              </div>
            </div>
          </div>

          <div class="col-12 pt-0 pb-3 pl-3 pr-3">
            <div class="row">
              <div class="col-12">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:100"
                >
                  <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                    * イベント
                  </p>
                  <input
                    v-model="blockEdit.title"
                    name="イベント"
                    class="form-control bg-light"
                  >
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <div class="col-12">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="max:100"
                >
                  <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                    場所
                  </p>
                  <input
                    v-model="blockEdit.place"
                    name="場所"
                    class="form-control bg-light"
                  >
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>

                <ValidationProvider
                  v-slot="{ errors }"
                  rules="max:500"
                >
                  <p class="mt-2 mb-0 text-center">
                    ホームページURL
                  </p>
                  <input
                    v-model="blockEdit.place_info"
                    name="ホームページURL"
                    class="form-control bg-light"
                  >
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <div class="col-12">
                <p class="mt-4 mb-2 mb-2 text-center text-white content-lavel m-0">
                  コスト
                </p>
                <div
                  v-for="spending in blockEdit.spendings"
                  :key="`i-${spending.index}`"
                >
                  <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border">
                    <div class="row">
                      <div class="col-12 mb-2">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required|max:100"
                        >
                          <p class="pl-2 m-0">
                            * 内容
                          </p>
                          <input
                            v-model="spending.description"
                            name="内容"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>

                      <div class="col-6">
                        <p class="pl-2 m-0">
                          ジャンル
                        </p>
                        <select
                          v-model="spending.genre"
                          class="form-control"
                        >
                          <option
                            v-for="spend in spendingGenre"
                            :key="`j-${spend.id}`"
                            :value="spend.value"
                          >
                            {{ spend.name }}
                          </option>
                        </select>
                      </div>

                      <div class="col-6">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required|max:50|numeric"
                        >
                          <p class="pl-2 m-0">
                            * 価格({{ currency }})
                          </p>
                          <input
                            v-model="spending.cost"
                            name="価格"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>
                    </div>
                    <div class="mt-3 mb-2 text-right">
                      <div
                        class="pt-3 pr-1 btn d-inline icon-color"
                        @click="deleteSpending(spending)"
                      >
                        <font-awesome-icon
                          :icon="['fas', 'trash-alt']"
                          class="fa-lg"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="mt-4 text-center">
                  <button
                    class="btn text-white font-weight-bold save-button"
                    @click="addSpendingForm"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'plus-circle']"
                      class="fa-lg"
                    />
                  </button>
                </div>
              </div>

              <div class="col-12">
                <p class="mt-4 mb-2 mb-2 text-center text-white content-lavel m-0">
                  次のスポットまでの移動手段
                </p>
                <div
                  v-for="transportation in blockEdit.transportations"
                  :key="`k-${transportation.index}`"
                >
                  <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border">
                    <div class="row">
                      <div class="col-12 mb-2">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="max:100"
                        >
                          <p class="pl-2 m-0">
                            内容
                          </p>
                          <input
                            v-model="transportation.description"
                            name="内容"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>

                      <div class="col-6">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required"
                        >
                          <p class="pl-2 m-0">
                            * 手段
                          </p>
                          <select
                            v-model="transportation.means"
                            name="手段"
                            class="form-control"
                          >
                            <option
                              v-for="transport in transportationMeans"
                              :key="`l-${transport.id}`"
                              :value="transport.value"
                            >
                              {{ transport.name }}
                            </option>
                          </select>
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>

                      <div class="col-6">
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="max:50|numeric"
                        >
                          <p class="pl-2 m-0">
                            価格({{ currency }})
                          </p>
                          <input
                            v-model="transportation.cost"
                            name="価格"
                            class="form-control"
                          >
                          <span class="text-danger">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </div>
                    </div>
                    <div class="mt-3 mb-2 text-right">
                      <div
                        class="pt-3 pr-1 btn d-inline icon-color"
                        @click="deleteTransportation(transportation)"
                      >
                        <font-awesome-icon
                          :icon="['fas', 'trash-alt']"
                          class="fa-lg"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="mt-4 text-center">
                  <button
                    class="btn text-white font-weight-bold save-button"
                    @click="addTransportationForm"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'plus-circle']"
                      class="fa-lg"
                    />
                  </button>
                </div>
              </div>

              <div class="col-12">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="max:1000"
                >
                  <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                    コメント
                  </p>
                  <textarea
                    ref="adjust_textarea"
                    v-model="blockEdit.comment"
                    name="コメント"
                    class="form-control bg-light"
                    rows="2"
                    @keydown="adjustHeight"
                  />
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
            </div>
          </div>

          <div class="col-12 pt-3 pl-3 pr-3 info-block-bottom">
            <img
              src="../../../../../images/sample.png"
              class="mb-3 info-block-photo"
            >
          </div>

          <div class="col-12 pt-2 pb-3 pl-3 pr-3 text-center info-block-bottom">
            <p class="m-0 text-secondary">
              * 必須項目
            </p>
            <button
              class="btn d-inline-block pl-5 pr-5 mt-1 text-white font-weight-bold save-button"
              @click="handleSubmit(updateBlock)"
            >
              保存
            </button>
          </div>
        </div>
      </template>
    </ValidationObserver>
  </div>
</template>

<script>
export default {
  name: 'BlockEditForm',
  props: {
    block: {
      type: Object,
      required: true,
    },
    currency: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      blockEdit: {},
      spendingGenre: [
        { id: 1, name: '観光費', value: 'touring' },
        { id: 2, name: 'アクティビティ費', value: 'activity' },
        { id: 3, name: '食費', value: 'food' },
        { id: 4, name: 'お土産代', value: 'souvenir' },
        { id: 5, name: '宿泊費', value: 'accommodation' },
        { id: 6, name: 'その他', value: 'other' },
      ],
      transportationMeans: [
        { id: 1, name: '徒歩', value: 'walking' },
        { id: 2, name: '車', value: 'car' },
        { id: 3, name: 'タクシー', value: 'taxi' },
        { id: 4, name: 'バス', value: 'bus' },
        { id: 5, name: '電車', value: 'subway' },
        { id: 6, name: '船', value: 'ship' },
        { id: 7, name: '飛行機', value: 'plane' },
        { id: 8, name: '自転車', value: 'bicycle' },
        { id: 9, name: 'バイク', value: 'motorcycle' },
        { id: 10, name: 'その他', value: 'other' },
      ],
      spendingsIndex: 0,
      transportationsIndex: 0,
    }
  },
  created() {
    this.blockEdit = Object.assign({}, this.block)
    if (this.blockEdit.arriving_time == null) {
      this.blockEdit.arriving_time = ''
    }
    if (this.blockEdit.leaving_time == null) {
      this.blockEdit.leaving_time = ''
    }
    for (let i = 0; i < this.blockEdit.spendings.length; i++) {
      this.blockEdit.spendings[i].index = i
    }
    this.spendingsIndex = this.blockEdit.spendings.length
    for (let i = 0; i < this.blockEdit.transportations.length; i++) {
      this.blockEdit.transportations[i].index = i
    }
    this.transportationsIndex = this.blockEdit.transportations.length
  },
  methods :{
    updateBlock() {
      this.$emit('updateBlock', this.blockEdit)
    },
    addSpendingForm() {
      let additionalForm = {
        block_id: this.blockEdit.id,
        genre: '',
        description: '',
        cost: '',
        index: this.spendingsIndex
      }
      this.blockEdit.spendings.push(additionalForm)
      this.spendingsIndex += 1
    },
    addTransportationForm() {
      let additionalForm = {
        block_id: this.blockEdit.id,
        means: '',
        description: '',
        cost: '',
        index: this.transportationsIndex
      }
      this.blockEdit.transportations.push(additionalForm)
      this.transportationsIndex += 1
    },
    deleteSpending(spending) {
      if (spending.id) {
        this.$axios.delete(`spendings/${spending.id}`)
          .catch(err => console.log(err.response))
      }
      this.blockEdit.spendings.splice(spending.index, 1)
      for (let i = 0; i < this.blockEdit.spendings.length; i++) {
        this.blockEdit.spendings[i].index = i
      }
      this.spendingsIndex = this.blockEdit.spendings.length
    },
    deleteTransportation(transportation) {
      if (transportation.id) {
        this.$axios.delete(`transportations/${transportation.id}`)
          .catch(err => console.log(err.response))
      }
      this.blockEdit.transportations.splice(transportation.index, 1)
      for (let i = 0; i < this.blockEdit.transportations.length; i++) {
        this.blockEdit.transportations[i].index = i
      }
      this.transportationsIndex = this.blockEdit.transportations.length
    },
    adjustHeight(){
      let textarea = this.$refs.adjust_textarea
      let resetHeight = new Promise(function(resolve) {
        resolve(textarea.style.height = 'auto')
      })
      resetHeight.then(function(){
        textarea.style.height = textarea.scrollHeight + 'px'
      })
    }
  }

}
</script>

<style scoped>
.info-block-form {
  border: solid #FF990D;
  border-radius: 6px;
}

.info-block-left {
  border-right: solid thin #FF990D;
}

.info-block-bottom {
  border-top: solid thin #FF990D;
}

.save-button {
  background-color: #FF990D;
}

.info-block-photo {
  width: 100%;
}

.word-break {
  word-break: break-word;
}

.font-small {
  font-size: 14px;
}

.content-lavel {
  background-color: gray;
  border-radius: 4px;
}

.info-border {
  border-radius: 4px;
}

.time-wave {
  transform: rotate(90deg);
}

.timepicker {
  font-size: 14px;
}

.icon-color {
  color: gray;
}
</style>
