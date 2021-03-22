<template>
  <div>
    <template v-if="$mq == 'sm'">
      <div class="mt-4 bg-white search">
        <div class="row">
          <h4 class="col-12 mb-1 text-center text-white font-weight-bold article-title word-break">
            hello
          </h4>
          <p class="col-12 text-muted text-center word-break article-info">
            hello
          </p>
          <div class="col-12 p-0 mb-3">
            <p class="text-center text-white m-0 description-label">
              概要
            </p>
            <p class="text-dark bg-white p-2 m-0 word-break description-main">
              hello
            </p>
          </div>
          <div class="col-12 pl-0 pr-0 d-flex justify-content-center align-items-center user-name">
            <img
              src="../../../../images/sample.png"
              class="user-icon"
            >
            <h4 class="float-right mb-0 pl-2 word-break">
              Ito Manabu
            </h4>
            <div class="text-center pl-4">
              <font-awesome-icon
                :icon="['far', 'thumbs-up']"
                class="fa-lg"
              />
              <p class="m-0 word-break">
                100
              </p>
            </div>
          </div>
        </div>
      </div>
    </template>
    <template v-else>
      <div class="sidebar_fixed mt-4 pl-3 pr-3">
        <div class="row bg-white search">
          <h4 class="col-12 mb-1 p-2 text-center text-white font-weight-bold article-title word-break">
            hello
          </h4>
          <p class="col-12 text-muted text-center word-break article-info">
            hello
          </p>
          <div class="col-12 p-0 mb-3">
            <p class="text-center text-white m-0 description-label">
              概要
            </p>
            <p class="text-dark bg-white p-2 m-0 word-break description-main">
              hello
            </p>
          </div>
          <div class="col-12 d-flex justify-content-center align-items-center user-name">
            <img
              src="../../../../images/sample.png"
              class="user-icon"
            >
            <h4 class="float-right mb-0 pl-2 word-break">
              Ito Manabu
            </h4>
            <div class="text-center pl-4">
              <font-awesome-icon
                :icon="['far', 'thumbs-up']"
                class="fa-lg"
              />
              <p class="m-0 word-break">
                100
              </p>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  name: 'SearchColumn',
}
</script>

<style scoped>
.word-break {
  word-break: break-word;
}

.sidebar_fixed {
  position: sticky;
  top: 60px;
}

.search {
  border: solid #CBCBCB;
  border-radius: 6px;
}

.article-title {
  background-color: #6A6A6A;
  border: solid thin #6A6A6A;
  border-radius: 6px;
}

.user-name {
  display: inline-block;
  vertical-align: middle;
}

.user-icon {
  width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 50%;
}

.description-label {
  background-color: #6A6A6A;
  border-radius: 6px 6px 0px 0px / 6px 6px 0px 0px;
}

.description-main {
  font-size: 14px;
  border: solid thin #6A6A6A;
  border-radius: 0px 0px 6px 6px / 0px 0px 6px 6px;
  border-width: 0px 0.1px 0.1px 0.1px;
}

.article-info {
  font-size: 13px;
}
</style>
