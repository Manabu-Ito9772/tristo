import axios from '../../plugins/axios'

const state = {
  articles: []
}

const getters = {
  articles(state) {
		return state.articles
	}
}

const mutations = {
  setArticles(state, articles) {
    state.articles = articles
  }
}

const actions = {
  getArticles({ commit }) {
    axios.get('articles')
      .then(res => {
        commit('setArticles', res.data)
      })
      .catch(err => console.log(err.response));
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
