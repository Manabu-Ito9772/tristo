<template>
  <div class="pt-2 pb-2 pl-3 pr-3 d-flex align-items-top comment-each">
    <img
      src="../../../../../images/sample.png"
      class="user-icon"
      @click="toUserPage(comment.user.id)"
    >
    <div class="ml-3 w-100">
      <div class="d-flex justify-content-between align-items-center">
        <p
          :id="'user-name-' + comment.user.id"
          class="m-0 text-muted word-break user-name"
          @click="toUserPage(comment.user.id)"
        >
          {{ comment.user.name }}
        </p>
        <template v-if="authUser && comment.user.id == authUser.id">
          <div class="ml-3 d-flex align-items-center icon-all">
            <template v-if="$mq == 'xs'">
              <template v-if="comment.editable">
                <p
                  class="m-0 mr-2 pl-3 pr-3 text-white font-weight-bold save-button"
                  @click="updateComment(comment.id)"
                >
                  保存
                </p>
              </template>

              <div class="p-0 icon">
                <DropdownMenu
                  v-model="show"
                  :right="right"
                  :interactive="interactive"
                >
                  <font-awesome-icon
                    :icon="['fas', 'ellipsis-h']"
                    class="fa-lg"
                  />
                  <div slot="dropdown">
                    <div
                      class="dropdown-item text-dark"
                      @click="showEditFormXS"
                    >
                      コメントを編集
                    </div>
                    <div
                      class="dropdown-item text-danger"
                      @click="deleteCommentXS(comment.id)"
                    >
                      コメントを削除
                    </div>
                  </div>
                </DropdownMenu>
              </div>
            </template>

            <template v-else>
              <template v-if="comment.editable">
                <p
                  class="m-0 pl-2 pr-2 text-white font-weight-bold save-button"
                  @click="updateComment(comment.id)"
                >
                  保存
                </p>
              </template>

              <template v-else>
                <button
                  class="btn p-0 icon"
                  @click="showEditForm"
                >
                  <font-awesome-icon
                    :icon="['fas', 'edit']"
                    class="fa-lg"
                  />
                </button>
              </template>

              <button
                class="btn ml-1 p-0 icon"
                @click="deleteComment(comment.id)"
              >
                <font-awesome-icon
                  :icon="['fas', 'trash-alt']"
                  class="fa-lg"
                />
              </button>
            </template>
          </div>
        </template>
      </div>

      <template v-if="comment.editable">
        <template v-if="authUser">
          <textarea
            ref="area"
            v-model="comment.body"
            :style="styles"
            name="コメント編集"
            rows="1"
            class="form-control mt-1"
          />
        </template>
      </template>

      <template v-else>
        <p class="m-0 text-dark word-break break-line remove-first-line">
          {{ comment.body }}
        </p>
      </template>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EachComment',
  props: {
    commentprop: {
      type: Object,
      default: null,
      required: false
    },
  },
  data() {
    return {
      comment: {},
      commentsEdit: [],
      show: false,
      right: true,
      interactive: false,
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
      if (this.comment.editable == true) {
        this.resize()
      }
    },
  },
  created() {
    this.comment = Object.assign({}, this.commentprop)
  },
  methods :{
    toUserPage(user_id) {
      if (this.authUser && this.authUser.id == user_id) {
        this.$router.push({ name: 'MyPage' })
      } else {
        this.$router.push({ name: 'UserShow', query: { id: user_id } })
      }
    },
    showEditForm() {
      this.comment.editable = true
      this.resize()
    },
    showEditFormXS() {
      this.comment.editable = true
      this.show = false
      this.resize()
    },
    updateComment(comment_id) {
      this.comment.editable = false
      this.$axios.patch(`comments/${comment_id}`, this.comment)
        .then(res => {
          this.$emit('getComments')
        })
        .catch(err => console.log(err.response))
    },
    deleteComment(comment_id) {
      if (confirm('コメントを削除しますか？')) {
        this.$axios.delete(`comments/${comment_id}`)
          .then(res => {
            this.$emit('getComments')
          })
          .catch(err => console.log(err.response))
      }
    },
    deleteCommentXS(comment_id) {
      if (confirm('コメントを削除しますか？')) {
        this.$axios.delete(`comments/${comment_id}`)
          .then(res => {
            this.show = false
            this.$emit('getComments')
          })
          .catch(err => console.log(err.response))
      }
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

.comment-each {
  border-bottom: solid thin #D3D3D3;
}

.user-icon {
  width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 50%;
  cursor: pointer;
}

.user-name {
  font-size: 13px;
  cursor: pointer;
}

.icon-all {
  white-space: nowrap;
}

.icon {
  color: gray;
  font-size: 14px;
  cursor: pointer;
}

.save-button {
  white-space: nowrap;
  background-color: #FF990D;
  border-radius: 30px;
  cursor: pointer;
}

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}
</style>
