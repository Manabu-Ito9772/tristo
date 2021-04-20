<template>
  <div class="row">
    <template v-if="$mq == 'lg'">
      <div class="col-12 text-center text-white">
        <p class="col-12 p-0 mb-1 info-block-time font-small">
          時間
        </p>
      </div>
      <div class="col-12 text-center text-dark">
        <p class="col-12 p-0 mb-1 font-small">
          {{ block.arriving_time | moment('H:mm') }}
        </p>
      </div>
      <div class="col-12 text-center text-dark">
        <p class="col-12 p-0 mb-1 time-wave">
          〜
        </p>
      </div>
      <div class="col-12 text-center text-dark">
        <p class="col-12 p-0 mb-0 font-small">
          {{ block.leaving_time | moment('H:mm') }}
        </p>
      </div>
    </template>

    <template v-else>
      <div class="col-12 text-center text-white">
        <p class="col-12 p-0 mb-1 info-block-time">
          時間
        </p>
      </div>
      <div class="col-12 text-center text-dark">
        <p class="col-12 p-0 mb-1">
          {{ block.arriving_time | moment('H:mm') }}
        </p>
      </div>
      <div class="col-12 text-center text-dark">
        <p class="col-12 p-0 mb-1 time-wave">
          〜
        </p>
      </div>
      <div class="col-12 text-center text-dark">
        <p class="col-12 p-0 mb-0">
          {{ block.leaving_time | moment('H:mm') }}
        </p>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  name: 'TimeInfo',
  props: {
    block: {
      type: Object,
      required: true
    }
  },
}
</script>

<style scoped>
.info-block-time {
  white-space: nowrap;
  background-color: #00D320;
  border-radius: 8px;
}

.font-small {
  font-size: 14px;
}

.time-wave {
  transform: rotate(90deg);
}
</style>
