<template>
  <div>
    <div
      class="modal p-3 d-flex justify-content-center align-items-center flex-column"
      @click.self="closeImage"
    >
      <div class="mt-2 text-right mx-auto icon-width">
        <button
          class="btn p-1 d-inline button"
          @click="closeImage"
        >
          <font-awesome-icon
            :icon="['far', 'times-circle']"
            class="fa-lg"
          />
        </button>
      </div>

      <img
        :src="image"
        class="mb-5 image"
      >
    </div>
    <div class="modal-backdrop show" />
  </div>
</template>

<script>
export default {
  name: 'ImageModal',
  props: {
    image: {
      type: String,
      default: null,
      required: false
    }
  },
  methods: {
    closeImage() {
      this.$emit('closeImage')
    },
  }
}
</script>

<style scoped>
.modal {
  display: block;
}

.image {
  width:auto;
  height:auto;
  max-width: 90%;
  max-height: 90%;
  border-radius: 10px;
}

.icon-width {
  width: 90%;
}

.button {
  color: white;
  font-size: 20px;
}

.button:hover {
  color: black;
  font-size: 20px;
}
</style>
