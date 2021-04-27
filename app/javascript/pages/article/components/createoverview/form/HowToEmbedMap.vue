<template>
  <div>
    <template v-if="$mq == 'xs'">
      <modal
        name="how-to-embed-map"
        :scrollable="true"
        width="90%"
        :max-height="300"
        height="auto"
        class="modal-box-xs text-center text-dark"
      >
        <div class="modal-header">
          <p class="m-0 font-weight-bold w-100">
            旅行記録に「Google My Maps」を埋め込む方法
          </p>
        </div>
        <div class="modal-body">
          <p class="m-0 font-small">
            ①「Google My Maps」の
            <a
              href="https://www.google.com/maps/d/u/0/?hl=ja"
              target="_blank"
            >
              マイマップ一覧ページ
            </a>
            にアクセスしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map.jpg')"
            class="map-image"
          >

          <p class="mt-5 m-0 font-small">
            ②埋め込みたいマップをクリックしてマイマップ編集ページにアクセスしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map2.jpg')"
            class="map-image"
          >

          <p class="mt-5 m-0 font-small">
            ③編集ページのメニューボタンから「自分のサイトに埋め込む」をクリックしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map3.jpg')"
            class="map-image"
          >

          <p class="mt-5 m-0 font-small">
            ④表示されたHTMLをコピーしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map4.jpg')"
            class="map-image"
          >

          <template v-if="this.$route.path == '/create_trip_note'">
            <p class="mt-5 m-0 font-small">
              ⑤旅行概要作成フォームの「マップ」にコピーしたHTMLを貼り付け、旅行記録を作成・投稿してください。
            </p>
            <img
              :src="require('../../../../../../assets/images/map5.jpg')"
              class="map-image"
            >
          </template>
          <template v-else>
            <p class="mt-5 m-0 font-small">
              ⑤旅行概要編集フォームの「マップ」にコピーしたHTMLを貼り付け、旅行記録を投稿してください。
            </p>
            <img
              :src="require('../../../../../../assets/images/map7.jpg')"
              class="map-image"
            >
          </template>

          <p class="mt-5 m-0 font-small">
            ⑥作成された旅行記録にマイマップが埋め込まれます。
          </p>
          <img
            :src="require('../../../../../../assets/images/map6.jpg')"
            class="map-image"
          >

          <p class="mt-4 m-0 font-small">
            ※本サービスで「Google My Maps」自体の作成や編集をすることはできません。
          </p>

          <div
            class="mt-4 mb-4 text-center button"
            @click="hideModal"
          >
            閉じる
          </div>
        </div>
      </modal>
    </template>

    <template v-else>
      <modal
        name="how-to-embed-map"
        :scrollable="true"
        :max-height="300"
        height="auto"
        class="modal-box text-center text-dark"
      >
        <div class="modal-header">
          <h4 class="m-0 w-100">
            旅行記録に「Google My Maps」を埋め込む方法
          </h4>
        </div>
        <div class="modal-body">
          <p class="m-0">
            ①「Google My Maps」の
            <a
              href="https://www.google.com/maps/d/u/0/?hl=ja"
              target="_blank"
            >
              マイマップ一覧ページ
            </a>
            にアクセスしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map.jpg')"
            class="map-image"
          >

          <p class="mt-5 m-0">
            ②埋め込みたいマップをクリックしてマイマップ編集ページに<br>アクセスしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map2.jpg')"
            class="map-image"
          >

          <p class="mt-5 m-0">
            ③編集ページのメニューボタンから「自分のサイトに埋め込む」を<br>クリックしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map3.jpg')"
            class="map-image"
          >

          <p class="mt-5 m-0">
            ④表示されたHTMLをコピーしてください。
          </p>
          <img
            :src="require('../../../../../../assets/images/map4.jpg')"
            class="map-image"
          >

          <template v-if="this.$route.path == '/create_trip_note'">
            <p class="mt-5 m-0">
              ⑤旅行概要作成フォームの「マップ」にコピーしたHTMLを貼り付け、<br>旅行記録を作成・投稿してください。
            </p>
            <img
              :src="require('../../../../../../assets/images/map5.jpg')"
              class="map-image"
            >
          </template>
          <template v-else>
            <p class="mt-5 m-0">
              ⑤旅行概要編集フォームの「マップ」にコピーしたHTMLを貼り付け、<br>旅行記録を投稿してください。
            </p>
            <img
              :src="require('../../../../../../assets/images/map7.jpg')"
              class="map-image"
            >
          </template>

          <p class="mt-5 m-0">
            ⑥作成された旅行記録にマイマップが埋め込まれます。
          </p>
          <img
            :src="require('../../../../../../assets/images/map6.jpg')"
            class="map-image"
          >

          <p class="mt-4 m-0">
            ※本サービスで「Google My Maps」自体の作成や編集を<br>することはできません。
          </p>

          <div
            class="mt-4 mb-4 text-center button"
            @click="hideModal"
          >
            閉じる
          </div>
        </div>
      </modal>
    </template>
  </div>
</template>

<script>
export default {
  name: 'HowToEmbedMap',
  methods: {
    showModal() {
      this.$modal.show('how-to-embed-map')
    },
    hideModal() {
      this.$modal.hide('how-to-embed-map')
    },
  }
}
</script>

<style scoped>
p {
  width: 100%;
}

.modal-box {
  padding: 80px 0px;
}

.modal-box-xs {
  padding-top: 60px;
  padding-bottom: 205px;
}

.map-image {
  width: 100%;
  border: solid #CBCBCB;
  border-radius: 6px;
}

.font-small {
  font-size: 15px;
}

.button {
  display: inline-block;
  background-color: #A5A5A5;
  padding: 6px 20px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  border-radius: 4px;
}

.button:hover {
  background-color: #6A6A6A;
  position: relative;
}
</style>
