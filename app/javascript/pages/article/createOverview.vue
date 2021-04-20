<template>
  <div class="container-fluid overview mt-4">
    <div class="row">
      <div class="col-12">
        <template v-if="$mq == 'xs'">
          <OverviewFormSmall />
        </template>
        <template v-else>
          <OverviewForm
            class="pt-2"
          />
        </template>
      </div>
    </div>
  </div>
</template>

<script>
import OverviewForm from './components/createoverview/OverviewForm'
import OverviewFormSmall from './components/createoverview/OverviewFormSmall'
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'ArticleCreateOverview',
  components: {
    OverviewForm,
    OverviewFormSmall,
  },
}
</script>

<style scoped>
.overview {
  max-width: 500px;
}

.detail {
  max-width: 1000px;
}
</style>
