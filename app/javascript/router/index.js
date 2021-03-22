import Vue from 'vue';
import Router from 'vue-router';

import ArticleIndex from '../pages/article/index'
import ArticleShow from '../pages/article/show'
import ArticleCreateOverview from '../pages/article/createOverview'
import ArticleCreateDetail from '../pages/article/createDetail'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/articles',
      component: ArticleIndex,
      name: 'ArticleIndex'
    },
    {
      path: '/article',
      component: ArticleShow,
      name: 'ArticleShow',
      props: true
    },
    {
      path: '/article_create',
      component: ArticleCreateOverview,
      name: 'ArticleCreateOverview',
    },
    {
      path: '/article_create_detail',
      component: ArticleCreateDetail,
      name: 'ArticleCreateDetail',
      props: true
    },
    {
      path: '/',
      redirect: { name: 'ArticleIndex' }
    },
  ]
})

export default router
