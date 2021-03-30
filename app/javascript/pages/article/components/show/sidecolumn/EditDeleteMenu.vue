<template>
  <div>
    <div
      class="col-12 modal d-flex justify-content-center align-items-center"
      @click.self="closeMenu"
    >
      <div class="d-flex justify-content-center align-items-center bg-white edit-box-xs">
        <div>
          <h5
            class="m-0 pt-3 pb-2 pl-4 pr-4 text-center text-dark edit-button"
            @click="showArticleEdit"
          >
            旅行記録を編集
          </h5>
          <h5
            class="m-0 pt-2 pb-3 text-center text-danger delete-button"
            @click="deleteArticle"
          >
            旅行記録を削除
          </h5>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show" />
  </div>
</template>

<script>
export default {
  name: 'EditDeleteMenu',
  data() {
    return {

    }
  },
  methods: {
    closeMenu() {
      this.$emit('closeMenu')
    },
    async deleteArticle() {
      if (confirm('旅行記録を削除しますか？')) {
        await this.$axios.delete(`articles/${this.$route.query.id}`)
          .catch(err => console.log(err.response))
        this.$router.go(-1)
      }
    },
    showArticleEdit() {
      this.$router.push({
        name: 'ArticleEdit',
        query: {id: this.$route.query.id}
      })
    }
  }
}
</script>

<style scoped>
.edit-box {
  width: 110px;
  height: 60px;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.edit-box-xs {
  width: 240px;
  border-radius: 6px;
}

.font-small {
  font-size: 13px;
}

.edit-button {
  border-bottom: solid thin #A0A0A0;
  cursor: pointer;
}

.delete-button {
  cursor: pointer;
}
</style>
