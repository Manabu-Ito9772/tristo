<template>
  <div class="mb-4">
    <template v-if="$mq == 'xs'">
      <template v-if="blocks.length">
        <div
          v-for="block in blocks"
          :key="block.id"
        >
          <InfoBlockSmall
            :block="block"
            :currency="currency"
          />
          <Transportation
            :block="block"
            :currency="currency"
            class="mt-5 mb-5"
          />
        </div>
      </template>

      <template v-else>
        <div class="d-flex align-items-center justify-content-center">
          <h3 class="m-2 font-weight-bold text-secondary">
            ブロックがありません
          </h3>
        </div>
      </template>
    </template>

    <template v-else-if="$mq == 'sm'">
      <div class="pl-4 pr-4 main-column">
        <template v-if="blocks.length">
          <div
            v-for="block in blocks"
            :key="block.id"
          >
            <InfoBlockMiddle
              :block="block"
              :currency="currency"
            />
            <Transportation
              :block="block"
              :currency="currency"
            />
          </div>
        </template>

        <template v-else>
          <div class="d-flex align-items-center justify-content-center">
            <h3 class="m-4 font-weight-bold text-secondary">
              ブロックがありません
            </h3>
          </div>
        </template>
      </div>
    </template>

    <template v-else>
      <div class="pl-4 pr-4 main-column">
        <template v-if="blocks.length">
          <div
            v-for="block in blocks"
            :key="block.id"
          >
            <InfoBlock
              :block="block"
              :currency="currency"
            />
            <Transportation
              :block="block"
              :currency="currency"
            />
          </div>
        </template>

        <template v-else>
          <div class="d-flex align-items-center justify-content-center">
            <h3 class="m-4 font-weight-bold text-secondary">
              ブロックがありません
            </h3>
          </div>
        </template>
      </div>
    </template>
  </div>
</template>

<script>
import InfoBlock from './maincolumn/InfoBlock'
import InfoBlockMiddle from './maincolumn/InfoBlockMiddle'
import InfoBlockSmall from './maincolumn/InfoBlockSmall'
import Transportation from './maincolumn/Transportation'

export default {
  name: 'MainColumn',
  components: {
    InfoBlock,
    InfoBlockMiddle,
    InfoBlockSmall,
    Transportation
  },
  props: {
    blocks: {
      type: Array,
      required: true
    },
    currency: {
      type: String,
      required: true
    },
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
