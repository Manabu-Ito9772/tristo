<template>
  <div>
    <div
      v-for="day in article.days"
      :key="day.id"
      class="d-inline-block"
    >
      <template v-if="article.days.length != 1">
        <template v-if="dayNumber == day.number">
          <button class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold day-number-selected">
            {{ day.number }}日目
          </button>
        </template>

        <template v-else>
          <button
            class="btn mb-2 ml-1 mr-1 p-1 bg-white text-muted font-weight-bold day-number"
            @click="showBlockList(day.number)"
          >
            {{ day.number }}日目
          </button>
        </template>
      </template>

      <template v-else>
        <template v-if="dayNumber">
          <button class="btn mb-2 ml-1 mr-1 p-1 text-white font-weight-bold day-number-selected">
            日帰り
          </button>
        </template>

        <template v-else>
          <button
            class="btn mb-2 ml-1 mr-1 p-1 bg-white text-muted font-weight-bold day-number"
            @click="showBlockList(1)"
          >
            日帰り
          </button>
        </template>
      </template>
    </div>

    <template v-if="costs.length">
      <template v-if="costButtonSelected">
        <button class="btn mb-2 mr-1 p-1 text-white font-weight-bold total-cost-selected">
          コスト
        </button>
      </template>

      <template v-else>
        <button
          class="btn mb-2 mr-1 p-1 bg-white text-muted font-weight-bold total-cost"
          @click="showCost"
        >
          コスト
        </button>
      </template>
    </template>

    <template v-if="article.map">
      <template v-if="mapButtonSelected">
        <button class="btn mb-2 mr-1 p-1 text-white font-weight-bold map-selected">
          マップ
        </button>
      </template>

      <template v-else>
        <button
          class="btn mb-2 mr-1 p-1 bg-white text-muted font-weight-bold map"
          @click="showGmap"
        >
          マップ
        </button>
      </template>
    </template>

    <template v-if="authUser">
      <template v-if="article.days">
        <template v-if="commentButtonSelected">
          <button class="btn mb-2 mr-1 p-1 text-white font-weight-bold comment-selected">
            コメント
          </button>
        </template>

        <template v-else>
          <button
            class="btn mb-2 mr-1 p-1 bg-white text-muted font-weight-bold comment"
            @click="showComment"
          >
            コメント
          </button>
        </template>
      </template>
    </template>

    <template v-if="!authUser && comments != 0">
      <template v-if="article.days">
        <template v-if="commentButtonSelected">
          <button class="btn mb-2 mr-1 p-1 text-white font-weight-bold comment-selected">
            コメント
          </button>
        </template>

        <template v-else>
          <button
            class="btn mb-2 mr-1 p-1 bg-white text-muted font-weight-bold comment"
            @click="showComment"
          >
            コメント
          </button>
        </template>
      </template>
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'SwitchButton',
  props: {
    article: {
      type: Object,
      required: true
    },
  },
  data() {
    return {
      costs: [],
      comments: 0,
      dayNumber: 1,
      costButtonSelected: false,
      mapButtonSelected: false,
      commentButtonSelected: false
    }
  },
  computed: {
    ...mapGetters('users', ['authUser'])
  },
  watch: {
    article: {
      handler() {
        for (let day of this.article.days) {
          for (let block of day.ordered_blocks) {
            for (let spending of block.spendings) {
              this.costs.push(spending)
            }
            for (let transportation of block.transportations) {
              this.costs.push(transportation)
            }
          }
        }
      },
    }
  },
  created() {
    this.getComments()
  },
  methods :{
    showBlockList(dayNumber) {
      this.$emit('showBlockList', dayNumber)
      this.dayNumber = dayNumber
      this.costButtonSelected = false
      this.mapButtonSelected = false
      this.commentButtonSelected = false
    },
    showCost() {
      this.$emit('showCost')
      this.dayNumber = null
      this.mapButtonSelected = false
      this.commentButtonSelected = false
      this.costButtonSelected = true
    },
    showGmap() {
      this.$emit('showGmap')
      this.dayNumber = null
      this.costButtonSelected = false
      this.commentButtonSelected = false
      this.mapButtonSelected = true
    },
    showComment() {
      this.$emit('showComment')
      this.dayNumber = null
      this.costButtonSelected = false
      this.mapButtonSelected = false
      this.commentButtonSelected = true
    },
    getComments() {
      if (!this.authUser) {
        this.$axios.get(`comments/${this.$route.query.id}`)
          .then(res => {
            this.comments = res.data.length
          })
          .catch(err => console.log(err.response))
      }
    },
  }
}
</script>

<style scoped>
.day-number {
  border: solid #00D320;
}

.day-number-selected {
  background-color: #00D320;
  border: solid #00D320;
}

.total-cost {
  border: solid #1D51FF;
}

.total-cost-selected {
  background-color: #1D51FF;
  border: solid #1D51FF;
}

.map {
  border: solid #FF990D;
}

.map-selected {
  background-color: #FF990D;
  border: solid #FF990D;
}

.comment {
  border: solid #6A6A6A;
}

.comment-selected {
  background-color: #6A6A6A;
  border: solid #6A6A6A;
}
</style>
