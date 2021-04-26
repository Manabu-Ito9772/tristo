<template>
  <header>
    <template v-if="$mq == 'xs'">
      <nav class="navbar navbar-expand bg-white justify-content-between fixed-top">
        <router-link :to="{ name: 'TopPage' }">
          <span class="navbar-brand header-title">TriSto</span>
        </router-link>

        <ul class="navbar-nav">
          <template v-if="authUser">
            <li class="nav-item active menu-bar">
              <DropdownMenu
                v-model="show"
                :right="right"
                :hover="hover"
                :interactive="interactive"
              >
                <template v-if="currentPage == 'menu'">
                  <div class="icon-selected">
                    <font-awesome-icon
                      :icon="['fas', 'bars']"
                      class="fa-lg"
                    />
                  </div>
                </template>
                <template v-else>
                  <div class="icon-color">
                    <font-awesome-icon
                      :icon="['fas', 'bars']"
                      class="fa-lg"
                    />
                  </div>
                </template>
                <div slot="dropdown">
                  <div
                    v-if="this.$route.path != '/account_settings'"
                    class="dropdown-item"
                    @click="accouSettings"
                  >
                    アカウント設定
                  </div>
                  <div
                    v-if="this.$route.path != '/terms_of_use'"
                    class="dropdown-item"
                    @click="toTermOfUse"
                  >
                    利用規約
                  </div>
                  <div
                    v-if="this.$route.path != '/privacy_policy'"
                    class="dropdown-item"
                    @click="toPrivacyPolicy"
                  >
                    プライバシーポリシー
                  </div>
                  <div
                    class="dropdown-item"
                    @click="logout"
                  >
                    ログアウト
                  </div>
                </div>
              </DropdownMenu>
            </li>
          </template>

          <template v-else>
            <li class="nav-item d-flex align-items-center">
              <router-link :to="{ name: 'Register' }">
                <p
                  class="m-0 font-weight-bold text-muted font-middle"
                >
                  ユーザー登録
                </p>
              </router-link>
            </li>

            <li class="nav-item d-flex align-items-center">
              <router-link :to="{ name: 'Login' }">
                <p
                  class="m-0 font-weight-bold text-muted font-middle"
                >
                  ログイン
                </p>
              </router-link>
            </li>

            <li class="nav-item d-flex align-items-center">
              <router-link :to="{ name: 'ArticleIndex' }">
                <p
                  class="m-0 font-weight-bold text-muted font-middle"
                >
                  投稿一覧
                </p>
              </router-link>
            </li>

            <li class="nav-item active">
              <router-link
                :to="{ name: 'ArticleSearch' }"
                class="pl-2 text-muted search-font-size"
              >
                <font-awesome-icon
                  :icon="['fas', 'search']"
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
        <router-link :to="{ name: 'TopPage' }">
          <span class="navbar-brand header-title">TriSto</span>
        </router-link>

        <ul class="navbar-nav d-flex align-items-center">
          <!-- AUTH USER -->
          <template v-if="authUser">
            <!-- HOME ICON -->
            <li class="nav-item active">
              <template v-if="currentPage == 'home'">
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
                  <div @click="setCurrentPage('home')">
                    <font-awesome-icon
                      :icon="['fas', 'home']"
                      class="fa-lg"
                    />
                  </div>
                </router-link>
              </template>
            </li>
            <!-- HOME ICON -->

            <!-- SEARCH ICON -->
            <template v-if="$mq == 'sm'">
              <li class="nav-item active">
                <template v-if="currentPage == 'search'">
                  <router-link
                    :to="{ name: 'ArticleSearch' }"
                    class="icon-selected"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'search']"
                      class="fa-lg"
                    />
                  </router-link>
                </template>

                <template v-else>
                  <router-link
                    :to="{ name: 'ArticleSearch' }"
                    class="icon-color"
                  >
                    <div @click="setCurrentPage('search')">
                      <font-awesome-icon
                        :icon="['fas', 'search']"
                        class="fa-lg"
                      />
                    </div>
                  </router-link>
                </template>
              </li>
            </template>
            <!-- SEARCH ICON -->

            <!-- PEN ICON -->
            <li class="nav-item active">
              <template v-if="currentPage == 'create'">
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
                  <div @click="setCurrentPage('create')">
                    <font-awesome-icon
                      :icon="['fas', 'pen']"
                      class="fa-lg"
                    />
                  </div>
                </router-link>
              </template>
            </li>
            <!-- PEN ICON -->

            <!-- USER ICON -->
            <li class="nav-item active">
              <template v-if="currentPage == 'user'">
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
                  <div @click="setCurrentPage('user')">
                    <font-awesome-icon
                      :icon="['fas', 'user']"
                      class="fa-lg"
                    />
                  </div>
                </router-link>
              </template>
            </li>
            <!-- USER ICON -->

            <!-- MENU ICON -->
            <li class="nav-item active menu-bar">
              <DropdownMenu
                v-model="show"
                :right="right"
                :hover="hover"
                :interactive="interactive"
              >
                <template v-if="currentPage == 'menu'">
                  <div class="icon-selected">
                    <font-awesome-icon
                      :icon="['fas', 'bars']"
                      class="fa-lg"
                    />
                  </div>
                </template>
                <template v-else>
                  <div class="icon-color">
                    <font-awesome-icon
                      :icon="['fas', 'bars']"
                      class="fa-lg"
                    />
                  </div>
                </template>
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
            <!-- MENU ICON -->
          </template>
          <!-- AUTH USER -->

          <!-- NON AUTH USER -->
          <template v-else>
            <li class="nav-item d-flex align-items-center">
              <router-link :to="{ name: 'Register' }">
                <p
                  id="register-button"
                  class="m-0 font-weight-bold text-muted"
                >
                  ユーザー登録
                </p>
              </router-link>
            </li>

            <li class="nav-item d-flex align-items-center">
              <router-link :to="{ name: 'Login' }">
                <p
                  id="login-button"
                  class="m-0 font-weight-bold text-muted"
                >
                  ログイン
                </p>
              </router-link>
            </li>

            <li class="nav-item d-flex align-items-center">
              <router-link :to="{ name: 'ArticleIndex' }">
                <p
                  class="m-0 font-weight-bold text-muted"
                >
                  投稿一覧
                </p>
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
import { mapGetters, mapActions } from 'vuex'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'TheHeader',
  data() {
    return {
      show: false,
      right: true,
      hover: false,
      interactive: true,
      isMobile: isMobile
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    ...mapGetters('pages', ['currentPage'])
  },
  methods: {
    ...mapActions('users', ['logoutUser']),
    logout() {
      try {
        this.logoutUser()
        this.$store.commit('pages/setCurrentPage', 'home')
        this.$store.commit('articles/articleJapanTrue')
        this.show = false
        this.$router.push({ name: 'Login' })
      } catch (error) {
        console.log(error)
      }
    },
    accouSettings() {
      this.$store.commit('pages/setCurrentPage', 'menu')
      this.$router.push({ name: 'AccountSettings' })
      this.show = false
    },
    setCurrentPage(page) {
      this.$store.commit('pages/setCurrentPage', page)
    },
    toRegister() {
      if (this.$route.path != '/register') {
        this.$router.push({ name: 'Register' })
      }
    },
    toLogin() {
      if (this.$route.path != '/login') {
        this.$router.push({ name: 'Login' })
      }
    },
    toTermOfUse() {
      this.$store.commit('pages/setCurrentPage', 'menu')
      this.$router.push({ name: 'TermOfUse' })
      this.show = false
    },
    toPrivacyPolicy() {
      this.$store.commit('pages/setCurrentPage', 'menu')
      this.$router.push({ name: 'PrivacyPolicy' })
      this.show = false
    }
  },
}
</script>

<style scoped>
.navbar {
  height: 40px;
  border-bottom: solid 1px #CBCBCB;
}

.header-title {
  color: #FF58F2;
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
  color: #343a40;
  font-size: 19px;
}

.register-button {
  background-color: #1D51FF;
  width: 120px;
  height: 25px;
  border-radius: 4px;
  cursor: pointer;
}

.login-button {
  background-color: #00D320;
  width: 120px;
  height: 25px;
  border-radius: 4px;
  cursor: pointer;
}

.register-button:hover {
  background-color: #173BB2;
  width: 120px;
  height: 25px;
  border-radius: 4px;
  cursor: pointer;
}

.login-button:hover {
  background-color: #008B15;
  width: 120px;
  height: 25px;
  border-radius: 4px;
  cursor: pointer;
}

.register-button-mobile {
  background-color: #1D51FF;
  width: 120px;
  height: 25px;
  border-radius: 4px;
  cursor: pointer;
}

.login-button-mobile {
  background-color: #00D320;
  width: 120px;
  height: 25px;
  border-radius: 4px;
  cursor: pointer;
}

.menu-bar {
  cursor: pointer;
}

.font-middle {
  font-size: 13px;
}

.search-font-size {
  font-size: 16px;
}
</style>
