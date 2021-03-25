import Vue from 'vue';
import Router from 'vue-router';

import ArticleIndex from '../pages/article/index'
import ArticleShow from '../pages/article/show'
import ArticleCreateOverview from '../pages/article/createOverview'
import ArticleCreateDetail from '../pages/article/createDetail'
import ArticleEdit from '../pages/article/edit'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      redirect: { name: 'ArticleIndex' }
    },
    {
      path: '/trips',
      component: ArticleIndex,
      name: 'ArticleIndex'
    },
    {
      path: '/trip',
      component: ArticleShow,
      name: 'ArticleShow',
      props: true
    },
    {
      path: '/create_trip',
      component: ArticleCreateOverview,
      name: 'ArticleCreateOverview',
    },
    {
      path: '/create_trip_detail',
      component: ArticleCreateDetail,
      name: 'ArticleCreateDetail',
      props: true
    },
    {
      path: '/edit_trip',
      component: ArticleEdit,
      name: 'ArticleEdit'
    }
  ]
})

export default router
