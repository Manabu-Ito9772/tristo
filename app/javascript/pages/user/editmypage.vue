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
            <div class="form-group text-center m-0">
              <ValidationProvider
                v-slot="{ errors }"
                ref="provider"
                name="プロフィール画像"
                rules="image|size:5242.88"
              >
                <h5
                  id="プロフィール画像"
                  class="p-1 mb-4 text-center text-white font-weight-bold form-label"
                >
                  プロフィール画像
                </h5>
                <div class="d-flex justify-content-center align-items-center">
                  <div>
                    <template v-if="uploadAvatar">
                      <img
                        :src="previewAvatar"
                        class="user-icon"
                      >
                    </template>
                    <template v-else>
                      <template v-if="avatar">
                        <img
                          :src="avatar"
                          class="user-icon"
                        >
                      </template>
                      <template v-else>
                        <img
                          src="~default.jpg"
                          class="user-icon"
                        >
                      </template>
                    </template>
                    <template v-if="uploadAvatar || avatar">
                      <div>
                        <div
                          class="mt-2 d-inline-block icon"
                          @click="resetAvatar"
                        >
                          <font-awesome-icon
                            :icon="['far', 'times-circle']"
                            class="fa-lg"
                          />
                        </div>
                      </div>
                    </template>
                  </div>
                  <label class="mb-0 ml-3 mr-3">
                    <template v-if="isMobile">
                      <template v-if="uploadAvatar || avatar">
                        <p class="pl-3 pr-3 text-dark file-button-mobile file-margin">
                          画像を選択
                        </p>
                      </template>
                      <template v-else>
                        <p class="mb-0 pl-3 pr-3 text-dark file-button-mobile">
                          画像を選択
                        </p>
                      </template>
                    </template>
                    <template v-else>
                      <template v-if="uploadAvatar || avatar">
                        <p class="pl-3 pr-3 text-dark file-button file-margin">
                          画像を選択
                        </p>
                      </template>
                      <template v-else>
                        <p class="mb-0 pl-3 pr-3 text-dark file-button">
                          画像を選択
                        </p>
                      </template>
                    </template>
                    <input
                      v-if="isVisibleFileInput"
                      id="avatar"
                      type="file"
                      accept="image/png,image/jpeg"
                      name="プロフィール画像"
                      class="d-none"
                      @change="handleChange"
                    >
                  </label>
                </div>
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:30"
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
                rules="max:500"
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
            <div class="form-group text-center m-0">
              <ValidationProvider
                v-slot="{ errors }"
                ref="provider"
                name="プロフィール画像"
                rules="image|size:5242.88"
              >
                <h5
                  id="プロフィール画像"
                  class="p-1 text-center text-white font-weight-bold form-label"
                >
                  プロフィール画像
                </h5>
                <template v-if="uploadAvatar">
                  <img
                    id="preview-avatar"
                    :src="previewAvatar"
                    class="mt-2 mb-2 user-icon"
                  >
                </template>
                <template v-else>
                  <template v-if="avatar">
                    <img
                      :src="avatar"
                      class="mt-2 mb-2 user-icon"
                    >
                  </template>
                  <template v-else>
                    <img
                      id="default-avatar"
                      src="~default.jpg"
                      class="mt-2 mb-2 user-icon"
                    >
                  </template>
                </template>
                <template v-if="uploadAvatar || avatar">
                  <div>
                    <div
                      class="d-inline-block icon"
                      @click="resetAvatar"
                    >
                      <font-awesome-icon
                        :icon="['far', 'times-circle']"
                        class="fa-lg"
                      />
                    </div>
                  </div>
                </template>
                <input
                  v-if="isVisibleFileInput"
                  id="avatar"
                  type="file"
                  accept="image/png,image/jpeg"
                  name="プロフィール画像"
                  class="mt-3 form-control-file mx-auto file-input"
                  @change="handleChange"
                >
                <span class="text-danger">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="form-group m-0">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:30"
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
                rules="max:500"
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
          </ValidationObserver>
        </div>

        <TermAndPolicyLink />
      </div>
    </template>
  </div>
</template>

<script>
import 'default.jpg'
import TermAndPolicyLink from '../../components/TermAndPolicyLink'
import { mapGetters, mapActions } from 'vuex'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'EditMyPage',
  components: {
    TermAndPolicyLink
  },
  data() {
    return {
      user: {
        name: '',
        description: '',
        avatar_url: ''
      },
      height: '',
      previewAvatar: '',
      uploadAvatar: '',
      avatar: '',
      isVisibleFileInput: true,
      isMobile: isMobile

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
    this.getAvatarUrl()
    this.resize()
  },
  methods: {
    ...mapActions('users', [
      'updateUser',
    ]),
    resize(){
      this.height = 'auto'
      this.$nextTick(()=>{
        this.height = this.$refs.area.scrollHeight + 'px'
      })
    },
    async handleChange(event) {
      this.previewAvatar = URL.createObjectURL(event.target.files[0])
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.uploadAvatar = event.target.files[0]
    },
    async updateCurrentUser() {
      const formData = new FormData()
      formData.append('name', this.user.name)
      formData.append('description', this.user.description)
      if (this.uploadAvatar) formData.append('avatar', this.uploadAvatar)

      await this.$axios.patch(`users/${this.authUser.id}`, formData)
        .then(res => {
          this.$store.commit('users/setUser', res.data)
        })
        .catch(err => console.log(err.response))
      this.$router.push({ name: 'MyPage' })
    },
    getAvatarUrl() {
      let avatar = this.authUser.avatar_url.split('/')
      let avatar_url = avatar.slice(-1)[0]
      if (avatar_url != 'default-image.jpg') {
        this.avatar = this.authUser.avatar_url
      }
    },
    resetAvatar() {
      if (this.previewAvatar) {
        this.previewAvatar = ''
        this.uploadAvatar = ''
        this.isVisibleFileInput = false
        this.$nextTick(() => (this.isVisibleFileInput = true))
      } else {
        this.$axios.patch(`users/${this.authUser.id}/reset_avatar`)
          .catch(err => console.log(err.response))
        this.avatar = ''
      }
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

.user-icon {
  width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
}

.file-input {
  width: 65%;
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

.icon {
  color: gray;
  font-size: 18px;
  cursor: pointer;
}

.icon:hover {
  color: #383838;
}

.file-margin {
  margin-bottom: 35px;
}
</style>
