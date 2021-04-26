<template>
  <div class="pt-2 pb-2 pl-3 pr-3 d-flex align-items-top comment-each">
    <div>
      <img
        :src="comment.user.avatar_url"
        class="user-icon"
        @click="toUserPage(comment.user.id)"
      >
    </div>
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
                <template v-if="isMobile">
                  <p
                    class="m-0 mr-2 pl-3 pr-3 text-white font-weight-bold save-button-mobile"
                    @click="updateComment(comment.id)"
                  >
                    保存
                  </p>
                </template>
                <template v-else>
                  <p
                    class="m-0 mr-2 pl-3 pr-3 text-white font-weight-bold save-button"
                    @click="updateComment(comment.id)"
                  >
                    保存
                  </p>
                </template>
              </template>

              <div class="p-0">
                <DropdownMenu
                  v-model="show"
                  :right="right"
                  :interactive="interactive"
                >
                  <template v-if="isMobile">
                    <div class="icon-mobile">
                      <font-awesome-icon
                        :icon="['fas', 'ellipsis-h']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                  <template v-else>
                    <div class="icon">
                      <font-awesome-icon
                        :icon="['fas', 'ellipsis-h']"
                        class="fa-lg"
                      />
                    </div>
                  </template>
                  <div slot="dropdown">
                    <div
                      class="dropdown-item edit-comment"
                      @click="showEditFormXS"
                    >
                      コメントを編集
                    </div>
                    <div
                      class="dropdown-item delete-comment"
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
                <template v-if="isMobile">
                  <p
                    class="m-0 pl-3 pr-3 text-white font-weight-bold save-button-mobile"
                    @click="updateComment(comment.id)"
                  >
                    保存
                  </p>
                </template>
                <template v-else>
                  <p
                    class="m-0 pl-3 pr-3 text-white font-weight-bold save-button"
                    @click="updateComment(comment.id)"
                  >
                    保存
                  </p>
                </template>
              </template>

              <template v-else>
                <template v-if="isMobile">
                  <div
                    class="p-0 icon-mobile"
                    @click="showEditForm"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'edit']"
                      class="fa-lg"
                    />
                  </div>
                </template>
                <template v-else>
                  <div
                    class="p-0 icon"
                    @click="showEditForm"
                  >
                    <font-awesome-icon
                      :icon="['fas', 'edit']"
                      class="fa-lg"
                    />
                  </div>
                </template>
              </template>

              <template v-if="isMobile">
                <div
                  class="ml-1 p-0 icon-mobile"
                  @click="deleteComment(comment.id)"
                >
                  <font-awesome-icon
                    :icon="['fas', 'trash-alt']"
                    class="fa-lg"
                  />
                </div>
              </template>
              <template v-else>
                <div
                  class="ml-1 p-0 icon"
                  @click="deleteComment(comment.id)"
                >
                  <font-awesome-icon
                    :icon="['fas', 'trash-alt']"
                    class="fa-lg"
                  />
                </div>
              </template>
            </template>
          </div>
        </template>
      </div>

      <template v-if="comment.editable">
        <template v-if="authUser">
          <ValidationProvider
            rules="input|max:500"
          >
            <textarea
              ref="area"
              v-model="comment.body"
              :style="styles"
              name="コメント"
              rows="1"
              class="form-control mt-1"
            />
          </ValidationProvider>
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
import { isMobile } from 'mobile-device-detect'

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
      interactive: true,
      height: '',
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
      if (this.comment.body && this.comment.body.length <= 500) {
        this.comment.editable = false
        this.$axios.patch(`comments/${comment_id}`, this.comment)
          .catch(err => console.log(err.response))
      }
    },
    deleteComment(comment_id) {
      if (confirm('コメントを削除しますか？')) {
        this.$axios.delete(`comments/${comment_id}`)
          .then(res => {
            this.$emit('deleteComment', this.comment.index)
          })
          .catch(err => console.log(err.response))
      }
    },
    deleteCommentXS(comment_id) {
      this.show = false
      if (confirm('コメントを削除しますか？')) {
        this.$axios.delete(`comments/${comment_id}`)
          .then(res => {
            this.show = false
            this.$emit('deleteComment', this.comment.index)
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

.icon:hover {
  color: #383838;
  cursor: pointer;
}

.icon-mobile {
  color: gray;
  font-size: 14px;
  cursor: pointer;
}

.icon-mobile:active {
  color: #383838;
  cursor: pointer;
}

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}

.delete-comment {
  color: #dc3545;
  cursor: pointer;
}

.delete-comment:hover {
  color: #dc3545;
}

.delete-comment:active {
  color: white;
}

.edit-comment {
  cursor: pointer;
}

.save-button {
  font-size: 14px;
  white-space: nowrap;
  display: inline-block;
  background-color: #FF990D;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 30px;
}

.save-button:hover {
  background-color: #D37C04;
  position: relative;
}

.save-button-mobile {
  font-size: 14px;
  white-space: nowrap;
  display: inline-block;
  background-color: #FF990D;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 30px;
}

.save-button-mobile:active {
  background-color: #D37C04;
  position: relative;
}
</style>
