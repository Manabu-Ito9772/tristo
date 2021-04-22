<template>
  <div
    id="app"
    class="min-vh-100 background"
  >
    <TheHeader />

    <template v-if="this.$route.path == '/'">
      <div ontouchstart="">
        <router-view />
      </div>
    </template>
    <template v-else>
      <div
        class="header-adjust"
        ontouchstart=""
      >
        <router-view />
      </div>
    </template>

    <template v-if="$mq == 'xs'">
      <TheFooter />
    </template>
  </div>
</template>

<script>
import TheHeader from './components/TheHeader'
import TheFooter from './components/TheFooter'

export default {
  components: {
    TheHeader,
    TheFooter
  }
}
</script>

<style scoped>
.background {
  background-color: #F8F8F8;
}

.header-adjust {
  padding-top: 30px;
}
</style>
