import Vue from 'vue'
import Vuex from 'vuex'
import users from './modules/users'
import router from './modules/router'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    router
  },
})
