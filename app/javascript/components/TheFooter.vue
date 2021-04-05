<template>
  <footer>
    <template v-if="authUser">
      <nav class="navbar navbar-expand pl-5 pr-5 justify-content-between fixed-bottom">
        <!-- HOME ICON -->
        <ul class="navbar-nav pl-4">
          <li class="nav-item active m-0">
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
        </ul>
        <!-- HOME ICON -->

        <!-- PEN ICON -->
        <ul class="navbar-nav">
          <li class="nav-item active m-0">
            <template v-if="currentPage == 'pen'">
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
                <div @click="setCurrentPage('pen')">
                  <font-awesome-icon
                    :icon="['fas', 'pen']"
                    class="fa-lg"
                  />
                </div>
              </router-link>
            </template>
          </li>
        </ul>
        <!-- PEN ICON -->

        <!-- USER ICON -->
        <ul class="navbar-nav pr-4">
          <li class="nav-item active m-0">
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
        </ul>
      <!-- USER ICON -->
      </nav>
    </template>
  </footer>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'TheHeader',
  computed: {
    ...mapGetters('users', ['authUser']),
    ...mapGetters('pages', ['currentPage'])
  },
  methods: {
    setCurrentPage(page) {
      this.$store.commit('pages/setCurrentPage', page)
    }
  }
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
  color: #343a40;
  font-size: 19px;
}
</style>
