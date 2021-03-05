<template>
  <div class="mb-4 text-center">
    <template v-if="$mq == 'xs'">
      <iframe
        :src="map"
        class="map-xs"
      />
    </template>
    <template v-else>
      <iframe
        :src="map"
        class="map"
      />
    </template>
  </div>
</template>

<script>
export default {
  name: 'MapColumn',
  components: {
  },
  props: {
    map: {
      type: String,
      required: true
    }
  }
}
</script>

<style scoped>
.map {
  width: 100%;
  height: 480px;
  border: solid #FF990D;
  border-radius: 6px;
}

.map-xs {
  width: 100%;
  height: 400px;
}
</style>
