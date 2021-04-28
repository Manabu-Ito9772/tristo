<template>
  <div class="mb-4">
    <div class="d-flex justify-content-center">
      <div class="pt-3 pr-3 pl-3 bg-white cost-column">
        <div
          v-for="costByGenre in costs"
          :key="costByGenre[0]"
        >
          <div v-if="costByGenre[1].length">
            <template v-if="costByGenre[0] == '6'">
              <template v-if="checkTransportationCost(costByGenre[1])">
                <div class="mb-3">
                  <p class="mb-0 text-center text-white content-label">
                    {{ labelOrCost(costByGenre[1][0].genre).label }}
                  </p>
                  <div
                    v-for="costInfo in costByGenre[1]"
                    :key="costInfo.id"
                  >
                    <template v-if="costInfo.cost">
                      <div class="row mt-2 ml-2 mr-2 cost-border">
                        <div class="col-8 p-0">
                          <p class="m-0 word-break">
                            <template v-if="costInfo.description">
                              {{ costInfo.description }}
                            </template>
                            <template v-else>
                              {{ defaultTransportationDescription(costInfo.means) }}
                            </template>
                          </p>
                        </div>
                        <div class="col-4 p-0 text-right">
                          <p class="d-inline-block m-0 word-break">
                            {{ separateWithComma(costInfo.cost) }}
                          </p>
                          <p class="d-inline-block m-0 no-wrap">
                            {{ currency }}
                          </p>
                        </div>
                      </div>
                    </template>
                  </div>
                  <div class="row mt-2 ml-2 mr-2">
                    <div class="col-12 p-0 text-right">
                      <p class="d-inline-block m-0 font-weight-bold no-wrap">
                        合計：&nbsp;
                      </p>
                      <p class="d-inline-block m-0 font-weight-bold word-break">
                        {{ labelOrCost(costByGenre[1][0].genre).cost }}
                      </p>
                      <p class="d-inline-block m-0 font-weight-bold no-wrap">
                        {{ currency }}
                      </p>
                    </div>
                  </div>
                </div>
              </template>
            </template>

            <template v-else>
              <div class="mb-3">
                <p class="mb-0 text-center text-white content-label">
                  {{ labelOrCost(costByGenre[1][0].genre).label }}
                </p>
                <div
                  v-for="costInfo in costByGenre[1]"
                  :key="costInfo.id"
                >
                  <div class="row mt-2 ml-2 mr-2 cost-border">
                    <div class="col-8 p-0">
                      <p class="m-0 word-break">
                        {{ costInfo.description }}
                      </p>
                    </div>
                    <div class="col-4 p-0 text-right">
                      <p class="d-inline-block m-0 word-break">
                        {{ separateWithComma(costInfo.cost) }}
                      </p>
                      <p class="d-inline-block m-0 no-wrap">
                        {{ currency }}
                      </p>
                    </div>
                  </div>
                </div>
                <div class="row mt-2 ml-2 mr-2">
                  <div class="col-12 p-0 text-right">
                    <p class="d-inline-block m-0 font-weight-bold no-wrap">
                      合計：&nbsp;
                    </p>
                    <p class="d-inline-block m-0 font-weight-bold word-break">
                      {{ labelOrCost(costByGenre[1][0].genre).cost }}
                    </p>
                    <p class="d-inline-block m-0 font-weight-bold no-wrap">
                      {{ currency }}
                    </p>
                  </div>
                </div>
              </div>
            </template>
          </div>
        </div>
        <div class="mt-5 mb-5 ml-2 mr-2 text-center">
          <h4 class="d-inline text-dark font-weight-bold toatal-cost-border no-wrap">
            総計：&nbsp;
          </h4>
          <h4 class="d-inline text-dark font-weight-bold toatal-cost-border">
            {{ separateWithComma(totalCost) }}
          </h4>
          <h4 class="d-inline text-dark font-weight-bold toatal-cost-border no-wrap">
            {{ currency }}
          </h4>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CostColumn',
  props: {
    days: {
      type: Array,
      required: true
    },
    currency: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      tourings: ['1', []],
      activities: ['2', []],
      foods: ['3', []],
      souvenirs: ['4', []],
      accommodations: ['5', []],
      transportations: ['6', []],
      others: ['7', []],
      costs: [],
      totalTouringCost: null,
      totalActivityCost: null,
      totalFoodCost: null,
      totalSouvenirCost: null,
      totalAccommodationCost: null,
      totalTransportationCost: null,
      totalOtherCost: null,
      totalCost: null,
    }
  },
  created() {
    this.classifyCost()
  },
  methods :{
    classifyCost() {
      this.days.forEach(day => {
        day.ordered_blocks.forEach(block => {
          block.spendings.forEach(spending => {
            if (spending.genre == 'touring') {
              this.tourings[1].push(spending)
              this.totalTouringCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'activity') {
              this.activities[1].push(spending)
              this.totalActivityCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'food') {
              this.foods[1].push(spending)
              this.totalFoodCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'souvenir') {
              this.souvenirs[1].push(spending)
              this.totalSouvenirCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'accommodation') {
              this.accommodations[1].push(spending)
              this.totalAccommodationCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == 'other') {
              this.others[1].push(spending)
              this.totalOtherCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            } else if (spending.genre == null) {
              this.others[1].push(spending)
              this.totalOtherCost += Number(spending.cost)
              this.totalCost += Number(spending.cost)
            }
          })
          block.transportations.forEach(transportation => {
            this.transportations[1].push(transportation)
            this.totalTransportationCost += Number(transportation.cost)
            this.totalCost += Number(transportation.cost)
          })
        })
      })
      this.costs.push(
        this.tourings,
        this.activities,
        this.foods,
        this.souvenirs,
        this.accommodations,
        this.transportations,
        this.others
      )
    },
    separateWithComma(num) {
      let cost = Number(num)
      return cost.toLocaleString()
    },
    labelOrCost(genre) {
      if (genre == 'touring')
        return {
          label: '観光費',
          cost: this.separateWithComma(this.totalTouringCost)
        }
      if (genre == 'activity')
        return {
          label: 'アクティビティ費用',
          cost: this.separateWithComma(this.totalActivityCost)
        }
      if (genre == 'food')
        return {
          label: '食費',
          cost: this.separateWithComma(this.totalFoodCost)
        }
      if (genre == 'souvenir')
        return {
          label: 'お土産代',
          cost: this.separateWithComma(this.totalSouvenirCost)
        }
      if (genre == 'accommodation')
        return {
          label: '宿泊費',
          cost: this.separateWithComma(this.totalAccommodationCost)
        }
      if (genre == 'other')
        return {
          label: 'その他',
          cost: this.separateWithComma(this.totalOtherCost)
        }
      if (genre == null)
        return {
          label: '交通費',
          cost: this.separateWithComma(this.totalTransportationCost)
        }
    },
    defaultTransportationDescription(means) {
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
    },
    checkTransportationCost(transportArray) {
      let cost = 0
      for (let transport of transportArray) {
        cost += Number(transport.cost)
      }
      if (cost == 0) {
        return false
      } else {
        return true
      }
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

.no-wrap {
  white-space: nowrap;
}
</style>
