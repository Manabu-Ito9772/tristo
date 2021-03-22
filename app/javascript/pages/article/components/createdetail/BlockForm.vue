<template>
  <div class="bg-white mt-4 mb-4 pt-3 pl-3 pr-3 info-block-form">
    <ValidationObserver v-slot="{ handleSubmit }">
      <p class="p-0 mb-2 text-center text-white content-lavel">
        時間
      </p>
      <div class="d-flex justify-content-between align-items-center text-dark">
        <Timepicker
          v-model="blockAndCost.block.arriving_time"
          format="H:mm"
          input-class="form-control p-1 text-center bg-light arriving_time"
          input-width="100%"
          placeholder="到着時間"
          hour-label="時"
          minute-label="分"
          close-on-complete
        />
        <h5 class="pl-2 pr-2 m-0">
          〜
        </h5>
        <Timepicker
          v-model="blockAndCost.block.leaving_time"
          format="H:mm"
          input-class="form-control p-1 text-center bg-light leaving_time"
          input-width="100%"
          placeholder="出発時間"
          hour-label="時"
          minute-label="分"
          close-on-complete
        />
      </div>

      <ValidationProvider
        v-slot="{ errors }"
        rules="required|max:100"
      >
        <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
          * イベント
        </p>
        <input
          v-model="blockAndCost.block.title"
          name="イベント"
          placeholder="例）食べ歩き"
          class="form-control bg-light"
        >
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <ValidationProvider
        v-slot="{ errors }"
        rules="max:100"
      >
        <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
          場所
        </p>
        <input
          v-model="blockAndCost.block.place"
          name="場所"
          placeholder="例）〇〇通り"
          class="mb-2 form-control bg-light"
        >
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <ValidationProvider
        v-slot="{ errors }"
        rules="max:500"
      >
        <p class="m-0 text-center">
          ホームページURL
        </p>
        <input
          v-model="blockAndCost.block.place_info"
          name="ホームページURL"
          class="form-control bg-light"
        >
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
        コスト
      </p>
      <div
        v-for="spending in blockAndCost.spendings"
        :key="`first-${spending.index}`"
      >
        <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border cost-box spending">
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
                  placeholder="例）ソフトクリーム"
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
                  :key="`third-${spend.id}`"
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

      <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
        次のスポットまでの移動手段
      </p>
      <div
        v-for="transportation in blockAndCost.transportations"
        :key="`second-${transportation.index}`"
      >
        <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border cost-box transport">
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
                  placeholder="例）原宿駅 〜 東京駅"
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
                    :key="`fourth-${transport.id}`"
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

      <ValidationProvider
        v-slot="{ errors }"
        rules="max:1000"
      >
        <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
          コメント
        </p>
        <textarea
          ref="adjust_textarea"
          v-model="blockAndCost.block.comment"
          name="コメント"
          class="mb-4 form-control bg-light"
          rows="2"
          @keydown="adjustHeight"
        />
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>

      <p class="mt-4 text-center text-white content-lavel m-0">
        アイキャッチ
      </p>
      <div class="pt-3 pl-3 pr-3">
        <img
          src="../../../../images/sample.png"
          class="mb-3 info-block-photo"
        >
      </div>
      <template v-if="isVisibleAddBlockButton">
        <div class="pt-2 pb-3 pl-3 pr-3 text-center info-block-bottom">
          <p class="m-0 text-secondary">
            * 必須項目
          </p>
          <button
            class="btn d-inline-block pl-5 pr-5 mt-1 text-white font-weight-bold save-button"
            @click="handleSubmit(addBlock)"
          >
            ブロックを追加
          </button>
        </div>
      </template>
    </ValidationObserver>
  </div>
</template>

<script>
export default {
  name: 'BlockForm',
  props: {
    dayid: {
      type: Number,
      required: true
    },
    currency: {
      type: String,
      required: true
    }
  },
  data() {
    return {
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
      blockAndCost: {
        block: {
          day_id: '',
          title: '',
          place: '',
          place_info: '',
          comment: '',
          arriving_time: '',
          leaving_time: ''
        },
        spendings: [],
        transportations: [],
      },
      spendingsIndex: 0,
      transportationsIndex: 0,
      isVisibleAddBlockButton: true
    }
  },
  methods :{
    addBlock() {
      if (this.dayid) {
        this.blockAndCost.block.day_id = this.dayid
        this.$emit('addBlock', this.blockAndCost)
        this.spendingsIndex = 0
        this.transportationsIndex = 0
        this.resetInput()
      }
    },
    resetInput() {
      this.blockAndCost.block.day_id = ''
      this.blockAndCost.block.title = ''
      this.blockAndCost.block.place = ''
      this.blockAndCost.block.place_info = ''
      this.blockAndCost.block.comment = ''
      this.blockAndCost.block.arriving_time = ''
      this.blockAndCost.block.leaving_time = ''
      this.blockAndCost.spendings = []
      this.blockAndCost.transportations = []
    },
    addSpendingForm() {
      let additionalForm = {
        block_id: '',
        description: '',
        genre: '',
        cost: '',
        index: this.spendingsIndex
      }
      this.blockAndCost.spendings.push(additionalForm)
      this.spendingsIndex += 1
    },
    addTransportationForm() {
      let additionalForm = {
        block_id: '',
        description: '',
        means: '',
        cost: '',
        index: this.transportationsIndex
      }
      this.blockAndCost.transportations.push(additionalForm)
      this.transportationsIndex += 1
    },
    deleteSpending(spending) {
      this.blockAndCost.spendings.splice(spending.index, 1)
      for (let i = 0; i < this.blockAndCost.spendings.length; i++) {
        this.blockAndCost.spendings[i].index = i
      }
      this.spendingsIndex = this.blockAndCost.spendings.length
    },
    deleteTransportation(transportation) {
      this.blockAndCost.transportations.splice(transportation.index, 1)
      for (let i = 0; i < this.blockAndCost.transportations.length; i++) {
        this.blockAndCost.transportations[i].index = i
      }
      this.transportationsIndex = this.blockAndCost.transportations.length
    },
    closeAddBlockButton() {
      this.isVisibleAddBlockButton = false
    },
    openAddBlockButton() {
      this.isVisibleAddBlockButton = true
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

.info-block-bottom {
  border-top: solid #FF990D;
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

.icon-color {
  color: gray;
}

.cost-box {
  border-radius: 4px;
}
</style>
