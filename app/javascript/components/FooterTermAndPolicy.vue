<template>
  <div
    class="mt-5 pt-3 pb-3 w-100 bg-white text-center footer"
  >
    <template v-if="$mq == 'xs'">
      <router-link :to="{ name: 'TermOfUse' }">
        <a
          href="#"
          class="ml-1 mr-1 p-0 d-inline-block text-muted text-center font-small"
        >
          利用規約
        </a>
      </router-link>

      <router-link :to="{ name: 'PrivacyPolicy' }">
        <a
          href="#"
          class="ml-1 mr-1 p-0 d-inline-block text-muted text-center font-small"
        >
          プライバシーポリシー
        </a>
      </router-link>

      <a
        href="https://docs.google.com/forms/d/e/1FAIpQLSff4mAzKQAal88lGp0Pl9sJTcfgsterdaB7d9CUupKOxyEhpA/viewform?usp=sf_link"
        target="_blank"
        class="ml-1 mr-1 p-0 d-inline-block text-muted text-center font-small"
      >
        お問い合わせ
      </a>

      <p class="ml-1 mr-1 mb-0 p-0 d-inline-block text-muted text-center font-small">
        ©️2021 TriSto
      </p>
    </template>

    <template v-else>
      <router-link :to="{ name: 'TermOfUse' }">
        <a
          id="term-of-use"
          href="#"
          class="mr-2 p-0 d-inline-block text-muted"
        >
          利用規約
        </a>
      </router-link>

      <router-link :to="{ name: 'PrivacyPolicy' }">
        <a
          id="privacy-policy"
          href="#"
          class="mr-2 ml-2 p-0 d-inline-block text-muted"
        >
          プライバシーポリシー
        </a>
      </router-link>

      <a
        id="contact"
        href="https://docs.google.com/forms/d/e/1FAIpQLSff4mAzKQAal88lGp0Pl9sJTcfgsterdaB7d9CUupKOxyEhpA/viewform?usp=sf_link"
        target="_blank"
        class="mr-2 ml-2 p-0 d-inline-block text-muted"
      >
        お問い合わせ
      </a>

      <p class="ml-2 mb-0 p-0 d-inline-block text-muted">
        ©️2021 TriSto
      </p>
    </template>
  </div>
</template>

<script>
export default {
  name: 'TermAndPolicy',
}
</script>

<style scoped>
.footer {
  border-top: solid thin #CBCBCB;
}

.font-small {
  font-size: 12px;
}
</style>
