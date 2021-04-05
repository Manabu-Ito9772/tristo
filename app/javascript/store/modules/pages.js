import axios from '../../plugins/axios'

const state = {
  currentPage: '',
}

const getters = {
  currentPage: state => state.currentPage,
}

const mutations = {
  setCurrentPage(state, page) {
    state.currentPage = page
  }
}

const actions = {}

export default {
  namespaced: true,
  state,
  mutations,
  getters,
}
