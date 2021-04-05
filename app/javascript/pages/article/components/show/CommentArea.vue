<template>
  <div class="mb-4">
    <template v-if="authUser">
      <ValidationObserver v-slot="{ handleSubmit }">
        <div class="d-flex justify-content-center align-items-end">
          <div class="form-group m-0 comment-input">
            <ValidationProvider
              rules="input|max:500"
            >
              <textarea
                ref="area"
                v-model="comment.body"
                :style="styles"
                name="コメント"
                rows="1"
                class="form-control mt-3"
              />
            </ValidationProvider>
          </div>
          <div class="ml-2">
            <button
              class="btn text-white font-weight-bold button"
              @click="handleSubmit(postComment)"
            >
              投稿
            </button>
          </div>
        </div>
      </ValidationObserver>
    </template>

    <template v-if="comments.length">
      <div class="d-flex justify-content-center">
        <div class="mt-4 comment-area mx-auto">
          <div class="comment-all">
            <div
              v-for="comme in comments"
              :key="comme.id"
            >
              <EachComment
                :commentprop="comme"
                @getComments="getComments"
              />
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import EachComment from './commentarea/EachComment'
import { mapGetters } from 'vuex'

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
      this.resize()
    },
  },
  created() {
    this.getComments()
  },
  methods :{
    getComments() {
      this.$axios.get(`comments/${this.$route.query.id}`)
        .then(res => {
          this.comments = res.data
          for (let comment of this.comments) {
            comment.editable = false
          }
        })
        .catch(err => console.log(err.response))
    },
    postComment() {
      this.$axios.post('comments', this.comment)
        .then(res => {
          this.comment.body = ''
          this.getComments()
        })
        .catch(err => console.log(err.response))
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
  background-color: #FF00EB;
  border-radius: 30px;
}
</style>
