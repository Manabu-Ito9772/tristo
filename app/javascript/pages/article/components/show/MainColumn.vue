<template>
  <div class="mb-4">
    <template v-if="$mq == 'xs'">
      <div
        v-for="block in blocks"
        :key="block.id"
      >
        <InfoBlockSmall
          :block="block"
        />
        <Transportation
          :block="block"
        />
      </div>
    </template>
    <template v-else>
      <div class="pl-3 pr-3 main-column">
        <div
          v-for="block in blocks"
          :key="block.id"
        >
          <InfoBlock
            :block="block"
          />
          <Transportation
            :block="block"
          />
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import InfoBlock from './maincolumn/InfoBlock'
import InfoBlockSmall from './maincolumn/InfoBlockSmall'
import Transportation from './maincolumn/Transportation'

export default {
  name: 'MainColumn',
  components: {
    InfoBlock,
    InfoBlockSmall,
    Transportation
  },
  props: {
    blocks: {
      type: Array,
      required: true
    }
  }
}
</script>

<style scoped>
.main-column {
  background-color: white;
  border: solid #00D320;
  border-radius: 6px;
}
</style>
