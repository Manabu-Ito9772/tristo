<template>
  <div class="w-100">
    <template v-if="article.title">
      <h4 class="col-12 mb-1 p-2 text-center text-white font-weight-bold article-title word-break">
        {{ article.title }}
      </h4>
    </template>

    <div class="col-12 mb-3 text-muted text-center word-break article-info">
      <template v-if="countryname">
        <template v-if="countryname != '日本'">
          <p class="d-inline">
            【{{ countryname }}】
          </p>
        </template>
      </template>
      <p
        v-for="region in article.regions"
        :key="region.id"
        class="d-inline pl-1 pr-1 article-region"
      >
        {{ region.name }}
      </p>
      <template v-if="article.start_date && article.end_date">
        <p class="d-inline pl-1 pr-1 article-date">
          {{ article.start_date | moment('M/D(ddd)') }}〜{{ article.end_date | moment('M/D(ddd)') }}
        </p>
      </template>
      <template v-else-if="article.start_date && !article.end_date">
        <p class="d-inline pl-1 pr-1 article-date">
          {{ article.start_date | moment('M/D(ddd)') }}
        </p>
      </template>
      <template v-else-if="!article.start_date && article.end_date">
        <p class="d-inline pl-1 pr-1 article-date">
          {{ article.end_date | moment('M/D(ddd)') }}
        </p>
      </template>
      <div class="d-flex justify-content-center">
        <p
          v-for="article_tag in article.article_tags"
          :key="article_tag.id"
          class="m-0 pl-1 pr-1 text-primary article-tag"
        >
          #{{ article_tag.tag.name }}
        </p>
      </div>
    </div>

    <template v-if="article.description">
      <div class="col-12 p-0 mb-3 article-description">
        <p class="text-center text-white m-0 description-label">
          説明
        </p>
        <p class="text-dark bg-white pt-2 pb-2 pl-3 pr-3 m-0 word-break description-main break-line remove-first-line">
          {{ article.description }}
        </p>
      </div>
    </template>

    <div class="col-12 p-0 d-flex justify-content-center align-items-center user-name">
      <img
        src="../../../../images/sample.png"
        class="user-icon"
      >
      <h5
        class="float-right mb-0 pl-3 pr-3 text-dark font-weight-bold word-break user-link"
        @click="toUserPage(user.id)"
      >
        {{ user.name }}
      </h5>
      <div class="text-center">
        <font-awesome-icon
          :icon="['far', 'thumbs-up']"
          class="fa-lg"
        />
        <p class="m-0 word-break favorites">
          100
        </p>
      </div>

      <template v-if="isAuthUser">
        <div class="pl-3">
          <button
            class="btn d-flex justify-content-center align-items-center edit-menu"
            @click="showMenu"
          >
            <font-awesome-icon
              :icon="['fas', 'ellipsis-h']"
              class="fa-lg"
            />
          </button>
        </div>
      </template>
    </div>

    <transition name="fade">
      <EditDeleteMenu
        v-if="isVisibleMenu"
        @closeMenu="closeMenu"
      />
    </transition>
  </div>
</template>

<script>
import EditDeleteMenu from './sidecolumn/EditDeleteMenu'
import { mapGetters } from "vuex"

export default {
  name: 'SideColumn',
  components: {
    EditDeleteMenu
  },
  props: {
    article: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    },
    countryname: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      countryName: '',
      tags: [],
      isVisibleMenu: false
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
    isAuthUser() {
      if (this.authUser != null) {
        if (this.user.id == this.authUser.id) {
          return true
        } else {
          return false
        }
      } else {
        return false
      }
    }
  },
  methods: {
    showMenu() {
      this.isVisibleMenu = true
      this.$emit('fixPage')
    },
    closeMenu() {
      this.isVisibleMenu = false
      this.$emit('flowPage')
    },
    toUserPage(user_id) {
      if (this.authUser && this.authUser.id == user_id) {
        this.$store.commit('pages/setCurrentPage', 'user')
        this.$router.push({ name: 'MyPage' })
      } else {
        this.$router.push({ name: 'UserShow', query: { id: user_id } })
      }
    },
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.article-title {
  background-color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.user-name {
  display: inline-block;
  vertical-align: middle;
  cursor: pointer;
}

.user-icon {
  width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 50%;
}

.user-link {
  color: black;
}

.description-label {
  background-color: #6A6A6A;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.description-main {
  font-size: 14px;
  border: solid thin #6A6A6A;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
  border-width: 0px 0.1px 0.1px 0.1px;
}

.article-info {
  font-size: 14px;
}

.edit-menu {
  font-size: 12px;
  width: 25px;
	height: 25px;
  border: solid thin #6A6A6A;
  object-fit: cover;
	border-radius: 50%;
}

.edit-box {
  width: 110px;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.font-small {
  font-size: 13px;
}

.edit-button {
  border-bottom: solid thin #6A6A6A;
}

.favorites {
  white-space: nowrap;
}

.break-line {
  white-space: pre-line;
}

.remove-first-line:first-line {
  line-height: 0px;
}

.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
