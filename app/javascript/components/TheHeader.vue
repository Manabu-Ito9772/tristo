<template>
  <header>
    <template v-if="$mq == 'xs'">
      <nav class="navbar navbar-expand bg-white justify-content-between fixed-top">
        <router-link :to="{ name: 'ArticleIndex' }">
          <span class="navbar-brand header-title">TriSto</span>
        </router-link>
        <ul class="navbar-nav">
          <li class="nav-item active">
            <font-awesome-icon
              :icon="['fas', 'bars']"
              class="fa-lg"
            />
          </li>
        </ul>
      </nav>
    </template>
    <template v-else>
      <nav class="navbar navbar-expand bg-white justify-content-between fixed-top">
        <router-link :to="{ name: 'ArticleIndex' }">
          <span class="navbar-brand header-title">TriSto</span>
        </router-link>
        <ul class="navbar-nav">
          <li class="nav-item active">
            <router-link
              :to="{ name: 'ArticleIndex' }"
              class="icon-color"
            >
              <font-awesome-icon
                :icon="['fas', 'home']"
                class="fa-lg"
              />
            </router-link>
          </li>
          <li class="nav-item active">
            <router-link
              :to="{ name: 'ArticleCreateOverview' }"
              class="icon-color"
            >
              <font-awesome-icon
                :icon="['fas', 'pen']"
                class="fa-lg"
              />
            </router-link>
          </li>
          <li class="nav-item active">
            <font-awesome-icon
              :icon="['fas', 'user']"
              class="fa-lg"
            />
          </li>
          <li class="nav-item active">
            <font-awesome-icon
              :icon="['fas', 'bars']"
              class="fa-lg"
            />
          </li>
        </ul>
      </nav>
    </template>
  </header>
</template>

<script>
export default {
  name: 'TheHeader'
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
  color: black;
}
</style>
