import axios from '../../plugins/axios'

const state = {
  articles: [],
  article: {}
}

const getters = {
  articles(state) {
		return state.articles
	},
  articleDetail(state) {
    return state.article
  }
}

const mutations = {
  setArticles(state, articles) {
    state.articles = articles
  },
  setArticleDetail(state, article) {
    state.article = article
  }
}

const actions = {
  getArticles({ commit }) {
    axios.get('articles')
      .then(res => {
        commit('setArticles', res.data)
      })
      .catch(err => console.log(err.response));
  },
  async getArticleDetail({ commit }, article_id) {
    await commit('setArticleDetail', null)
    axios.get(`articles/${article_id}`)
      .then(res => {
        commit('setArticleDetail', res.data)
      })
      .catch(err => console.log(err.response));
  },
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
