<template>
  <footer>
    <template v-if="authUser">
      <nav class="navbar navbar-expand pl-5 pr-5 justify-content-between fixed-bottom">
        <!-- HOME ICON -->
        <ul class="navbar-nav pl-5">
          <li class="nav-item active">
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
        </ul>
        <!-- HOME ICON -->

        <!-- PEN ICON -->
        <ul class="navbar-nav">
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
        </ul>
        <!-- PEN ICON -->

        <!-- USER ICON -->
        <ul class="navbar-nav pr-5">
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
        </ul>
      <!-- USER ICON -->
      </nav>
    </template>
  </footer>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: 'TheHeader',
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters('router', [
      'prevRoute',
      'prePrevRoute',
      'prePrePrevRoute'
    ])
  },
}
</script>

<style scoped>
.navbar {
  height: 60px;
  border-top: solid 1px #CBCBCB;
  background-color: white;
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
</style>
