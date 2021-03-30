<template>
  <header>
    <template v-if="$mq == 'xs'">
      <nav class="navbar navbar-expand bg-white justify-content-between fixed-top">
        <router-link :to="{ name: 'ArticleIndex' }">
          <span class="navbar-brand header-title">TriSto</span>
        </router-link>

        <ul class="navbar-nav">
          <template v-if="authUser">
            <li class="nav-item active menu-bar">
              <DropdownMenu
                v-model="show"
                :right="right"
                :hover="hover"
              >
                <font-awesome-icon
                  :icon="['fas', 'bars']"
                  class="fa-lg"
                />
                <div slot="dropdown">
                  <template v-if="this.$route.path == '/account_settings'">
                    <div
                      class="dropdown-item"
                      @click="logout"
                    >
                      ログアウト
                    </div>
                  </template>
                  <template v-else>
                    <div
                      class="dropdown-item"
                      @click="accouSettings"
                    >
                      アカウント設定
                    </div>
                    <div
                      class="dropdown-item"
                      @click="logout"
                    >
                      ログアウト
                    </div>
                  </template>
                </div>
              </DropdownMenu>
            </li>
          </template>

          <template v-else>
            <li class="nav-item d-flex align-items-center">
              <router-link
                :to="{ name: 'Register' }"
                class="icon-color"
              >
                <p
                  class="m-0 font-weight-bold text-muted font-middle"
                >
                  ユーザー登録
                </p>
              </router-link>
            </li>

            <li class="nav-item d-flex align-items-center">
              <router-link
                :to="{ name: 'Login' }"
                class="icon-color"
              >
                <p
                  class="m-0 font-weight-bold text-muted font-middle"
                >
                  ログイン
                </p>
              </router-link>
            </li>

            <li class="nav-item active">
              <router-link
                :to="{ name: 'ArticleIndex' }"
                class="icon-selected"
              >
                <font-awesome-icon
                  :icon="['fas', 'home']"
                  class="fa-lg"
                />
              </router-link>
            </li>
          </template>
        </ul>
      </nav>
    </template>

    <template v-else>
      <nav class="navbar navbar-expand bg-white justify-content-between fixed-top">
        <router-link :to="{ name: 'ArticleIndex' }">
          <span class="navbar-brand header-title">TriSto</span>
        </router-link>

        <ul class="navbar-nav d-flex align-items-center">
          <!-- AUTH USER -->
          <template v-if="authUser">
            <li class="nav-item active">
              <!-- HOME ICON -->
              <template v-if="this.$route.path == '/trips' || this.$route.path == '/user'">
                <router-link
                  :to="{ name: 'ArticleIndex' }"
                  class="icon-selected"
                >
                  <font-awesome-icon
                    :icon="['fas', 'home']"
                    class="fa-lg"
                  />
                </router-link>
              </template>

              <template v-else-if="this.$route.path == '/trip'">
                <template v-if="prevRoute == '/trips' || prevRoute == '/user'">
                  <router-link
                    :to="{ name: 'ArticleIndex' }"
                    class="icon-selected"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'home']"
                      class="fa-lg"
                    />
                  </router-link>
                </template>

                <template v-else-if="prevRoute == '/edit_trip' && prePrePrevRoute == '/trips'">
                  <router-link
                    :to="{ name: 'ArticleIndex' }"
                    class="icon-selected"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'home']"
                      class="fa-lg"
                    />
                  </router-link>
                </template>

                <template v-else>
                  <router-link
                    :to="{ name: 'ArticleIndex' }"
                    class="icon-color"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'home']"
                      class="fa-lg"
                    />
                  </router-link>
                </template>
              </template>

              <template v-else-if="this.$route.path == '/edit_trip' && prePrevRoute == '/trips'">
                <router-link
                  :to="{ name: 'ArticleIndex' }"
                  class="icon-selected"
                >
                  <font-awesome-icon
                    :icon="['fas', 'home']"
                    class="fa-lg"
                  />
                </router-link>
              </template>

              <template v-else>
                <router-link
                  :to="{ name: 'ArticleIndex' }"
                  class="icon-color"
                >
                  <font-awesome-icon
                    :icon="['fas', 'home']"
                    class="fa-lg"
                  />
                </router-link>
              </template>
            </li>
            <!-- HOME ICON -->

            <!-- PEN ICON -->
            <li class="nav-item active">
              <template v-if="this.$route.path == '/create_trip'">
                <router-link
                  :to="{ name: 'ArticleCreateOverview' }"
                  class="icon-selected"
                >
                  <font-awesome-icon
                    :icon="['fas', 'pen']"
                    class="fa-lg"
                  />
                </router-link>
              </template>

              <template v-else-if="this.$route.path == '/create_trip_detail'">
                <router-link
                  :to="{ name: 'ArticleCreateOverview' }"
                  class="icon-selected"
                >
                  <font-awesome-icon
                    :icon="['fas', 'pen']"
                    class="fa-lg"
                  />
                </router-link>
              </template>

              <template v-else>
                <router-link
                  :to="{ name: 'ArticleCreateOverview' }"
                  class="icon-color"
                >
                  <font-awesome-icon
                    :icon="['fas', 'pen']"
                    class="fa-lg"
                  />
                </router-link>
              </template>
            </li>
            <!-- PEN ICON -->

            <!-- USER ICON -->
            <li class="nav-item active">
              <template v-if="this.$route.path == '/mypage' || this.$route.path == '/edit_mypage'">
                <router-link
                  :to="{ name: 'MyPage' }"
                  class="icon-selected"
                >
                  <font-awesome-icon
                    :icon="['fas', 'user']"
                    class="fa-lg"
                  />
                </router-link>
              </template>

              <template v-else-if="this.$route.path == '/trip'">
                <template v-if="prevRoute == '/mypage'">
                  <router-link
                    :to="{ name: 'MyPage' }"
                    class="icon-selected"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'user']"
                      class="fa-lg"
                    />
                  </router-link>
                </template>

                <template v-else-if="prevRoute == '/edit_trip' && prePrePrevRoute == '/mypage'">
                  <router-link
                    :to="{ name: 'MyPage' }"
                    class="icon-selected"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'user']"
                      class="fa-lg"
                    />
                  </router-link>
                </template>

                <template v-else>
                  <router-link
                    :to="{ name: 'MyPage' }"
                    class="icon-color"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'user']"
                      class="fa-lg"
                    />
                  </router-link>
                </template>
              </template>

              <template v-else-if="this.$route.path == '/edit_trip' && prePrevRoute == '/mypage'">
                <router-link
                  :to="{ name: 'MyPage' }"
                  class="icon-selected"
                >
                  <font-awesome-icon
                    :icon="['fas', 'user']"
                    class="fa-lg"
                  />
                </router-link>
              </template>

              <template v-else>
                <router-link
                  :to="{ name: 'MyPage' }"
                  class="icon-color"
                >
                  <font-awesome-icon
                    :icon="['fas', 'user']"
                    class="fa-lg"
                  />
                </router-link>
              </template>
            </li>
            <!-- USER ICON -->

            <!-- MENU ICON -->
            <template v-if="this.$route.path == '/account_settings'">
              <li class="nav-item active menu-bar icon-selected">
                <DropdownMenu
                  v-model="show"
                  :right="right"
                  :hover="hover"
                  :interactive="interactive"
                >
                  <font-awesome-icon
                    :icon="['fas', 'bars']"
                    class="fa-lg"
                  />
                  <div slot="dropdown">
                    <template v-if="this.$route.path == '/account_settings'">
                      <div
                        class="dropdown-item"
                        @click="logout"
                      >
                        ログアウト
                      </div>
                    </template>
                    <template v-else>
                      <div
                        class="dropdown-item"
                        @click="accouSettings"
                      >
                        アカウント設定
                      </div>
                      <div
                        class="dropdown-item"
                        @click="logout"
                      >
                        ログアウト
                      </div>
                    </template>
                  </div>
                </DropdownMenu>
              </li>
            </template>

            <template v-else>
              <li class="nav-item active menu-bar icon-color">
                <DropdownMenu
                  v-model="show"
                  :right="right"
                  :hover="hover"
                  :interactive="interactive"
                >
                  <font-awesome-icon
                    :icon="['fas', 'bars']"
                    class="fa-lg"
                  />
                  <div slot="dropdown">
                    <template v-if="this.$route.path == '/account_settings'">
                      <div
                        class="dropdown-item"
                        @click="logout"
                      >
                        ログアウト
                      </div>
                    </template>
                    <template v-else>
                      <div
                        class="dropdown-item"
                        @click="accouSettings"
                      >
                        アカウント設定
                      </div>
                      <div
                        class="dropdown-item"
                        @click="logout"
                      >
                        ログアウト
                      </div>
                    </template>
                  </div>
                </DropdownMenu>
              </li>
            </template>
          <!-- MENU ICON -->
          </template>
          <!-- AUTH USER -->

          <!-- NON AUTH USER -->
          <template v-else>
            <li class="nav-item active">
              <router-link
                :to="{ name: 'Register' }"
                class="icon-color"
              >
                <button
                  class="btn pl-0 pr-0 d-flex justify-content-center align-items-center font-weight-bold text-white register-button"
                >
                  ユーザー登録
                </button>
              </router-link>
            </li>

            <li class="nav-item active">
              <router-link
                :to="{ name: 'Login' }"
                class="icon-color"
              >
                <button
                  class="btn d-flex justify-content-center align-items-center font-weight-bold text-white login-button"
                >
                  ログイン
                </button>
              </router-link>
            </li>

            <li class="nav-item active">
              <router-link
                :to="{ name: 'ArticleIndex' }"
                class="icon-selected"
              >
                <font-awesome-icon
                  :icon="['fas', 'home']"
                  class="fa-lg"
                />
              </router-link>
            </li>
          </template>
        <!-- NON AUTH USER -->
        </ul>
      </nav>
    </template>
  </header>
