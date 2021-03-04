<template>
  <div>
    <!-- <template v-if="$mq == 'sm'"> -->
    <div class="d-flex justify-content-center">
      <div class="pt-3 pr-3 pl-3 bg-white cost-column">
        <template v-if="tourings.length">
          <div class="mb-3">
            <p class="mb-0 text-center text-white content-label">
              観光費
            </p>
            <div
              v-for="touring in tourings"
              :key="touring.id"
            >
              <div class="row mt-2 ml-2 mr-2 cost-border">
                <div class="col-8 p-0">
                  <p class="m-0 word-break">
                    {{ touring.description }}
                  </p>
                </div>
                <div class="col-4 p-0 text-right">
                  <p class="m-0">
                    {{ separateWithComma(touring.cost) }}円
                  </p>
                </div>
              </div>
            </div>
            <div class="row mt-2 ml-2 mr-2 cost-border">
              <div class="col-12 p-0 text-right">
                <p class="m-0 font-weight-bold">
                  合計：&nbsp;&nbsp;{{ separateWithComma(totalTouringCost) }}円
                </p>
              </div>
            </div>
          </div>
        </template>
        <template v-if="activities.length">
          <div class="mb-3">
            <p class="mb-0 text-center text-white content-label">
              アクティビティ費
            </p>
            <div
              v-for="activity in activities"
              :key="activity.id"
            >
              <div class="row mt-2 ml-2 mr-2 cost-border">
                <div class="col-8 p-0">
                  <p class="m-0 word-break">
                    {{ activity.description }}
                  </p>
                </div>
                <div class="col-4 p-0 text-right">
                  <p class="m-0">
                    {{ separateWithComma(activity.cost) }}円
                  </p>
                </div>
              </div>
            </div>
            <div class="row mt-2 ml-2 mr-2 cost-border">
              <div class="col-12 p-0 text-right">
                <p class="m-0 font-weight-bold">
                  合計：&nbsp;&nbsp;{{ separateWithComma(totalActivityCost) }}円
                </p>
              </div>
            </div>
          </div>
        </template>
        <template v-if="foods.length">
          <div class="mb-3">
            <p class="mb-0 text-center text-white content-label">
              食費
            </p>
            <div
              v-for="food in foods"
              :key="food.id"
            >
              <div class="row mt-2 ml-2 mr-2 cost-border">
                <div class="col-8 p-0">
                  <p class="m-0 word-break">
                    {{ food.description }}
                  </p>
                </div>
                <div class="col-4 p-0 text-right">
                  <p class="m-0">
                    {{ separateWithComma(food.cost) }}円
                  </p>
                </div>
              </div>
            </div>
            <div class="row mt-2 ml-2 mr-2 cost-border">
              <div class="col-12 p-0 text-right">
                <p class="m-0 font-weight-bold">
                  合計：&nbsp;&nbsp;{{ separateWithComma(totalFoodCost) }}円
                </p>
              </div>
            </div>
          </div>
        </template>
        <template v-if="souvenirs.length">
          <div class="mb-3">
            <p class="mb-0 text-center text-white content-label">
              お土産代
            </p>
            <div
              v-for="souvenir in souvenirs"
              :key="souvenir.id"
            >
              <div class="row mt-2 ml-2 mr-2 cost-border">
                <div class="col-8 p-0">
                  <p class="m-0 word-break">
                    {{ souvenir.description }}
                  </p>
                </div>
                <div class="col-4 p-0 text-right">
                  <p class="m-0">
                    {{ separateWithComma(souvenir.cost) }}円
                  </p>
                </div>
              </div>
            </div>
            <div class="row mt-2 ml-2 mr-2 cost-border">
              <div class="col-12 p-0 text-right">
                <p class="m-0 font-weight-bold">
                  合計：&nbsp;&nbsp;{{ separateWithComma(totalSouvenirCost) }}円
                </p>
              </div>
            </div>
          </div>
        </template>
        <template v-if="accommodations.length">
          <div class="mb-3">
            <p class="mb-0 text-center text-white content-label">
              宿泊費
            </p>
            <div
              v-for="accommodation in accommodations"
              :key="accommodation.id"
            >
              <div class="row mt-2 ml-2 mr-2 cost-border">
                <div class="col-8 p-0">
                  <p class="m-0 word-break">
                    {{ accommodation.description }}
                  </p>
                </div>
                <div class="col-4 p-0 text-right">
                  <p class="m-0">
                    {{ separateWithComma(accommodation.cost) }}円
                  </p>
                </div>
              </div>
            </div>
            <div class="row mt-2 ml-2 mr-2 cost-border">
              <div class="col-12 p-0 text-right">
                <p class="m-0 font-weight-bold">
                  合計：&nbsp;&nbsp;{{ separateWithComma(totalAccommodationCost) }}円
                </p>
              </div>
            </div>
          </div>
        </template>
        <template v-if="transportations.length">
          <div class="mb-3">
            <p class="mb-0 text-center text-white content-label">
              交通費
            </p>
            <div
              v-for="transportation in transportations"
              :key="transportation.id"
            >
              <template v-if="transportation.cost != null">
                <div class="row mt-2 ml-2 mr-2 cost-border">
                  <div class="col-8 p-0">
                    <p class="m-0 word-break">
                      <template v-if="transportation.description">
                        {{ transportation.description }}
                      </template>
                      <template v-else>
                        {{ defaultTransportation(transportation.means) }}
                      </template>
                    </p>
                  </div>
                  <div class="col-4 p-0 text-right">
                    <p class="m-0">
                      {{ separateWithComma(transportation.cost) }}円
                    </p>
                  </div>
                </div>
              </template>
            </div>
            <div class="row mt-2 ml-2 mr-2 cost-border">
              <div class="col-12 p-0 text-right">
                <p class="m-0 font-weight-bold">
                  合計：&nbsp;&nbsp;{{ separateWithComma(totalTransportationCost) }}円
                </p>
              </div>
            </div>
          </div>
        </template>
        <template v-if="others.length">
          <div class="mb-3">
            <p class="mb-0 text-center text-white content-label">
              その他
            </p>
            <div
              v-for="other in others"
              :key="other.id"
            >
              <div class="row mt-2 ml-2 mr-2 cost-border">
                <div class="col-8 p-0">
                  <p class="m-0 word-break">
                    {{ other.description }}
                  </p>
                </div>
                <div class="col-4 p-0 text-right">
                  <p class="m-0">
                    {{ separateWithComma(other.cost) }}円
                  </p>
                </div>
              </div>
            </div>
            <div class="row mt-2 ml-2 mr-2 cost-border">
              <div class="col-12 p-0 text-right">
                <p class="m-0 font-weight-bold">
                  合計：&nbsp;&nbsp;{{ separateWithComma(totalOtherCost) }}円
                </p>
              </div>
            </div>
          </div>
        </template>
        <div class="mt-5 mb-5 ml-2 mr-2 text-center">
          <h4 class="d-inline font-weight-bold toatal-cost-border">
            総コスト：&nbsp;{{ separateWithComma(totalCost) }}円
          </h4>
        </div>
      </div>
    </div>
    <!-- </template>
    <template v-else>
      <div class="row sidebar_fixed pl-3 pr-3">
        <h4 class="col-12 mb-1 p-2 text-center text-white font-weight-bold article-title word-break">
          aaaaaaaaaaaaaaaaaaaaaaaaaa
        </h4>
      </div>
    </template> -->
  </div>
