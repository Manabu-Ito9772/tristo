<template>
  <div class="container-fluid mt-4">
    <div class="row">
      <div class="col-6 pr-0">
        <h5
          class="font-weight-bold text-center text-muted follow-unselected"
          @click="toFollowing"
        >
          フォロー
        </h5>
      </div>
      <div class="col-6 pl-0">
        <h5 class="font-weight-bold text-center text-white follow-selected">
          フォロワー
        </h5>
      </div>

      <div class="col-12 mt-1 mb-5 pb-5">
        <template v-if="relationships.length">
          <div class="users">
            <div
              v-for="relationship in relationships"
              :key="relationship.id"
            >
              <div class="pt-2 pb-2 pl-3 pr-3 d-flex justify-content-between align-items-center each-user">
                <div
                  id="user-info"
                  class="d-flex justify-content-center align-items-center pointer"
                  @click="toUserPage(relationship.user.id)"
                >
                  <div>
                    <template v-if="relationship.user.avatar_url">
                      <img
                        :src="relationship.user.avatar_url"
                        class="user-icon"
                      >
                    </template>
                    <template v-else>
                      <img
                        id="default-avatar"
                        :src="require('../../../assets/images/default.jpg')"
                        class="user-icon"
                      >
                    </template>
                  </div>
                  <h5 class="ml-3 mr-3 m-0 text-dark word-break font-weight-bold user-name">
                    {{ relationship.user.name }}
                  </h5>
                </div>
                <template v-if="followButton">
                  <FollowButton
                    :relationship="relationship"
                  />
                </template>
              </div>
            </div>
            <infinite-loading
              spinner="circles"
              @infinite="infiniteHandler"
            />
          </div>
        </template>

        <template v-else>
          <template v-if="loading">
            <div class="col-12 mt-5 mb-5">
              <vue-loading
                type="spiningDubbles"
                color="darkgray"
                :size="{ width: '80px' }"
              />
            </div>
          </template>
        </template>
      </div>
    </div>
  </div>
</template>

<script>
import FollowButton from './components/following/FollowButton'
import { mapGetters } from 'vuex'

export default {
  name: 'Followers',
  components: {
    FollowButton
  },
  data() {
    return {
      followButton: false,
      relationships: [],
      followingIDs: [],
      page: 1,
      url: null,
      loading: true,
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  created() {
    this.setInfiniteHandler()
  },
  methods: {
    async setInfiniteHandler() {
      if (!this.$route.query.user_id) {
        this.followButton = true
        this.url = `relationships/${this.authUser.id}/followers`
        await this.$axios.get('relationships/get_following_ids')
          .then(res => {
            this.followingIDs = res.data
          })
          .catch(err => console.log(err.response))
        await this.infiniteHandler()
      } else {
        this.url = `relationships/${this.$route.query.user_id}/followers`
        await this.infiniteHandler()
      }
    },
    infiniteHandler($state) {
      this.$axios.get(`${this.url}`, { params: { page: this.page }})
        .then(res => {
          if (res.data.relationships.length) {
            setTimeout(() => {
              if (this.page <= res.data.kaminari.pagenation.pages) {
                this.page += 1
                this.relationships.push(...res.data.relationships)
                if (!this.$route.query.user_id) {
                  for (let passive_relation of this.relationships) {
                    let result = this.followingIDs.some(following => {
                      return following.id == passive_relation.user.id
                    })
                    if (result == true) {
                      passive_relation.index = 0
                    } else {
                      passive_relation.index = 1
                    }
                  }
                }
                if (this.page != 2) {
                  $state.loaded()
                }
              } else {
                $state.complete()
              }
            }, 800)
          } else {
            setTimeout(() => {
              this.loading = false
            }, 800)
            $state.complete()
          }
        })
        .catch(err => console.log(err.response))
    },
    toUserPage(user_id) {
      if (this.authUser && this.authUser.id == user_id) {
        this.$store.commit('pages/setCurrentPage', 'user')
        this.$router.push({ name: 'MyPage' })
      } else {
        this.$router.push({ name: 'UserShow', query: { id: user_id } })
      }
    },
    toFollowing() {
      this.relationships = []
      this.page = 1
      if (this.$route.query.user_id) {
        this.$router.push({
          name: 'Following',
          query: { user_id: this.$route.query.user_id }
        })
      } else {
        this.$router.push({ name: 'Following' })
      }
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
  background-color: #DF81A2;
  border: solid #DF81A2;
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
</style>
