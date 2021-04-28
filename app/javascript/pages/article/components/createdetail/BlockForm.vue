<template>
  <div>
    <template v-if="isVisibleForm">
      <ValidationObserver
        v-slot="{ handleSubmit }"
        ref="observer"
      >
        <template v-if="$mq == 'sm' || $mq == 'xs'">
          <template v-if="isVisibleAddBlockButton">
            <template v-if="blockcount < 20">
              <div class="text-center">
                <template v-if="isMobile">
                  <div
                    class="d-inline-block text-center arrow-button-mobile"
                    @click="handleSubmit(addBlock)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'arrow-circle-up']"
                      class="fa-lg"
                    />
                  </div>
                </template>
                <template v-else>
                  <div
                    class="d-inline-block text-center arrow-button"
                    @click="handleSubmit(addBlock)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'arrow-circle-up']"
                      class="fa-lg"
                    />
                  </div>
                </template>
              </div>
              <div class="pt-2 pl-3 pr-3 text-center">
                <template v-if="isMobile">
                  <div
                    class="d-inline-block mt-1 font-weight-bold add-button-mobile"
                    @click="handleSubmit(addBlock)"
                  >
                    ブロックを追加
                  </div>
                </template>
                <template v-else>
                  <div
                    class="d-inline-block mt-1 font-weight-bold add-button"
                    @click="handleSubmit(addBlock)"
                  >
                    ブロックを追加
                  </div>
                </template>
              </div>
            </template>
          </template>
        </template>

        <div class="bg-white mt-3 pt-3 pl-3 pr-3 info-block-form">
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
              minute-interval="5"
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
              minute-interval="5"
              close-on-complete
            />
          </div>

          <ValidationProvider
            v-slot="{ errors }"
            rules="max:100"
          >
            <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
              イベント
            </p>
            <input
              v-model="blockAndCost.block.title"
              name="イベント"
              class="form-control bg-light"
            >
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>

          <ValidationProvider
            v-slot="{ errors }"
            rules="required|max:100"
          >
            <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
              スポット（必須）
            </p>
            <input
              v-model="blockAndCost.block.place"
              name="スポット"
              class="mb-2 form-control bg-light"
            >
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>

          <ValidationProvider
            v-slot="{ errors }"
            rules="max:500"
          >
            <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
              スポットのホームページURL
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
            :key="`a-${spending.index}`"
          >
            <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border cost-box spending">
              <div class="row">
                <div class="col-12 mb-2">
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="input|max:100"
                  >
                    <p class="pl-2 m-0">
                      内容
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
                      :key="`b-${spend.id}`"
                      :value="spend.value"
                    >
                      {{ spend.name }}
                    </option>
                  </select>
                </div>

                <div class="col-6">
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="input|max:50|numeric"
                  >
                    <p class="pl-2 m-0">
                      価格({{ currency }})
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
                <template v-if="isMobile">
                  <div
                    class="pt-3 pr-1 d-inline-block icon-mobile"
                    @click="deleteSpending(spending)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'trash-alt']"
                      class="fa-lg"
                    />
                  </div>
                </template>
                <template v-else>
                  <div
                    class="pt-3 pr-1 d-inline-block icon"
                    @click="deleteSpending(spending)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'trash-alt']"
                      class="fa-lg"
                    />
                  </div>
                </template>
              </div>
            </div>
          </div>
          <div class="mt-4 text-center">
            <template v-if="isMobile">
              <div
                class="font-weight-bold add-cost-button-mobile"
                @click="addSpendingForm"
              >
                <font-awesome-icon
                  :icon="['fas', 'plus-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
            <template v-else>
              <div
                class="font-weight-bold add-cost-button"
                @click="addSpendingForm"
              >
                <font-awesome-icon
                  :icon="['fas', 'plus-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
          </div>

          <ValidationProvider
            v-slot="{ errors }"
            rules="max:1000"
          >
            <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
              メモ
            </p>
            <textarea
              ref="area"
              v-model="blockAndCost.block.comment"
              :style="styles"
              name="メモ"
              class="mb-4 form-control bg-light"
              rows="2"
            />
            <span class="text-danger">{{ errors[0] }}</span>
          </ValidationProvider>

          <ValidationProvider
            v-slot="{ errors }"
            ref="provider"
            name="写真"
            rules="image|size:5242.88"
          >
            <div class="mb-4">
              <p class="mt-4 text-center text-white content-lavel m-0">
                写真
              </p>
              <template v-if="previewImage">
                <img
                  :src="previewImage"
                  class="mt-2 mb-1 image"
                >
                <div class="text-center">
                  <div
                    id="delete-btn"
                    class="d-inline-block icon"
                    @click="deleteImage"
                  >
                    <font-awesome-icon
                      :icon="['far', 'times-circle']"
                      class="fa-lg"
                    />
                  </div>
                </div>
              </template>
              <div class="text-center">
                <label class="mt-2">
                  <template v-if="isMobile">
                    <p class="mb-0 pl-3 pr-3 text-dark file-button-mobile">
                      画像を選択
                    </p>
                  </template>
                  <template v-else>
                    <p class="mb-0 pl-3 pr-3 text-dark file-button">
                      画像を選択
                    </p>
                  </template>
                  <input
                    v-if="isVisibleFileInput"
                    id="image"
                    type="file"
                    accept="image/png,image/jpeg"
                    name="写真"
                    class="d-none"
                    @change="handleChange"
                  >
                </label>
              </div>
              <span class="text-danger">{{ errors[0] }}</span>
            </div>
          </ValidationProvider>

          <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
            次のスポットまでの移動手段
          </p>
          <div
            v-for="transportation in blockAndCost.transportations"
            :key="`c-${transportation.index}`"
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
                      class="form-control"
                    >
                    <span class="text-danger">{{ errors[0] }}</span>
                  </ValidationProvider>
                </div>

                <div class="col-6">
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="mean"
                  >
                    <p class="pl-2 m-0">
                      手段
                    </p>
                    <select
                      v-model="transportation.means"
                      name="手段"
                      class="form-control"
                    >
                      <option
                        v-for="transport in transportationMeans"
                        :key="`d-${transport.id}`"
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
                <template v-if="isMobile">
                  <div
                    class="pt-3 pr-1 d-inline-block icon-mobile"
                    @click="deleteTransportation(transportation)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'trash-alt']"
                      class="fa-lg"
                    />
                  </div>
                </template>
                <template v-else>
                  <div
                    class="pt-3 pr-1 d-inline-block icon"
                    @click="deleteTransportation(transportation)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'trash-alt']"
                      class="fa-lg"
                    />
                  </div>
                </template>
              </div>
            </div>
          </div>
          <div class="mt-4 pb-4 text-center">
            <template v-if="isMobile">
              <div
                class="font-weight-bold add-cost-button-mobile"
                @click="addTransportationForm"
              >
                <font-awesome-icon
                  :icon="['fas', 'plus-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
            <template v-else>
              <div
                class="font-weight-bold add-cost-button"
                @click="addTransportationForm"
              >
                <font-awesome-icon
                  :icon="['fas', 'plus-circle']"
                  class="fa-lg"
                />
              </div>
            </template>
          </div>

          <template v-if="$mq == 'lg'">
            <template v-if="isVisibleAddBlockButton">
              <template v-if="blockcount < 20">
                <div class="mt-3 pb-4 text-center">
                  <template v-if="isMobile">
                    <div
                      class="d-inline-block text-white font-weight-bold add-button-mobile"
                      @click="handleSubmit(addBlock)"
                    >
                      ブロックを追加
                    </div>
                  </template>
                  <template v-else>
                    <div
                      class="d-inline-block text-white font-weight-bold add-button"
                      @click="handleSubmit(addBlock)"
                    >
                      ブロックを追加
                    </div>
                  </template>
                </div>
              </template>
            </template>
          </template>
        </div>
      </ValidationObserver>
    </template>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect'

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
    },
    blockcount: {
      type: Number,
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
          leaving_time: '',
          position: 0,
          uploadImage: ''
        },
        spendings: [],
        transportations: [],
      },
      spendingsIndex: 0,
      transportationsIndex: 0,
      isVisibleAddBlockButton: true,
      isVisibleForm: true,
      height: '',
      previewImage: '',
      isVisibleFileInput: true,
      isMobile: isMobile
    }
  },
  computed: {
    styles(){
      return {
        'height': this.height
      }
    }
  },
  watch:{
    'blockAndCost.block.comment'() {
      this.resize()
    }
  },
  methods :{
    async handleChange(event) {
      this.previewImage = URL.createObjectURL(event.target.files[0])
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.blockAndCost.block.uploadImage = event.target.files[0]
    },
    addBlock() {
      if (this.dayid && this.blockcount < 20) {
        this.blockAndCost.block.day_id = this.dayid
        this.blockAndCost.block.position = this.blockcount + 1
        this.$emit('addBlock', this.blockAndCost)
        this.spendingsIndex = 0
        this.transportationsIndex = 0
        this.$refs.observer.reset()
      }
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
    showForm() {
      this.isVisibleForm = true
    },
    closeForm() {
      this.isVisibleForm = false
    },
    deleteImage() {
      this.previewImage = ''
      this.blockAndCost.block.uploadImage = ''
      this.isVisibleFileInput = false
      this.$nextTick(() => (this.isVisibleFileInput = true))
    },
    resize(){
      this.height = 'auto'
      this.$nextTick(()=>{
        this.height = this.$refs.area.scrollHeight + 'px'
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

.add-button {
  display: inline-block;
  background-color: #FF990D;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 6px;
}

.add-button:hover {
  background-color: #D37C04;
  position: relative;
}

.add-button-mobile {
  display: inline-block;
  background-color: #FF990D;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 6px;
}

.add-button-mobile:active {
  background-color: #D37C04;
  position: relative;
}

.add-cost-button {
  display: inline-block;
  color: gray;
  font-size: 20px;
  text-align: center;
  cursor: pointer;
}

.add-cost-button:hover {
  color: #383838;
  position: relative;
}

.add-cost-button-mobile {
  display: inline-block;
  color: gray;
  font-size: 20px;
  text-align: center;
  cursor: pointer;
}

.add-cost-button-mobile:active {
  color: #383838;
  position: relative;
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

.cost-box {
  border-radius: 4px;
}

.file-button {
  display: inline-block;
  background-color: #fff;
  border: solid thin rgb(206, 212, 218);
  padding: 2px 25px;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.file-button:hover {
  background-color: rgb(206, 212, 218);
  position: relative;
}

.file-button-mobile {
  display: inline-block;
  background-color: #fff;
  border: solid thin rgb(206, 212, 218);
  padding: 2px 25px;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.file-button-mobile:active {
  background-color: rgb(206, 212, 218);
  position: relative;
}

.image {
  width: 100%;
  border-radius: 4px;
  cursor: pointer;
}

.arrow-button {
  font-size: 40px;
  color: gray;
  cursor: pointer;
}

.arrow-button:hover {
  color: #383838;
}

.arrow-button-mobile {
  font-size: 40px;
  color: gray;
}

.arrow-button-mobile:active {
  color: #383838;
}

.add-block-msg {
  color: #FF990D;
}

.icon {
  color: gray;
  font-size: 18px;
  cursor: pointer;
}

.icon:hover {
  color: #383838;
}

.icon-mobile {
  color: gray;
  font-size: 18px;
  cursor: pointer;
}

.icon-mobile:active {
  color: #383838;
}
</style>
