import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import users from './modules/users'
import pages from './modules/pages'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    pages
  },
  plugins: [createPersistedState(
    {
      paths: ['pages.currentPage'],
      storage: window.sessionStorage
    }
  )]
})
