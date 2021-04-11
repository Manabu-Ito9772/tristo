<template>
  <div>
    <div class="mt-4 pl-3 pr-3">
      <div class="row">
        <template v-if="articleJapan">
          <div class="col-6 pr-1 p-0">
            <h5 class="p-1 text-white text-center font-weight-bold area-changer">
              国内
            </h5>
          </div>
          <div class="col-6 pl-1 p-0">
            <template v-if="article || !loading">
              <h5
                class="p-1 bg-white text-muted text-center font-weight-bold area-changer-unseleted"
                @click="selectWorld"
              >
                海外
              </h5>
            </template>
            <template v-else>
              <h5
                class="p-1 bg-white text-muted text-center font-weight-bold area-changer-unseleted"
              >
                海外
              </h5>
            </template>
          </div>
        </template>

        <template v-if="articleJapan == false">
          <div class="col-6 pr-1 p-0">
            <template v-if="article || !loading">
              <h5
                class="p-1 bg-white text-muted text-center font-weight-bold area-changer-unseleted"
                @click="selectJapan"
              >
                国内
              </h5>
            </template>
            <template v-else>
              <h5
                class="p-1 bg-white text-muted text-center font-weight-bold area-changer-unseleted"
              >
                国内
              </h5>
            </template>
          </div>
          <div class="col-6 pl-1 p-0">
            <h5 class="p-1 text-white text-center font-weight-bold area-changer">
              海外
            </h5>
          </div>
        </template>

        <div class="col-12 mt-2 p-0">
          <div class="p-2 d-flex align-items-center bg-white checkbox">
            <template v-if="article || !loading">
              <input
                v-model="following"
                type="checkbox"
                @change="followingArticles"
              >
            </template>
            <template v-else>
              <input
                type="checkbox"
                disabled
              >
            </template>
            <p class="pl-2 m-0 text-dark">
              フォローしているユーザーの投稿のみ表示
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'SearchForm',
  props: {
    article: {
      type: Boolean,
      required: true
    },
    loading: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      search: {
        q: {
          japan: null,
          user_id: null,
          sort: 0
        }
      },
      following: null,
    }
  },
  computed: {
    ...mapGetters('articles', ['articleJapan']),
    ...mapGetters('users', ['authUser']),
  },
  watch: {
    articleJapan() {
      this.search.q.japan = this.articleJapan
    },
    following() {
      if (this.following) {
        this.search.q.user_id = this.authUser.id
      } else {
        this.search.q.user_id = null
      }
    },
  },
  created() {
    this.search.q.japan = this.articleJapan
  },
  methods: {
    async followingArticles() {
      if (this.following) {
        this.search.q.user_id = this.authUser.id
        this.$emit('setSearch', this.search)
      } else {
        if (this.articleJapan) {
          this.$emit('resetPageJapan')
        } else {
          this.$emit('resetPageWorld')
        }
      }
    },
    async selectJapan() {
      if (this.following) {
        await this.$store.commit('articles/articleJapanTrue')
        await this.$emit('setSearch', this.search)
      } else {
        this.$emit('resetPageJapan')
      }
    },
    async selectWorld() {
      if (this.following) {
        await this.$store.commit('articles/articleJapanFalse')
        await this.$emit('setSearch', this.search)
      } else {
        this.$emit('resetPageWorld')
      }
    }
  }
}
</script>

<style scoped>
.area-changer {
  background-color: #6A6A6A;
  border: solid #6A6A6A;
  border-radius: 6px;
  cursor: pointer;
}

.area-changer-unseleted {
  border: solid #CBCBCB;
  border-radius: 6px;
  cursor: pointer;
}

.checkbox {
  border: solid #CBCBCB;
  border-radius: 6px;
}
</style>
