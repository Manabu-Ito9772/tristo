import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import articles from './modules/articles'
import users from './modules/users'
import pages from './modules/pages'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    articles,
    users,
    pages
  },
  plugins: [createPersistedState(
    {
      paths: ['articles.articles', 'articles.articleJapan'],
      storage: window.sessionStorage
    },
    {
      paths: ['pages.currentPage'],
      storage: window.sessionStorage
    }
  )]
})
