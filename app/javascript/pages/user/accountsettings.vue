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
                <template v-if="emailError">
                  <span class="text-danger d-block">
                    このメールアドレスは既に使われています
                  </span>
                </template>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="password_format|min:5|max:30"
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
                      <span
                        class="pointer"
                        @click="hidePassword"
                      >
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
              <template v-if="isMobile">
                <div
                  class="text-white font-weight-bold button-mobile"
                  @click="handleSubmit(updateCurrentUser)"
                >
                  保存
                </div>
              </template>
              <template v-else>
                <div
                  class="text-white font-weight-bold button"
                  @click="handleSubmit(updateCurrentUser)"
                >
                  保存
                </div>
              </template>
            </div>

            <div class="mt-2 text-right">
              <template v-if="isMobile">
                <p
                  id="delete-membership"
                  class="btn font-weight-bold text-muted"
                  @click="deleteCurrentUser"
                >
                  退会する
                </p>
              </template>
              <template v-else>
                <p
                  id="delete-membership"
                  class="btn font-weight-bold delete-user"
                  @click="deleteCurrentUser"
                >
                  退会する
                </p>
              </template>
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
        <div class="col-12 pt-4 pb-2 pl-4 pr-4 bg-white overview">
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
                <template v-if="emailError">
                  <span class="text-danger d-block">
                    このメールアドレスは既に使われています
                  </span>
                </template>
              </ValidationProvider>
            </div>

            <ValidationProvider
              v-slot="{ errors }"
              rules="password_format|min:5|max:30"
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
                      <span
                        class="pointer"
                        @click="hidePassword"
                      >
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
              <template v-if="isMobile">
                <div
                  class="text-white font-weight-bold button-mobile"
                  @click="handleSubmit(updateCurrentUser)"
                >
                  保存
                </div>
              </template>
              <template v-else>
                <div
                  class="text-white font-weight-bold button"
                  @click="handleSubmit(updateCurrentUser)"
                >
                  保存
                </div>
              </template>
            </div>
            <div class="mt-2 pr-0 text-right">
              <template v-if="isMobile">
                <p
                  id="delete-membership"
                  class="d-inline-block m-0 p-0 font-weight-bold text-muted pointer"
                  @click="deleteCurrentUser"
                >
                  退会する
                </p>
              </template>
              <template v-else>
                <p
                  id="delete-membership"
                  class="d-inline-block m-0 p-0 font-weight-bold delete-user"
                  @click="deleteCurrentUser"
                >
                  退会する
                </p>
              </template>
            </div>
          </ValidationObserver>
        </div>

        <TermAndPolicyLink />
      </div>
    </template>
  </div>
</template>

<script>
import TermAndPolicyLink from '../../components/TermAndPolicyLink'
import { mapGetters, mapActions } from 'vuex'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'AccountSettings',
  components: {
    TermAndPolicyLink
  },
  data() {
    return {
      preuser: {},
      user: {
        email: '',
        password: ''
      },
      inputType: 'password',
      emailError: false,
      isMobile: isMobile
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
    this.scrollTop()
  },
  methods: {
    ...mapActions('users', [
      'deleteUser'
    ]),
    async updateCurrentUser() {
      if (this.user.password == '') {
        delete this.user.password
      }
      await this.$axios.patch(`users/${this.authUser.id}`, this.user)
        .then(res => {
          this.$store.commit('users/setUser', res.data)
          this.$router.push({ name: 'MyPage' })
          this.$store.commit('pages/setCurrentPage', 'user')
        })
        .catch(error => {
          for (let err of error.response.data.email) {
            if (err == 'has already been taken') {
              this.emailError = true
            }
          }
          console.log(error.response)
        })
    },
    deleteCurrentUser() {
      if (confirm('本当に退会しますか？')) {
        try {
          this.deleteUser()
          this.$store.commit('pages/setCurrentPage', 'home')
          this.$router.push({ name: 'ArticleIndex', params: { msg: true } })
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
    },
    scrollTop() {
      window.scrollTo({
        top: 0,
        behavior: 'instant'
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
  background-color: #FF58F2;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.overview {
  border: solid #FF58F2;
  border-width: 0rem 0.3rem 0.3rem 0.3rem;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
}

.form-label {
  background-color: #6A6A6A;
  border-radius: 4px;
}

.button {
  display: inline-block;
  background-color: #FF58F2;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.button:hover {
  background-color: #C642BC;
  position: relative;
}

.button-mobile {
  display: inline-block;
  background-color: #FF58F2;
  padding: 8px 25px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.button-mobile:active {
  background-color: #C642BC;
  position: relative;
}

.eye-icon {
  width: 26.66px;
  cursor: pointer;
}

.pointer {
  cursor: pointer;
}

.delete-user {
  color: gray;
  cursor: pointer;
}

.delete-user:hover {
  color: #525252;
}
</style>
