import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import articles from './modules/articles'
import users from './modules/users'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    articles,
    users
  },
  plugins: [createPersistedState(
    {
      paths: ['articles.article'],
      storage: window.sessionStorage
    }
  )]
})