</template>

<script>
export default {
  name: 'CostColumn',
  props: {
    days: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      tourings: [],
      activities: [],
      foods: [],
      souvenirs: [],
      accommodations: [],
      transportations: [],
      others: [],
      totalTouringCost: 0,
      totalActivityCost: 0,
      totalFoodCost: 0,
      totalSouvenirCost: 0,
      totalAccommodationCost: 0,
      totalTransportationCost: 0,
      totalOtherCost: 0,
      totalCost: 0
    }
  },
  computed: {
    totalCostComma() {
      return this.totalCost.toLocaleString()
    }
  },
  created() {
    this.classifyCost()
  },
  methods :{
    classifyCost() {
      return this.days.forEach(day => {
        return day.info_blocks.forEach(info_block => {
          info_block.spendings.forEach(spending => {
            if (spending.genre == 'touring') {
              this.tourings.push(spending)
              this.totalTouringCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'activity') {
              this.activities.push(spending)
              this.totalActivityCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'food') {
              this.foods.push(spending)
              this.totalFoodCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'souvenir') {
              this.souvenirs.push(spending)
              this.totalSouvenirCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'accommodation') {
              this.accommodations.push(spending)
              this.totalAccommodationCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'other') {
              this.others.push(spending)
              this.totalOtherCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            }
          })
          info_block.transportations.forEach(transportation => {
            this.transportations.push(transportation)
            this.totalTransportationCost += Number(transportation.cost)
            this.totalCost += Number(transportation.cost)
          })
        })
      })
    },
    separateWithComma(num) {
      let cost = Number(num)
      return cost.toLocaleString()
    },
    defaultTransportation(means) {
      if (means == 'walking') return '徒歩'
      if (means == 'car') return '車'
      if (means == 'taxi') return 'タクシー'
      if (means == 'bus') return 'バス'
      if (means == 'subway') return '電車'
      if (means == 'ship') return '船'
      if (means == 'plane') return '飛行機'
      if (means == 'bicycle') return '自転車'
      if (means == 'motorcycle') return 'バイク'
      if (means == 'other') return 'その他'
    }
  }
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.sample {
  width: 400px;
}

.cost-column {
  width: 400px;
  border: solid #1D51FF;
  border-radius: 6px;
}

.content-label {
  background-color: #1D51FF;
  border-radius: 8px;
}

.cost-border {
  border-bottom: solid thin #CBCBCB;
}

.toatal-cost-border {
  border-bottom: solid #1D51FF;
}
</style>
