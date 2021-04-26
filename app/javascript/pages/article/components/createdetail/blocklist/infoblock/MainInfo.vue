<template>
  <div>
    <div
      v-if="block.title"
      class="row mb-3"
    >
      <div class="col-12 text-white">
        <p class="pl-3 content-lavel m-0">
          イベント
        </p>
      </div>
      <p class="col-12 pl-4 pt-1 m-0 text-dark word-break">
        {{ block.title }}
      </p>
    </div>

    <div class="row">
      <div class="col-12 text-white">
        <p class="pl-3 content-lavel m-0">
          スポット
        </p>
      </div>
      <p
        id="place"
        class="col-12 pl-4 pt-1 m-0 text-dark word-break"
      >
        {{ block.place }}
      </p>
      <div
        v-if="block.place_info"
        class="col-12 pl-4 pt-1 m-0 text-dark"
      >
        <a
          :href="block.place_info"
          target="_blank"
          class="word-break"
        >
          {{ block.place_info }}
        </a>
      </div>
    </div>

    <div
      v-if="block.spendings.length"
      class="row mt-3"
    >
      <div class="col-12 text-white">
        <p class="pl-3 content-lavel m-0">
          コスト
        </p>
      </div>
      <div
        v-for="spending in block.spendings"
        :key="spending.id"
        class="col-12 pt-1 m-0 text-dark"
      >
        <div class="row ml-2 mr-2 cost-border">
          <div class="col-8 p-0">
            <p class="m-0 word-break">
              {{ spending.description }}
            </p>
          </div>
          <div class="col-4 p-0 text-right">
            <p class="m-0 word-break">
              {{ separateWithComma(spending.cost) }}{{ currency }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <div
      v-if="block.comment"
      class="row mt-3"
    >
      <div class="col-12 text-white">
        <p class="pl-3 content-lavel m-0">
          メモ
        </p>
      </div>
      <p class="col-12 pl-4 pt-1 m-0 text-dark word-break break-line remove-first-line">
        {{ block.comment }}
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MainInfo',
  props: {
    block: {
      type: Object,
      required: true
    },
    currency: {
      type: String,
      required: true
    }
  },
  methods: {
    separateWithComma(num) {
      let cost = Number(num)
      return cost.toLocaleString()
    },
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.content-lavel {
  background-color: #FF58F2;
  border-radius: 8px;
}

.cost-border {
  border-bottom: solid thin #CBCBCB;
}

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}
</style>
