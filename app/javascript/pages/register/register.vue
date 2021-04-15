<template>
  <div class="container-fluid mt-4 mb-5">
    <template v-if="$mq == 'xs'">
      <div class="row pb-5">
        <div class="col-12 pt-3 text-center">
          <h3 class="p-0 m-0 d-inline font-weight-bold text-muted">
            ユーザー登録
          </h3>
        </div>
        <div class="col-12">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:100"
              >
                <input
                  v-model="user.name"
                  name="ユーザーネーム"
                  placeholder="ユーザーネーム"
                  class="form-control mt-4"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|email|max:100"
              >
                <input
                  v-model="user.email"
                  name="メールアドレス"
                  placeholder="メールアドレス"
                  class="form-control mt-4"
                >
                <span class="text-danger">{{ errors[0] }}</span>
                <template v-if="emailError">
                  <span class="text-danger d-block">
                    このメールアドレスは既に使われています
                  </span>
                </template>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="required|password_format|min:5|max:100"
            >
              <div class="input-group mt-4">
                <input
                  v-model="user.password"
                  name="パスワード"
                  :type="inputType"
                  placeholder="パスワード"
                  class="form-control"
                >
                <div class="input-group-append">
                  <div class="input-group-text bg-white">
                    <template v-if="inputType == 'password'">
                      <span
                        class="eye-icon"
                        @click="showPassword"
                      >
                        <font-awesome-icon
                          :icon="['far', 'eye']"
                          class="fa-lg"
                        />
                      </span>
                    </template>
                    <template v-else>
                      <span @click="hidePassword">
                        <font-awesome-icon
                          :icon="['far', 'eye-slash']"
                          class="fa-lg"
                        />
                      </span>
                    </template>
                  </div>
                </div>
              </div>
              <span class="text-danger">{{ errors[0] }}</span>
            </ValidationProvider>

            <div class="form-group text-center mt-4 mb-0">
              <ValidationProvider
                v-slot="{ errors }"
                ref="provider"
                name="プロフィール画像"
                rules="image"
              >
                <div class="d-flex justify-content-center align-items-center">
                  <template v-if="previewAvatar">
                    <img
                      :src="previewAvatar"
                      class="user-icon"
                    >
                  </template>
                  <template v-else>
                    <img
                      src="~default.jpg"
                      class="user-icon"
                    >
                  </template>
                  <div class="ml-3">
                    <p
                      id="プロフィール画像"
                      class="mb-2 text-muted"
                    >
                      プロフィール画像
                    </p>
                    <label class="mb-0">
                      <p class="mb-0 pl-3 pr-3 bg-white text-dark file-button">
                        画像を選択
                      </p>
                      <input
                        id="avatar"
                        type="file"
                        accept="image/png,image/jpeg"
                        name="プロフィール画像"
                        class="d-none"
                        @change="handleChange"
                      >
                    </label>
                  </div>
                </div>
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="pt-5 pb-3 text-center">
              <button
                class="btn text-white font-weight-bold button"
                @click="handleSubmit(createNewUser)"
              >
                登録
              </button>
            </div>
          </ValidationObserver>
        </div>
      </div>
    </template>

    <template v-else>
      <div class="row">
        <h4 class="col-12 p-2 m-0 text-center text-white font-weight-bold top-title">
          ユーザー登録
        </h4>

        <div class="col-12 mb-4 pl-4 pr-4 bg-white overview">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:100"
              >
                <input
                  v-model="user.name"
                  name="ユーザーネーム"
                  placeholder="ユーザーネーム"
                  class="form-control mt-4 bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|email|max:100"
              >
                <input
                  v-model="user.email"
                  name="メールアドレス"
                  placeholder="メールアドレス"
                  class="form-control mt-4 bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
                <template v-if="emailError">
                  <span class="text-danger d-block">
                    このメールアドレスは既に使われています
                  </span>
                </template>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="required|password_format|min:5|max:100"
            >
              <div class="input-group mt-4">
                <input
                  v-model="user.password"
                  name="パスワード"
                  :type="inputType"
                  placeholder="パスワード"
                  class="form-control bg-light"
                >
                <div class="input-group-append">
                  <div class="input-group-text bg-light">
                    <template v-if="inputType == 'password'">
                      <span
                        class="eye-icon"
                        @click="showPassword"
                      >
                        <font-awesome-icon
                          :icon="['far', 'eye']"
                          class="fa-lg"
                        />
                      </span>
                    </template>
                    <template v-else>
                      <span @click="hidePassword">
                        <font-awesome-icon
                          :icon="['far', 'eye-slash']"
                          class="fa-lg"
                        />
                      </span>
                    </template>
                  </div>
                </div>
              </div>
              <span class="text-danger">{{ errors[0] }}</span>
            </ValidationProvider>

            <div class="form-group m-0 text-center">
              <ValidationProvider
                v-slot="{ errors }"
                ref="provider"
                name="プロフィール画像"
                rules="image"
              >
                <p
                  id="プロフィール画像"
                  class="center mt-4 mb-2 text-muted font-weight-bold"
                >
                  プロフィール画像
                </p>
                <template v-if="previewAvatar">
                  <img
                    :src="previewAvatar"
                    class="mb-3 user-icon"
                  >
                </template>
                <template v-else>
                  <img
                    src="~default.jpg"
                    class="mb-3 user-icon"
                  >
                </template>
                <input
                  id="avatar"
                  type="file"
                  accept="image/png,image/jpeg"
                  name="プロフィール画像"
                  class="form-control-file mx-auto file-input"
                  @change="handleChange"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="mt-4 mb-4 text-center">
              <button
                class="btn text-white font-weight-bold button"
                @click="handleSubmit(createNewUser)"
              >
                登録
              </button>
            </div>
          </ValidationObserver>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import 'default.jpg'
import { mapActions } from 'vuex'

export default {
  name: 'Register',
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
      },
      uploadAvatar: '',
      previewAvatar: '',
      emailError: false,
      inputType: 'password'
    }
  },
  watch: {
    'user.email'() {
      this.emailError = false
    }
  },
  methods: {
    ...mapActions('users', ['createUser']),
    async handleChange(event) {
      this.previewAvatar = URL.createObjectURL(event.target.files[0])
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.uploadAvatar = event.target.files[0]
    },
    async createNewUser() {
      try {
        const formData = new FormData()
        formData.append('name', this.user.name)
        formData.append('email', this.user.email)
        formData.append('password', this.user.password)
        if (this.uploadAvatar) formData.append('avatar', this.uploadAvatar)

        await this.createUser(formData)
        this.$router.push({ name: 'ArticleIndex' })
      } catch (error) {
        for (let err of error.response.data.email) {
          if (err == 'has already been taken') {
            this.emailError = true
          }
        }
        console.log(error.response)
      }
    },
    showPassword() {
      this.inputType = 'text'
    },
    hidePassword() {
      this.inputType = 'password'
    }
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 500px;
}

.top-title {
  background-color: #1D51FF;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.overview {
  border: solid #1D51FF;
  border-width: 0rem 0.3rem 0.3rem 0.3rem;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
}

.button {
  width: 100px;
  border-radius: 20px;
  background-color: #FF00EB;
}

.eye-icon {
  width: 26.66px;
}

.file-input {
  width: 65%;
}

.file-button {
  border: solid thin rgb(206, 212, 218);
  border-radius: 20px;
}

.user-icon {
  width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
}
</style>
