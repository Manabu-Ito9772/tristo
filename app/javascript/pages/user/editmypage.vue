<template>
  <div class="container-fluid mt-4 mb-4">
    <template v-if="$mq == 'xs'">
      <div class="row">
        <div class="col-12 pt-3 pb-4 text-center">
          <h3 class="p-0 m-0 d-inline font-weight-bold text-muted">
            プロフィール編集
          </h3>
        </div>
        <div class="col-12">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="max:100"
              >
                <h5
                  id="プロフィール画像"
                  class="p-1 text-center text-white font-weight-bold form-label"
                >
                  プロフィール画像
                </h5>
                <input
                  name="プロフィール画像"
                  class="form-control mt-2"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:100"
              >
                <h5
                  id="ユーザーネーム"
                  class="mt-4 p-1 text-center text-white font-weight-bold form-label"
                >
                  ユーザーネーム
                </h5>
                <input
                  v-model="user.name"
                  name="ユーザーネーム"
                  class="form-control mt-2"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="max:1000"
              >
                <h5
                  id="自己紹介"
                  class="mt-4 p-1 text-center text-white font-weight-bold form-label"
                >
                  自己紹介
                </h5>
                <textarea
                  ref="area"
                  v-model="user.description"
                  :style="styles"
                  name="説明"
                  rows="3"
                  class="form-control"
                />
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="mt-4 text-center">
              <button
                class="btn text-white font-weight-bold button"
                @click="handleSubmit(updateCurrentUser)"
              >
                保存
              </button>
            </div>
          </ValidationObserver>
        </div>
      </div>
    </template>

    <template v-else>
      <div class="row">
        <h3 class="col-12 p-2 m-0 text-center text-white font-weight-bold top-title">
          プロフィール編集
        </h3>
        <div class="col-12 p-4 bg-white overview">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="max:100"
              >
                <h5
                  id="プロフィール画像"
                  class="p-1 text-center text-white font-weight-bold form-label"
                >
                  プロフィール画像
                </h5>
                <input
                  name="プロフィール画像"
                  class="form-control mt-2 bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:100"
              >
                <h5
                  id="ユーザーネーム"
                  class="mt-4 p-1 text-center text-white font-weight-bold form-label"
                >
                  ユーザーネーム
                </h5>
                <input
                  v-model="user.name"
                  name="ユーザーネーム"
                  class="form-control mt-2 bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="max:1000"
              >
                <h5
                  id="自己紹介"
                  class="mt-4 p-1 text-center text-white font-weight-bold form-label"
                >
                  自己紹介
                </h5>
                <textarea
                  ref="area"
                  v-model="user.description"
                  :style="styles"
                  name="説明"
                  rows="3"
                  class="form-control bg-light"
                />
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="mt-4 text-center">
              <button
                class="btn text-white font-weight-bold button"
                @click="handleSubmit(updateCurrentUser)"
              >
                保存
              </button>
            </div>
          </ValidationObserver>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'EditMyPage',
  data() {
    return {
      user: {
        name: '',
        description: '',
      },
      height: '',
    }
  },
  computed: {
    ...mapGetters('users', [
      'authUser'
    ]),
    styles(){
      return {
        'height': this.height
      }
    }
  },
  watch:{
    'user.description'(){
      this.resize()
    },
  },
  created() {
    this.user = Object.assign({}, this.authUser)
    this.resize()
  },
  methods: {
    ...mapActions('users', [
      'updateUser'
    ]),
    async updateCurrentUser() {
      try {
        await this.updateUser(this.user)
        this.$router.go(-1)
      } catch (error) {
        console.log(error)
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
.container-fluid {
  max-width: 500px;
}

.top-title {
  background-color: #FF00EB;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.overview {
  border: solid #FF00EB;
  border-width: 0rem 0.3rem 0.3rem 0.3rem;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
}

.form-label {
  background-color: #6A6A6A;
  border-radius: 4px;
}

.button {
  width: 100px;
  border-radius: 20px;
  background-color: #FF00EB;
}
</style>
