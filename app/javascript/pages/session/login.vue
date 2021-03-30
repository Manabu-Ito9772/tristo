<template>
  <div class="container-fluid mt-4">
    <template v-if="$mq == 'xs'">
      <div class="row">
        <div class="col-12 pt-3 text-center">
          <h3 class="p-0 m-0 d-inline font-weight-bold text-muted">
            ログイン
          </h3>
        </div>

        <div class="col-12">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="input|email"
              >
                <input
                  v-model="user.email"
                  name="メールアドレス"
                  placeholder="メールアドレス"
                  class="form-control mt-4"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="input|password_format"
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

            <template v-if="loginError">
              <div class="mt-4 text-center">
                <span class="text-danger">メールアドレスまたはパスワードが正しくありません</span>
              </div>
            </template>

            <div class="pt-4 pb-3 text-center">
              <button
                class="btn text-white font-weight-bold button"
                @click="handleSubmit(login)"
              >
                ログイン
              </button>
            </div>
          </ValidationObserver>
        </div>
      </div>
    </template>

    <template v-else>
      <div class="row">
        <h4 class="col-12 p-2 m-0 text-center text-white font-weight-bold top-title">
          ログイン
        </h4>

        <div class="col-12 mb-4 pl-4 pr-4 bg-white overview">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="input|email"
              >
                <input
                  v-model="user.email"
                  name="メールアドレス"
                  placeholder="メールアドレス"
                  class="form-control mt-4 bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="input|password_format"
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

            <template v-if="loginError">
              <div class="mt-4 text-center">
                <span class="text-danger">メールアドレスまたはパスワードが正しくありません</span>
              </div>
            </template>

            <div class="mt-4 mb-4 text-center">
              <button
                class="btn text-white font-weight-bold button"
                @click="handleSubmit(login)"
              >
                ログイン
              </button>
            </div>
          </ValidationObserver>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'Login',
  data() {
    return {
      user: {
        email: '',
        password: '',
      },
      loginError: false,
      inputType: 'password'
    }
  },
  watch: {
    user: {
      handler() {
        this.loginError = false
      },
      deep: true
    }
  },
  methods: {
    ...mapActions('users', [
      'loginUser',
    ]),
    async login() {
      try {
        await this.loginUser(this.user)
        this.$router.push({ name: 'ArticleIndex' })
      } catch (error) {
        this.loginError = true
        console.log(error)
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
  background-color: #00D320;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.overview {
  border: solid #00D320;
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
</style>
