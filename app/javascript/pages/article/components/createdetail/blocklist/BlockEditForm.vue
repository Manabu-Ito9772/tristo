<template>
  <div>
    <ValidationObserver v-slot="{ handleSubmit }">
      <div class="row bg-white mb-1 ml-0 mr-0 info-block-form block-form-to-edit">
        <div class="col-12 p-3">
          <div class="row">
            <div class="col-12">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:100"
              >
                <p class="mb-2 text-center text-white content-lavel m-0">
                  * イベント
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
              <p class="mt-4 mb-2 text-center text-white content-lavel">
                時間
              </p>
              <div class="d-flex justify-contentbetween align-items-center text-dark">
                <Timepicker
                  v-model="blockEdit.block.arriving_time"
                  format="H:mm"
                  input-class="form-control text-center p-1 bg-light"
                  input-width="100%"
                  placeholder=" "
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
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
                  placeholder=" "
                  hour-label="時"
                  minute-label="分"
                  minute-interval="5"
                  close-on-complete
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
                  場所
                </p>
                <input
                  v-model="blockEdit.block.place"
                  name="場所"
                  class="form-control bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>

              <ValidationProvider
                v-slot="{ errors }"
                rules="max:500"
              >
                <p class="mt-2 pl-2 text-center m-0">
                  ホームページURL
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
                <p class="mt-4 mb-2 text-center text-white content-lavel m-0">
                  コメント
                </p>
                <textarea
                  ref="area"
                  v-model="blockEdit.block.comment"
                  :style="styles"
                  name="コメント"
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
                name="イメージ"
                rules="image"
              >
                <p class="mt-4 text-center text-white content-lavel m-0">
                  写真（上限3枚）
                </p>
                <div
                  v-for="(image, index) in previewImages"
                  :key="index"
                  class="pt-3 pl-3 pr-3 text-center text-muted"
                >
                  <img
                    :src="image"
                    class="mb-1 info-block-photo"
                  >
                  <div @click="deleteImage(index)">
                    <font-awesome-icon
                      :icon="['far', 'times-circle']"
                      class="fa-lg"
                    />
                  </div>
                </div>
                <div class="text-center">
                  <label class="mt-2 mb-4">
                    <p class="mb-0 pl-3 pr-3 bg-white text-dark file-button">
                      画像を選択
                    </p>
                    <input
                      id="image"
                      type="file"
                      accept="image/png,image/jpeg"
                      multiple="multiple"
                      name="イメージ"
                      class="d-none"
                      @change="handleChange"
                    >
                  </label>
                </div>
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>
          </div>
        </div>

        <div class="col-12 p-3 text-center info-block-bottom">
          <button
            class="btn d-inline-block pl-5 pr-5 text-white font-weight-bold save-button"
            @click="handleSubmit(updateBlock)"
          >
            保存
          </button>
        </div>
      </div>
      <p class="mb-4 pr-1 text-secondary text-right font-small">
        * 必須項目
      </p>
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
    },
  },
  data() {
    return {
      blockEdit: {
        block: {},
        uploadImages: []
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
      spendingsIndex: 0,
      transportationsIndex: 0,
      height: '',
      previewImages: [],
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
    'blockEdit.uploadImages'() {
      if (this.blockEdit.uploadImages.length > 3) {
        this.blockEdit.uploadImages.splice(3)
        this.previewImages.splice(3)
      }
    }
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
    this.resize()
  },
  methods :{
    async handleChange(event) {
      for (let file of event.target.files) {
        this.previewImages.push(URL.createObjectURL(file))
      }
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) {
        for (let image of event.target.files) {
          this.blockEdit.uploadImages.push(image)
        }
      }
    },
    deleteImage(index) {
      this.previewImages.splice(index, 1)
      this.blockEdit.uploadImages.splice(index, 1)
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
  border: solid #FF00EB;
  border-radius: 6px;
}

.info-block-bottom {
  border-top: solid thin #FF00EB;
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

.timepicker {
  font-size: 14px;
}

.icon-color {
  color: gray;
}

.file-button {
  border: solid thin rgb(206, 212, 218);
  border-radius: 20px;
}
</style>
