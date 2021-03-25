<template>
  <div class="w-100">
    <h4 class="col-12 mb-1 p-2 text-center text-white font-weight-bold article-title word-break">
      {{ article.title }}
    </h4>

    <div class="col-12 mb-3 text-muted text-center word-break article-info">
      <template v-if="countryname != '日本'">
        <p class="d-inline">
          【{{ countryname }}】
        </p>
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
        <p class="d-flex justify-content-center text-dark bg-white p-2 m-0 word-break description-main">
          {{ article.description }}
        </p>
      </div>
    </template>

    <div class="col-12 p-0 d-flex justify-content-center align-items-center user-name">
      <img
        src="../../../../images/sample.png"
        class="user-icon pr-1"
      >
      <h5 class="float-right mb-0 pl-1 pr-1 word-break">
        Ito Manabu
      </h5>
      <div class="text-center pl-1 pr-1">
        <font-awesome-icon
          :icon="['far', 'thumbs-up']"
          class="fa-lg"
        />
        <p class="m-0 word-break">
          100
        </p>
      </div>
      <div class="pl-1">
        <template v-if="isVisibleMenu">
          <button
            class="btn d-flex justify-content-center align-items-center edit-menu"
            @click="closeMenu"
          >
            <font-awesome-icon
              :icon="['fas', 'ellipsis-h']"
              class="fa-lg"
            />
          </button>
        </template>
        <template v-else>
          <button
            class="btn d-flex justify-content-center align-items-center edit-menu"
            @click="showMenu"
          >
            <font-awesome-icon
              :icon="['fas', 'ellipsis-h']"
              class="fa-lg"
            />
          </button>
        </template>
      </div>
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
  methods: {
    showMenu() {
      this.isVisibleMenu = true
      this.$emit('fixPage')
    },
    closeMenu() {
      this.isVisibleMenu = false
      this.$emit('flowPage')
    }
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
}

.user-icon {
  width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 50%;
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

.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
