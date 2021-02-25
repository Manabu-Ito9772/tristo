<template>
  <div
    id="app"
    class="min-vh-100 background"
  >
    <TheHeader />
    <div class="header-adjust">
      <router-view />
    </div>
  </div>
</template>

<script>
import TheHeader from './components/TheHeader'

export default {
  components: {
    TheHeader
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
