<template>
  <div>
    <template v-if="following">
      <button
        class="btn text-white font-weight-bold unfollow-button"
        @click="unfollowUser"
      >
        フォロー中
      </button>
    </template>
    <template v-if="notFollowing">
      <button
        class="btn bg-white font-weight-bold follow-button"
        @click="followUser"
      >
        フォロー
      </button>
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'FollowButton',
  props: {
    relationship: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      following: null,
      notFollowing: null,
      user: null
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  created() {
    this.checkFollowOrNot()
    this.setUser()
  },
  methods: {
    checkFollowOrNot() {
      if (this.relationship.index == 0) {
        this.following = true
        this.notFollowing = false
      } else {
        this.following = false
        this.notFollowing = true
      }
    },
    setUser() {
      if (this.$route.path == '/following') {
        this.user = this.relationship.follow
      } else {
        this.user = this.relationship.user
      }
    },
    followUser() {
      this.$axios.post(`relationships/${this.user.id}/follow`)
        .then(res => {
          this.following = true
          this.notFollowing = false
        })
        .catch(err => console.log(err.response))
    },
    unfollowUser() {
      if (confirm(`${this.user.name}さんのフォローを解除しますか？`)) {
        this.$axios.delete(`relationships/${this.user.id}`)
          .then(res => {
            this.following = false
            this.notFollowing = true
          })
          .catch(err => console.log(err.response))
      }
    },
  }
}
</script>

<style scoped>
.follow-button {
  white-space: nowrap;
  font-size: 12px;
  color: #1D51FF;
  border: solid thin #1D51FF;
  border-radius: 20px;
}

.unfollow-button {
  white-space: nowrap;
  font-size: 12px;
  border: solid thin #1D51FF;
  border-radius: 20px;
  background-color: #1D51FF;
}
</style>
