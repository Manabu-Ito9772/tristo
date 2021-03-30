<template>
  <div class="container-fluid mt-4 mb-4">
    <template v-if="$mq == 'xs'">
      <div class="row">
        <div class="col-12 pt-3 pb-4 text-center">
          <h3 class="p-0 m-0 d-inline font-weight-bold text-muted">
            アカウント設定
          </h3>
        </div>
        <div class="col-12">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|email|max:100"
              >
                <h5
                  id="メールアドレス"
                  class="p-1 text-center text-white font-weight-bold form-label"
                >
                  メールアドレス
                </h5>
                <input
                  v-model="user.email"
                  name="メールアドレス"
                  class="form-control mt-2"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="password_format|min:5|max:100"
            >
              <h5
                id="パスワード"
                class="mt-4 p-1 text-center text-white font-weight-bold form-label"
              >
                パスワード
              </h5>
              <div class="input-group mt-2">
                <input
                  v-model="user.password"
                  name="パスワード"
                  :type="inputType"
                  placeholder="新しいパスワードを入力してください"
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

            <div class="mt-4 text-center">
              <button
                class="btn text-white font-weight-bold button"
                @click="handleSubmit(updateCurrentUser)"
              >
                保存
              </button>
            </div>

            <div class="mt-2 text-right">
              <p
                id="delete-membership"
                class="btn text-muted font-weight-bold"
                @click="deleteCurrentUser"
              >
                退会する
              </p>
            </div>
          </ValidationObserver>
        </div>
      </div>
    </template>

    <template v-else>
      <div class="row">
        <h3 class="col-12 p-2 m-0 text-center text-white font-weight-bold top-title">
          アカウント設定
        </h3>
        <div class="col-12 p-4 bg-white overview">
          <ValidationObserver v-slot="{ handleSubmit }">
            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|email|max:100"
              >
                <h5
                  id="メールアドレス"
                  class="p-1 text-center text-white font-weight-bold form-label"
                >
                  メールアドレス
                </h5>
                <input
                  v-model="user.email"
                  name="メールアドレス"
                  class="form-control mt-2 bg-light"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="password_format|min:5|max:100"
            >
              <h5
                id="パスワード"
                class="mt-4 p-1 text-center text-white font-weight-bold form-label"
              >
                パスワード
              </h5>
              <div class="input-group mt-2">
                <input
                  v-model="user.password"
                  name="パスワード"
                  :type="inputType"
                  placeholder="新しいパスワードを入力してください"
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
        <div class="col-12 mt-1 pr-0 text-right">
          <p
            id="delete-membership"
            class="btn p-0 text-muted font-weight-bold"
            @click="deleteCurrentUser"
          >
            退会する
          </p>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'AccountSettings',
  data() {
    return {
      preuser: {},
      user: {
        email: '',
        password: ''
      },
      inputType: 'password'
    }
  },
  computed: {
    ...mapGetters('users', [
      'authUser'
    ]),
  },
  created() {
    this.preuser = Object.assign({}, this.authUser)
    this.user.email = this.preuser.email
  },
  methods: {
    ...mapActions('users', [
      'updateUser', 'deleteUser'
    ]),
    async updateCurrentUser() {
      try {
        if (this.user.password == '') {
          delete this.user.password
        }
        await this.updateUser(this.user)
        this.$router.go(-1)
      } catch (error) {
        console.log(error)
      }
    },
    deleteCurrentUser() {
      if (confirm('本当に退会しますか？')) {
        try {
          this.deleteUser()
          this.$router.push({ name: 'ArticleIndex' })
        } catch (error) {
          console.log(error)
        }
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

.eye-icon {
  width: 26.66px;
}
</style>