</template>

<script>
import DropdownMenu from '@innologica/vue-dropdown-menu'
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'TheHeader',
  components: {
    DropdownMenu
  },
  data() {
    return {
      show: false,
      right: true,
      hover: false,
      interactive: false,
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    ...mapGetters('router', [
      'prevRoute',
      'prePrevRoute',
      'prePrePrevRoute'
    ])
  },
  methods: {
    ...mapActions('users', ['logoutUser']),
    async logout() {
      try {
        await this.logoutUser()
        await this.$router.push({ name: 'Login' })
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      } catch (error) {
        console.log(error)
      }
    },
    accouSettings() {
      this.$router.push({ name: 'AccountSettings' })
    },
  },
}
</script>

<style scoped>
.navbar {
  height: 40px;
  border-bottom: solid 1px #CBCBCB;
}

.header-title {
  color: #FF00EB;
  font-size: 30px;
}

.nav-item {
  margin-left: 10px;
}

.icon-color {
  color: gray;
  font-size: 19px;
}

.icon-selected {
  color: black;
  font-size: 19px;
}

.register-button {
  background-color: #1D51FF;
  width: 120px;
  height: 25px;
}

.login-button {
  background-color: #00D320;
  width: 120px;
  height: 25px;
}

.menu-bar {
  cursor: pointer;
}

.font-middle {
  font-size: 15px;
}
</style>
