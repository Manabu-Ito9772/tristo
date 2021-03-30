<template>
  <div v-if="isVisibleBlockList">
    <div
      v-for="day in days"
      :key="day.id"
    >
      <div
        v-if="dayNumber == day.number"
        class="mb-3"
      >
        <template v-if="$mq == 'xs'">
          <div v-if="day.ordered_blocks.length">
            <div
              v-for="block in day.ordered_blocks"
              :key="block.id"
            >
              <template v-if="block.id == blockId">
                <BlockEditForm
                  :block="block"
                  :currency="currency"
                  @updateBlock="updateBlock"
                />
              </template>
              <template v-else>
                <BlockItem
                  :block="block"
                  :currency="currency"
                  class="m-0 info-block"
                />
                <div class="mb-2 d-flex justify-content-end">
                  <div
                    class="pt-1 pb-0 pl-0 pr-1 btn icon-color-xs"
                    @click="showBlockEditForm(block.id)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'edit']"
                      class="fa-lg"
                    />
                  </div>
                  <div
                    class="pt-1 pb-0 pl-0 pr-2 btn icon-color-xs"
                    @click="deleteBlock(block.id)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'trash-alt']"
                      class="fa-lg"
                    />
                  </div>
                </div>
                <Transportation
                  :block="block"
                  :currency="currency"
                />
              </template>
            </div>
          </div>
          <div v-else>
            <div class="d-flex align-items-center justify-content-center">
              <h3 class="mt-3 mb-5 font-weight-bold text-secondary">
                ブロックを追加してください
              </h3>
            </div>
          </div>
        </template>

        <template v-else>
          <div v-if="day.ordered_blocks.length">
            <div
              v-for="block in day.ordered_blocks"
              :key="block.id"
            >
              <template v-if="block.id == blockId">
                <BlockEditForm
                  :block="block"
                  :currency="currency"
                  @updateBlock="updateBlock"
                />
              </template>
              <template v-else>
                <BlockItem
                  :block="block"
                  :currency="currency"
                  class="ml-0 mr-0 info-block"
                />
                <div class="d-flex justify-content-end">
                  <div
                    class="pt-1 pb-0 pl-0 pr-1 btn icon-color"
                    @click="showBlockEditForm(block.id)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'edit']"
                      class="fa-lg"
                    />
                  </div>
                  <div
                    class="pt-1 pb-0 pl-0 pr-2 btn icon-color"
                    @click="deleteBlock(block.id)"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'trash-alt']"
                      class="fa-lg"
                    />
                  </div>
                </div>
                <div class="mb-4">
                  <Transportation
                    :block="block"
                    :currency="currency"
                  />
                </div>
              </template>
            </div>
          </div>

          <div v-else>
            <div class="d-flex align-items-center justify-content-center">
              <h3 class="mb-0 font-weight-bold text-secondary">
                ブロックを追加してください
              </h3>
            </div>
          </div>
        </template>
      </div>
    </div>
  </div>
</template>

<script>
import BlockItem from './blocklist/BlockItem'
import BlockEditForm from './blocklist/BlockEditForm'
import Transportation from './blocklist/Transportation'

export default {
  name: 'BlockList',
  components: {
    BlockItem,
    BlockEditForm,
    Transportation
  },
  props: {
    days: {
      type: Array,
      required: true
    },
    currency: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      isVisibleBlockList: true,
      dayNumber: 1,
      blocks: [],
      blockId: null,
      urgeMessage: false,
      blocksForCheck: []
    }
  },
  methods :{
    async deleteBlock(block_id) {
      if (confirm(`ブロックを削除しますか？`)) {
        await this.$axios.delete(`blocks/${block_id}`)
          .catch(err => console.log(err.response))
      }
      this.$emit('getArticle')
    },
    async updateBlock(block) {
      await this.$axios.patch(`blocks/${block.id}`, block)
        .catch(err => console.log(err.response))
      for (let spending of block.spendings) {
        if (spending.id) {
          await this.$axios.patch(`spendings/${spending.id}`, spending)
            .catch(err => console.log(err.response))
        } else {
          await this.$axios.post('spendings', spending)
            .catch(err => console.log(err.response))
        }
      }
      for (let transportation of block.transportations) {
        if (transportation.id) {
          await this.$axios.patch(`transportations/${transportation.id}`, transportation)
            .catch(err => console.log(err.response))
        } else {
          await this.$axios.post('transportations', transportation)
            .catch(err => console.log(err.response))
        }
      }
      this.$emit('getArticle')
      this.blockId = null
    },
    showBlockEditForm(block_id) {
      this.blockId = block_id
    },
    changeNumber(num) {
      this.dayNumber = num
      this.isVisibleBlockList = true
    },
    closeBlockList() {
      this.isVisibleBlockList = false
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

.info-block-form {
  border: solid #FF990D;
  border-radius: 6px;
}

.info-block {
  border: solid #FF00EB;
  border-radius: 6px;
}

.icon-color {
  color: gray;
}

.icon-color-xs {
  color: gray;
  font-size: 20px;
}
</style>
