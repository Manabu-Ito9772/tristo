<template>
  <div>
    <div
      v-for="day in article.days"
      :key="day.id"
      class="d-inline-block"
    >
      <template v-if="article.days.length != 1">
        <template v-if="dayNumber == day.number">
          <div class="mb-2 ml-1 mr-1 p-1 text-white font-weight-bold day-number-selected">
            {{ day.number }}日目
          </div>
        </template>

        <template v-else>
          <div
            class="mb-2 ml-1 mr-1 p-1 bg-white text-muted font-weight-bold day-number"
            @click="showBlockList(day.number)"
          >
            {{ day.number }}日目
          </div>
        </template>
      </template>

      <template v-else>
        <template v-if="dayNumber">
          <div class="mb-2 ml-1 mr-1 p-1 text-white font-weight-bold day-number-selected">
            日帰り
          </div>
        </template>

        <template v-else>
          <div
            class="mb-2 ml-1 mr-1 p-1 bg-white text-muted font-weight-bold day-number"
            @click="showBlockList(1)"
          >
            日帰り
          </div>
        </template>
      </template>
    </div>

    <template v-if="cost">
      <template v-if="costButtonSelected">
        <div class="d-inline-block mb-2 mr-1 p-1 text-white font-weight-bold total-cost-selected">
          コスト
        </div>
      </template>

      <template v-else>
        <div
          class="d-inline-block mb-2 mr-1 p-1 bg-white text-muted font-weight-bold total-cost"
          @click="showCost"
        >
          コスト
        </div>
      </template>
    </template>

    <template v-if="article.map">
      <template v-if="mapButtonSelected">
        <div class="d-inline-block mb-2 mr-1 p-1 text-white font-weight-bold map-selected">
          マップ
        </div>
      </template>

      <template v-else>
        <div
          class="d-inline-block mb-2 mr-1 p-1 bg-white text-muted font-weight-bold map"
          @click="showGmap"
        >
          マップ
        </div>
      </template>
    </template>

    <template v-if="authUser">
      <template v-if="article.days">
        <template v-if="commentButtonSelected">
          <div class="d-inline-block mb-2 mr-1 p-1 text-white font-weight-bold comment-selected">
            コメント
          </div>
        </template>

        <template v-else>
          <div
            class="d-inline-block mb-2 mr-1 p-1 bg-white text-muted font-weight-bold comment"
            @click="showComment"
          >
            コメント
          </div>
        </template>
      </template>
    </template>

    <template v-if="!authUser && comments != 0">
      <template v-if="article.days">
        <template v-if="commentButtonSelected">
          <div class="d-inline-block mb-2 mr-1 p-1 text-white font-weight-bold comment-selected">
            コメント
          </div>
        </template>

        <template v-else>
          <div
            class="d-inline-block mb-2 mr-1 p-1 bg-white text-muted font-weight-bold comment"
            @click="showComment"
          >
            コメント
          </div>
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
    cost: {
      type: Boolean,
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
  border-radius: 4px;
  cursor: pointer;
}

.day-number-selected {
  background-color: #00D320;
  border: solid #00D320;
  border-radius: 4px;
  cursor: pointer;
}

.total-cost {
  border: solid #1D51FF;
  border-radius: 4px;
  cursor: pointer;
}

.total-cost-selected {
  background-color: #1D51FF;
  border: solid #1D51FF;
  border-radius: 4px;
  cursor: pointer;
}

.map {
  border: solid #FF990D;
  border-radius: 4px;
  cursor: pointer;
}

.map-selected {
  background-color: #FF990D;
  border: solid #FF990D;
  border-radius: 4px;
  cursor: pointer;
}

.comment {
  border: solid #6A6A6A;
  border-radius: 4px;
  cursor: pointer;
}

.comment-selected {
  background-color: #6A6A6A;
  border: solid #6A6A6A;
  border-radius: 4px;
  cursor: pointer;
}
</style>
