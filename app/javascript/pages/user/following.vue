<template>
  <div class="container-fluid mt-4">
    <div class="row">
      <template v-if="following">
        <div class="col-6 pr-0">
          <h5 class="font-weight-bold text-center text-white follow-selected">
            フォロー
          </h5>
        </div>
        <div class="col-6 pl-0">
          <h5
            class="font-weight-bold text-center text-muted follow-unselected"
            @click="showFollowers"
          >
            フォロワー
          </h5>
        </div>
      </template>

      <template v-else>
        <div class="col-6 pr-0">
          <h5
            class="font-weight-bold text-center text-muted follow-unselected"
            @click="showFollowings"
          >
            フォロー
          </h5>
        </div>
        <div class="col-6 pl-0">
          <h5 class="font-weight-bold text-center text-white follow-selected">
            フォロワー
          </h5>
        </div>
      </template>

      <template v-if="following">
        <div class="col-12 mt-1">
          <template v-if="followings != 0">
            <div class="users">
              <div
                v-for="relationship in followings"
                :key="relationship.id"
              >
                <div class="pt-2 pb-2 pl-3 pr-3 d-flex justify-content-between align-items-center each-user">
                  <div
                    id="user-info"
                    class="d-flex justify-content-center align-items-center pointer"
                    @click="toUserPage(relationship.follow.id)"
                  >
                    <img
                      src="../../images/sample.png"
                      class="user-icon"
                    >
                    <h5 class="ml-3 mr-3 m-0 text-dark word-break">
                      {{ relationship.follow.name }}
                    </h5>
                  </div>
                  <template v-if="followButton">
                    <template v-if="relationship.index == 0">
                      <button
                        class="btn text-white font-weight-bold unfollow-button"
                        @click="unfollowUserFromFollowing(relationship.follow)"
                      >
                        フォロー中
                      </button>
                    </template>
                    <template v-else>
                      <button
                        class="btn bg-white font-weight-bold follow-button"
                        @click="followUserFromFollowing(relationship.follow.id)"
                      >
                        フォロー
                      </button>
                    </template>
                  </template>
                </div>
              </div>
            </div>
          </template>
        </div>
      </template>

      <template v-else>
        <div class="col-12 mt-1">
          <template v-if="followers != 0">
            <div class="users">
              <div
                v-for="relationship in followers"
                :key="relationship.id"
              >
                <div class="pt-2 pb-2 pl-3 pr-3 d-flex justify-content-between align-items-center each-user">
                  <div
                    id="user-info"
                    class="d-flex justify-content-center align-items-center pointer"
                    @click="toUserPage(relationship.user.id)"
                  >
                    <img
                      src="../../images/sample.png"
                      class="user-icon"
                    >
                    <h5 class="ml-3 mr-3 m-0 text-dark word-break">
                      {{ relationship.user.name }}
                    </h5>
                  </div>
                  <template v-if="followButton">
                    <template v-if="relationship.index == 0">
                      <button
                        class="btn text-white font-weight-bold unfollow-button"
                        @click="unfollowUserFromFollowers(relationship.user)"
                      >
                        フォロー中
                      </button>
                    </template>
                    <template v-else>
                      <button
                        class="btn bg-white font-weight-bold follow-button"
                        @click="followUserFromFollowers(relationship.user.id)"
                      >
                        フォロー
                      </button>
                    </template>
                  </template>
                </div>
              </div>
            </div>
          </template>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Following',
  data() {
    return {
      following: true,
      followings: [],
      followers: [],
      followButton: false,
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  created() {
    this.getFollowingsAndFollowers()
    if (this.$route.path == '/followers') {
      this.following = false
    }
  },
  methods: {
    async getFollowingsAndFollowers() {
      if (this.$route.query.user_id) {
        await this.$axios.get(`relationships/${this.$route.query.user_id}/following`)
          .then(res => {
            this.followings = res.data
          })
          .catch(err => console.log(err.response))
        this.$axios.get(`relationships/${this.$route.query.user_id}/followers`)
          .then(res => {
            this.followers = res.data
          })
          .catch(err => console.log(err.response))
      } else {
        this.followButton = true
        await this.$axios.get(`relationships/${this.authUser.id}/following`)
          .then(res => {
            this.followings = res.data
            for (let relationship of this.followings) {
              relationship.index = 0
            }
          })
          .catch(err => console.log(err.response))
        this.$axios.get(`relationships/${this.authUser.id}/followers`)
          .then(res => {
            this.followers = res.data
            for (let passive_relation of this.followers) {
              let result = this.followings.some(active_relation => {
                return active_relation.follow.id == passive_relation.user.id
              })
              if (result == true) {
                passive_relation.index = 0
              } else {
                passive_relation.index = 1
              }
            }
          })
          .catch(err => console.log(err.response))
      }
    },
    followUserFromFollowing(user_id) {
      this.$axios.post(`relationships/${user_id}/follow`)
        .then(res => {
          for (let relationship of this.followings) {
            if (res.data.follow.id == relationship.follow.id) {
              relationship.index = 0
            }
          }
          for (let relationship of this.followers) {
            if (res.data.follow.id == relationship.user.id) {
              relationship.index = 0
            }
          }
          this.showFollowers()
          this.showFollowings()
        })
        .catch(err => console.log(err.response))
    },
    followUserFromFollowers(user_id) {
      this.$axios.post(`relationships/${user_id}/follow`)
        .then(res => {
          for (let relationship of this.followings) {
            if (res.data.follow.id == relationship.follow.id) {
              relationship.index = 0
            }
          }
          for (let relationship of this.followers) {
            if (res.data.follow.id == relationship.user.id) {
              relationship.index = 0
            }
          }
          this.showFollowings()
          this.showFollowers()
        })
        .catch(err => console.log(err.response))
    },
    unfollowUserFromFollowing(user) {
      if (confirm(`${user.name}さんのフォローを解除しますか？`)) {
        this.$axios.delete(`relationships/${user.id}`)
          .then(res => {
            for (let relationship of this.followings) {
              if (res.data.follow.id == relationship.follow.id) {
                relationship.index = 1
              }
            }
            for (let relationship of this.followers) {
              if (res.data.follow.id == relationship.user.id) {
                relationship.index = 1
              }
            }
            this.showFollowers()
            this.showFollowings()
          })
          .catch(err => console.log(err.response))
      }
    },
    unfollowUserFromFollowers(user) {
      if (confirm(`${user.name}さんのフォローを解除しますか？`)) {
        this.$axios.delete(`relationships/${user.id}`)
          .then(res => {
            for (let relationship of this.followings) {
              if (res.data.follow.id == relationship.follow.id) {
                relationship.index = 1
              }
            }
            for (let relationship of this.followers) {
              if (res.data.follow.id == relationship.user.id) {
                relationship.index = 1
              }
            }
            this.showFollowings()
            this.showFollowers()
          })
          .catch(err => console.log(err.response))
      }
    },
    toUserPage(user_id) {
      if (this.authUser && this.authUser.id == user_id) {
        this.$store.commit('pages/setCurrentPage', 'user')
        this.$router.push({ name: 'MyPage' })
      } else {
        this.$router.push({ name: 'UserShow', query: { id: user_id } })
      }
    },
    showFollowings() {
      this.following = true
    },
    showFollowers() {
      this.following = false
    },
  }
}
</script>

<style scoped>
.container-fluid {
  max-width: 400px;
}

.word-break {
  word-break: break-word;
}

.follow-selected {
  background-color: #FF00EB;
  border: solid #FF00EB;
  border-radius: 6px;
  cursor: pointer;
}

.follow-unselected {
  border: solid rgba(0, 0, 0, 0);
  cursor: pointer;
}

.users {
  border-top: solid thin #D3D3D3;
}

.each-user {
  border-bottom: solid thin #D3D3D3;
}

.pointer {
  cursor: pointer;
}

.user-icon {
  width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 50%;
}

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
