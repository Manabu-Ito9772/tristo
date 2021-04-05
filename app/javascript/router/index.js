import Vue from 'vue'
import Router from 'vue-router'
import store from '../store'

import ArticleIndex from '../pages/article/index'
import ArticleShow from '../pages/article/show'
import ArticleCreateOverview from '../pages/article/createOverview'
import ArticleCreateDetail from '../pages/article/createDetail'
import ArticleEdit from '../pages/article/edit'
import Register from '../pages/register/register'
import Login from '../pages/session/login'
import UserShow from '../pages/user/show'
import MyPage from '../pages/user/mypage'
import EditMyPage from '../pages/user/editmypage'
import AccountSettings from '../pages/user/accountsettings'
import Following from '../pages/user/following'

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
      meta: { requiredAuth: true }
    },
    {
      path: '/create_trip_detail',
      component: ArticleCreateDetail,
      name: 'ArticleCreateDetail',
      props: true,
      meta: { requiredAuth: true },
    },
    {
      path: '/edit_trip',
      component: ArticleEdit,
      name: 'ArticleEdit',
      meta: { requiredAuth: true },
    },
    {
      path: '/register',
      component: Register,
      name: 'Register'
    },
    {
      path: '/login',
      component: Login,
      name: 'Login'
    },
    {
      path: '/user',
      component: UserShow,
      name: 'UserShow',
      props: true,
    },
    {
      path: '/mypage',
      component: MyPage,
      name: 'MyPage',
      meta: { requiredAuth: true }
    },
    {
      path: '/edit_mypage',
      component: EditMyPage,
      name: 'EditMyPage',
      meta: { requiredAuth: true }
    },
    {
      path: '/account_settings',
      component: AccountSettings,
      name: 'AccountSettings',
      meta: { requiredAuth: true }
    },
    {
      path: '/following',
      component: Following,
      name: 'Following',
    },
    {
      path: '/followers',
      component: Following,
      name: 'Followers',
    },
  ]
})

router.beforeEach((to, from, next) => {
  store.dispatch('users/fetchAuthUser').then((authUser) => {
    if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
      next({ name: 'Login' });
    } else {
      next();
    }
  })
})

export default router
