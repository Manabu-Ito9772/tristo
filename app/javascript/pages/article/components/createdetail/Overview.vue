<template>
  <div v-if="isVisibleOverview">
    <div v-if="$mq == 'xs'">
      <PreviewOverview
        v-if="isVisiblePreviewOverview"
        :article="article"
        @showOverviewEdit="showOverviewEdit"
      />
      <PreviewOverview
        v-if="isVisibleBeforePreviewOverview"
        :article="articleShow"
        @showOverviewEdit="showOverviewEdit"
      />
      <EditOverview
        v-if="isVisibleEditOverview"
        :article.sync="articleEdit"
        @updateOverview="updateOverview"
      />
    </div>
    <div
      v-else
    >
      <PreviewOverview
        v-if="isVisiblePreviewOverview"
        :article="article"
        @showOverviewEdit="showOverviewEdit"
      />
      <PreviewOverview
        v-if="isVisibleBeforePreviewOverview"
        :article="articleShow"
        @showOverviewEdit="showOverviewEdit"
      />
      <EditOverview
        v-if="isVisibleEditOverview"
        :article.sync="articleEdit"
        @updateOverview="updateOverview"
      />
    </div>
  </div>
</template>

<script>
import PreviewOverview from './overview/PreviewOverview'
import EditOverview from './overview/EditOverview'

export default {
  name: 'Overview',
  components: {
    PreviewOverview,
    EditOverview
  },
  props: {
    article: {
      type: Object,
      required: true
    },
  },
  data() {
    return {
      isVisibleOverview: false,
      isVisiblePreviewOverview: true,
      isVisibleBeforePreviewOverview: false,
      isVisibleEditOverview: false,
      articleShow: {},
      articleEdit: {}
    }
  },
  methods :{
    showOverview() {
      this.isVisibleOverview = true
    },
    closeOverview() {
      this.isVisibleOverview = false
    },
    showOverviewEdit(article) {
      this.articleEdit = Object.assign({}, article)
      this.isVisiblePreviewOverview = false
      this.isVisibleBeforePreviewOverview = false
      this.isVisibleEditOverview = true
    },
    updateOverview(article) {
      this.articleShow = article
      this.isVisibleEditOverview = false
      this.isVisiblePreviewOverview = false
      this.isVisibleBeforePreviewOverview = true
    }
  }
}
</script>

<style scoped>
</style>
