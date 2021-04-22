<template>
  <div class="col-12 mt-1 p-0 text-center font-xs-small">
    <router-link :to="{ name: 'TermOfUse' }">
      <a
        href="#"
        id="term-of-use"
        class="mr-1 ml-1 m-0 p-0 text-muted d-inline-block"
      >
        利用規約
      </a>
    </router-link>
    <router-link :to="{ name: 'PrivacyPolicy' }">
      <a
        href="#"
        id="privacy-policy"
        class="mr-1 ml-1 m-0 p-0 text-muted d-inline-block"
      >
        プライバシーポリシー
      </a>
    </router-link>
    <a
      href="https://docs.google.com/forms/d/e/1FAIpQLSff4mAzKQAal88lGp0Pl9sJTcfgsterdaB7d9CUupKOxyEhpA/viewform?usp=sf_link"
      target="_blank"
      id="contact"
      class="mr-1 ml-1 p-0 text-muted d-inline-block"
    >
      お問い合わせ
    </a>
    <p class="mr-1 ml-1 m-0 p-0 text-muted d-inline-block">
      ©️2021 TriSto
    </p>
  </div>
</template>

<script>
export default {
  name: 'TermAndPolicyLink',
}
</script>

<style scoped>
.font-xs-small {
  font-size: 12px;
}
</style>
