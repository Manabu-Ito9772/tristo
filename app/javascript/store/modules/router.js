import axios from '../../plugins/axios'

const state = {
  prevRoute: [],
  prePrevRoute: [],
  prePrePrevRoute: []
}

const getters = {
  prevRoute: state => state.prevRoute,
  prePrevRoute: state => state.prePrevRoute,
  prePrePrevRoute: state => state.prePrePrevRoute
}

const mutations = {
  setPrevRoute(state, from) {
    if (state.prePrevRoute) {
      state.prePrePrevRoute = state.prePrevRoute
    }
    if (state.prevRoute) {
      state.prePrevRoute = state.prevRoute
    }
    state.prevRoute = from
  }
}

const actions = {}

export default {
  namespaced: true,
  state,
  mutations,
  getters,
}
