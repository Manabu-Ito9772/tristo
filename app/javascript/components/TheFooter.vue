<template>
  <footer>
    <nav class="navbar navbar-expand pl-5 pr-5 justify-content-between fixed-bottom">
      <ul class="navbar-nav pl-5">
        <li class="nav-item active">
          <template v-if="this.$route.path == '/articles'">
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
          <template v-else-if="this.$route.path == '/article'">
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

      <ul class="navbar-nav">
        <li class="nav-item active">
          <template v-if="this.$route.path == '/article_create'">
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
          <template v-else-if="this.$route.path == '/article_create_detail'">
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

      <ul class="navbar-nav pr-5">
        <li class="nav-item active">
          <router-link
            :to="{ name: 'ArticleIndex' }"
            class="icon-color"
          >
            <font-awesome-icon
              :icon="['fas', 'user']"
              class="fa-lg"
            />
          </router-link>
        </li>
      </ul>
    </nav>
  </footer>
</template>

<script>
export default {
  name: 'TheHeader'
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
