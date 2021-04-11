import axios from '../../plugins/axios'

const state = {
  articleJapan: null,
}

const getters =  {
  articleJapan: state => state.articleJapan
}

const mutations = {
  articleJapanTrue: (state) => {
    state.articleJapan = true
  },
  articleJapanFalse: (state) => {
    state.articleJapan = false
  },
}

const actions = {}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
