<template>
  <div>
    <template v-if="$mq == 'lg'">
      <div class="pl-4 pr-4 main-column">
        <template v-if="blocks.length">
          <div
            v-for="block in blocks"
            :key="block.id"
          >
            <BlockItem
              :block="block"
              :currency="currency"
              class="row mt-4 mb-4 ml-0 mr-0 bg-white info-block"
              @fixPage="$listeners['fixPage']"
              @flowPage="$listeners['flowPage']"
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

    <template v-else-if="$mq == 'sm'">
      <div class="pl-4 pr-4 main-column">
        <template v-if="blocks.length">
          <div
            v-for="block in blocks"
            :key="block.id"
          >
            <BlockItem
              :block="block"
              :currency="currency"
              class="row mt-4 mb-4 ml-0 mr-0 bg-white info-block"
              @fixPage="$listeners['fixPage']"
              @flowPage="$listeners['flowPage']"
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
      <template v-if="blocks.length">
        <div
          v-for="block in blocks"
          :key="block.id"
        >
          <BlockItem
            :block="block"
            :currency="currency"
            class="row ml-0 mr-0 bg-white info-block"
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
          <h4 class="m-4 font-weight-bold text-secondary">
            ブロックがありません
          </h4>
        </div>
      </template>
    </template>
  </div>
</template>

<script>
import BlockItem from './maincolumn/BlockItem'
import Transportation from './maincolumn/Transportation'

export default {
  name: 'BlockList',
  components: {
    BlockItem,
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
  border: solid #81D674;
  border-radius: 6px;
}

.info-block {
  border: solid #DF81A2;
  border-radius: 6px;
}
</style>
