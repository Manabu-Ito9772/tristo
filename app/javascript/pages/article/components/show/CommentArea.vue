<template>
  <div class="mb-4">
    <template v-if="authUser">
      <ValidationObserver v-slot="{ handleSubmit }">
        <div class="mt-3 d-flex justify-content-center align-items-top">
          <div class="form-group m-0 comment-input">
            <ValidationProvider
              rules="input|max:500"
            >
              <div>
                <textarea
                  ref="area"
                  v-model="comment.body"
                  :style="styles"
                  name="コメント"
                  rows="1"
                  class="form-control"
                />
              </div>
            </ValidationProvider>
          </div>
          <div class="ml-2">
            <template v-if="isMobile">
              <div
                class="text-white font-weight-bold button-mobile"
                @click="handleSubmit(postComment)"
              >
                投稿
              </div>
            </template>
            <template v-else>
              <div
                class="text-white font-weight-bold button"
                @click="handleSubmit(postComment)"
              >
                投稿
              </div>
            </template>
          </div>
        </div>
      </ValidationObserver>
    </template>

    <div v-show="comments.length">
      <div class="d-flex justify-content-center">
        <div class="mt-4 comment-area mx-auto">
          <div class="comment-all">
            <div
              v-for="comme in comments"
              :key="comme.id"
            >
              <EachComment
                v-if="isVisibleComment"
                :commentprop="comme"
                @deleteComment="deleteComment"
              />
            </div>
            <template v-if="infiniteLoader">
              <infinite-loading
                spinner="circles"
                @infinite="infiniteHandler"
              />
            </template>
          </div>
        </div>
      </div>
    </div>

    <template v-if="!comments.length">
      <template v-if="loading">
        <vue-loading
          type="spiningDubbles"
          color="#FF58F2"
          :size="{ width: '60px' }"
          class="mt-5"
        />
      </template>
    </template>
  </div>
</template>

<script>
import EachComment from './commentarea/EachComment'
import { mapGetters } from 'vuex'
import { isMobile } from 'mobile-device-detect'

export default {
  name: 'CommentArea',
  components: {
    EachComment
  },
  data() {
    return {
      comments: [],
      comment: {
        article_id: this.$route.query.id,
        body: ''
      },
      height: '',
      page: 1,
      loading: true,
      isVisibleComment: true,
      show: false,
      infiniteLoader: true,
      isMobile: isMobile
    }
  },
  computed: {
    ...mapGetters('users', [
      'authUser'
    ]),
    styles(){
      return {
        'height': this.height
      }
    }
  },
  watch: {
    'comment.body'() {
      if (this.comment.body) this.resize()
    },
    comments() {
      for (let comment of this.comments) {
        if (comment.new) this.infiniteLoader = false
        if (!comment.new) this.infiniteLoader = true
      }
    }
  },
  created() {
    this.infiniteHandler()
  },
  methods :{
    infiniteHandler($state) {
      this.$axios.get(`comments/${this.$route.query.id}`, { params: { page: this.page }})
        .then(res => {
          if (res.data.comments.length) {
            setTimeout(() => {
              if (this.page <= res.data.kaminari.pagenation.pages) {
                this.page += 1
                this.comments.push(...res.data.comments)
                this.comments.forEach((comment, index) => {
                  comment.editable = false
                  comment.index = index
                })
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
    postComment() {
      this.$axios.post('comments', this.comment)
        .then(res => {
          this.comment.body = ''
          res.data.new = true
          this.comments.unshift(res.data)
          this.comments.forEach((comment, index) => {
            comment.editable = false
            comment.index = index
          })
        })
        .catch(err => console.log(err.response))
    },
    deleteComment(index) {
      this.comments.splice(index, 1)
      this.comments.forEach((comment, index) => {
        comment.index = index
      })
      this.loading = false
      this.isVisibleComment = false
      this.$nextTick(() => (this.isVisibleComment = true))
    },
    resize(){
      this.height = 'auto'
      this.$nextTick(()=>{
        this.height = this.$refs.area.scrollHeight + 'px'
      })
    }
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.comment-area {
  width: 400px;
}

.comment-input {
  width: 300px;
}

.comment-all {
  border-top: solid thin #D3D3D3;
}

.button {
  white-space: nowrap;
  display: inline-block;
  background-color: #FF58F2;
  padding: 7px 20px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.button:hover {
  white-space: nowrap;
  background-color: #C642BC;
  position: relative;
}

.button-mobile {
  white-space: nowrap;
  display: inline-block;
  background-color: #FF58F2;
  padding: 7px 20px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 20px;
}

.button-mobile:active {
  white-space: nowrap;
  background-color: #C642BC;
  position: relative;
}
</style>
