<template>
  <div
    id="app"
    class="min-vh-100 background"
  >
    <TheHeader />

    <div
      :class="{ adjust: $route.path != '/' }"
      ontouchstart=""
    >
      <router-view />
    </div>

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
  },
}
</script>

<style scoped>
.background {
  background-color: #F8F8F8;
}

.adjust {
  padding-top: 30px;
}
</style>
