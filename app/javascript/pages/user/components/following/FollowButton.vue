<template>
  <div>
    <template v-if="following">
      <template v-if="isMobile">
        <div
          class="text-white font-weight-bold unfollow-button-mobile"
          @click="unfollowUser"
        >
          フォロー中
        </div>
      </template>
      <template v-else>
        <div
          class="text-white font-weight-bold unfollow-button"
          @click="unfollowUser"
        >
          フォロー中
        </div>
      </template>
    </template>
    <template v-if="notFollowing">
      <template v-if="isMobile">
        <div
          class="bg-white font-weight-bold follow-button-mobile"
          @click="followUser"
        >
          フォロー
        </div>
      </template>
      <template v-else>
        <div
          class="bg-white font-weight-bold follow-button"
          @click="followUser"
        >
          フォロー
        </div>
      </template>
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { isMobile } from 'mobile-device-detect'

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
      user: null,
      isMobile: isMobile
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
  font-size: 13px;
  padding: 6px 14px;
  color: #6EB7DB;
  border: solid thin #6EB7DB;
  border-radius: 20px;
  cursor: pointer;
}

.follow-button:hover {
  color: #208DC3;
  border: solid thin #208DC3;
}

.unfollow-button {
  white-space: nowrap;
  font-size: 13px;
  padding: 6px 14px;
  border: solid thin #6EB7DB;
  border-radius: 20px;
  background-color: #6EB7DB;
  cursor: pointer;
}

.unfollow-button:hover {
  border: solid thin #208DC3;
  background-color: #208DC3;
}

.follow-button-mobile {
  white-space: nowrap;
  font-size: 13px;
  padding: 6px 14px;
  color: #6EB7DB;
  border: solid thin #6EB7DB;
  border-radius: 20px;
  cursor: pointer;
}

.follow-button-mobile:active {
  color: #208DC3;
  border: solid thin #208DC3;
}

.unfollow-button-mobile {
  white-space: nowrap;
  font-size: 13px;
  padding: 6px 14px;
  border: solid thin #6EB7DB;
  border-radius: 20px;
  background-color: #6EB7DB;
  cursor: pointer;
}

.unfollow-button-mobile:active {
  border: solid thin #208DC3;
  background-color: #208DC3;
}
</style>
