<template>
  <div>
    <ValidationObserver v-slot="{ handleSubmit }">
      <div class="row bg-white mb-4 ml-0 mr-0 info-block-form block-form-to-edit">
        <div class="col-12 pt-4 pb-3 pl-3 pr-3">
          <div class="d-flex justify-content-center align-items-center">
            <h5 class="m-0 mr-1 d-inline-block text-muted">
              No.
            </h5>
            <select
              v-model="blockEdit.block.position"
              name="ナンバー"
              class="ml-1 d-inline-block form-control w-25 bg-light"
            >
              <option
                v-for="(num, index) in numbers"
                :key="index"
                :value="num"
              >
                {{ num }}
              </option>
            </select>
          </div>

          <div class="row">
            <div class="col-12">
              <p class="mt-4 mb-2 text-center text-white content-lavel">
                時間
              </p>
              <div class="d-flex justify-contentbetween align-items-center text-dark">
                <Timepicker
                  v-model="blockEdit.block.arriving_time"
                  format="H:mm"
                  input-class="form-control text-center p-1 bg-light"
                  input-width="100%"
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
                  placeholder="到着時間"
                  class="timepicker"
                />
                <h5 class="pl-2 pr-2 m-0 ">
                  〜
                </h5>
                <Timepicker
                  v-model="blockEdit.block.leaving_time"
                  format="H:mm"
                  input-class="form-control text-center p-1 bg-light"
                  input-width="100%"
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
                  placeholder="出発時間"
                  class="timepicker"
                />
              </div>
            </div>

            <div class="col-12">
              <ValidationProvider
                v-slot="{ errors }"
                rules="max:100"
              >
                <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                  イベント
                </p>
                <input
                  v-model="blockEdit.block.title"
                  name="イベント"
                  class="form-control bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="col-12">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:100"
              >
                <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                  スポット（必須）
                </p>
                <input
                  v-model="blockEdit.block.place"
                  name="スポット"
                  class="form-control bg-light"
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
                  v-model="blockEdit.block.place_info"
                  name="ホームページURL"
                  class="form-control bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="col-12">
              <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                コスト
              </p>
              <div
                v-for="spending in blockEdit.block.spendings"
                :key="`e-${spending.index}`"
              >
                <div class="mb-3 pt-2 pl-3 pr-3 pb-2 border bg-light info-border spending">
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
            </div>

            <div class="col-12">
              <ValidationProvider
                v-slot="{ errors }"
                rules="max:1000"
              >
                <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                  メモ
                </p>
                <textarea
                  ref="area"
                  v-model="blockEdit.block.comment"
                  :style="styles"
                  name="メモ"
                  class="form-control bg-light"
                  rows="2"
                />
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="col-12">
              <ValidationProvider
                v-slot="{ errors }"
                ref="provider"
                name="写真"
                rules="image|size:5242.88"
              >
                <p class="mt-4 text-center text-white content-lavel m-0">
                  写真
                </p>
                <template v-if="previewImage">
                  <img
                    id="preview-image"
                    :src="previewImage"
                    class="mt-2 image"
                  >
                </template>
                <template v-else>
                  <template v-if="image">
                    <img
                      :src="image"
                      class="mt-2 image"
                    >
                  </template>
                </template>
                <template v-if="previewImage || image">
                  <div class="mt-1 text-center">
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
                    <template v-if="$mq == 'xs'">
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
                    </template>
                    <template v-else>
                      <input
                        v-if="isVisibleFileInput"
                        id="image"
                        type="file"
                        accept="image/png,image/jpeg"
                        name="写真"
                        class="form-control-file mx-auto file-input"
                        @change="handleChange"
                      >
                    </template>
                  </label>
                </div>
                <p class="m-0 text-center text-danger">
                  {{ errors[0] }}
                </p>
              </ValidationProvider>
            </div>

            <div class="col-12">
              <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                次のスポットまでの移動手段
              </p>
              <div
                v-for="transportation in blockEdit.block.transportations"
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
              <div class="mt-4 text-center">
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
            </div>
          </div>
        </div>

        <div class="col-12 mt-4 pb-4 text-center">
          <template v-if="isMobile">
            <div
              class="d-inline-block pl-5 pr-5 text-white font-weight-bold add-button-mobile"
              @click="handleSubmit(updateBlock)"
            >
              保存
            </div>
          </template>
          <template v-else>
            <div
              class="d-inline-block pl-5 pr-5 text-white font-weight-bold add-button"
              @click="handleSubmit(updateBlock)"
            >
              保存
            </div>
          </template>
        </div>
      </div>
    </ValidationObserver>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect'

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
    },
    blockcount: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      blockEdit: {
        block: {},
        uploadImage: ''
      },
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
      numbers: [],
      spendingsIndex: 0,
      transportationsIndex: 0,
      height: '',
      previewImage: '',
      image: '',
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
    'blockEdit.block.comment'(){
      this.resize()
    },
  },
  created() {
    this.blockEdit.block = Object.assign({}, this.block)
    if (this.blockEdit.block.arriving_time == null) {
      this.blockEdit.block.arriving_time = ''
    }
    if (this.blockEdit.block.leaving_time == null) {
      this.blockEdit.block.leaving_time = ''
    }
    for (let i = 0; i < this.blockEdit.block.spendings.length; i++) {
      this.blockEdit.block.spendings[i].index = i
    }
    this.spendingsIndex = this.blockEdit.block.spendings.length
    for (let i = 0; i < this.blockEdit.block.transportations.length; i++) {
      this.blockEdit.block.transportations[i].index = i
    }
    this.transportationsIndex = this.blockEdit.block.transportations.length
    this.image = this.block.image_url
    for (let num = 1; num <= this.blockcount; num++) {
      this.numbers.push(num)
    }
    this.resize()
  },
  methods :{
    async handleChange(event) {
      this.previewImage = URL.createObjectURL(event.target.files[0])
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.blockEdit.uploadImage = event.target.files[0]
    },
    updateBlock() {
      this.$emit('updateBlock', this.blockEdit)
    },
    addSpendingForm() {
      let additionalForm = {
        block_id: this.blockEdit.block.id,
        genre: '',
        description: '',
        cost: '',
        index: this.spendingsIndex
      }
      this.blockEdit.block.spendings.push(additionalForm)
      this.spendingsIndex += 1
    },
    addTransportationForm() {
      let additionalForm = {
        block_id: this.blockEdit.block.id,
        means: '',
        description: '',
        cost: '',
        index: this.transportationsIndex
      }
      this.blockEdit.block.transportations.push(additionalForm)
      this.transportationsIndex += 1
    },
    deleteSpending(spending) {
      if (spending.id) {
        this.$axios.delete(`spendings/${spending.id}`)
          .catch(err => console.log(err.response))
      }
      this.blockEdit.block.spendings.splice(spending.index, 1)
      for (let i = 0; i < this.blockEdit.block.spendings.length; i++) {
        this.blockEdit.block.spendings[i].index = i
      }
      this.spendingsIndex = this.blockEdit.block.spendings.length
    },
    deleteTransportation(transportation) {
      if (transportation.id) {
        this.$axios.delete(`transportations/${transportation.id}`)
          .catch(err => console.log(err.response))
      }
      this.blockEdit.block.transportations.splice(transportation.index, 1)
      for (let i = 0; i < this.blockEdit.block.transportations.length; i++) {
        this.blockEdit.block.transportations[i].index = i
      }
      this.transportationsIndex = this.blockEdit.block.transportations.length
    },
    deleteImage() {
      if (this.previewImage) {
        this.previewImage = ''
        this.blockEdit.uploadImage = ''
        this.isVisibleFileInput = false
        this.$nextTick(() => (this.isVisibleFileInput = true))
      } else {
        this.$axios.delete(`blocks/${this.block.id}/delete_image`)
          .catch(err => console.log(err.response))
        this.image = ''
      }
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
  border: solid #DF81A2;
  border-radius: 6px;
}

.add-button {
  display: inline-block;
  background-color: #FFAA34;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 6px;
}

.add-button:hover {
  background-color: #D68E2B;
  position: relative;
}

.add-button-mobile {
  display: inline-block;
  background-color: #FFAA34;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 6px;
}

.add-button-mobile:active {
  background-color: #D68E2B;
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

.info-border {
  border-radius: 4px;
}

.timepicker {
  font-size: 14px;
}

.file-input {
  width: 85%;
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
