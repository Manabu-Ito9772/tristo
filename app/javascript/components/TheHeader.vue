<template>
  <header>
    <nav class="navbar navbar-expand bg-white justify-content-between fixed-top">
      <span class="navbar-brand header-title">TriSto</span>
      <ul class="navbar-nav">
        <li class="nav-item active">
          <font-awesome-icon
            :icon="['fas', 'home']"
            class="fa-lg"
          />
        </li>
        <li class="nav-item active">
          <font-awesome-icon
            :icon="['fas', 'pen']"
            class="fa-lg"
          />
        </li>
        <li class="nav-item active">
          <font-awesome-icon
            :icon="['fas', 'user']"
            class="fa-lg"
          />
        </li>
        <li class="nav-item active">
          <font-awesome-icon
            :icon="['fas', 'bars']"
            class="fa-lg"
          />
        </li>
      </ul>
    </nav>
  </header>
</template>

<script>

</script>

<style scoped>
.navbar {
  height: 40px;
  border-bottom: solid 1px #CBCBCB;
}

.header-title {
  color: #FF00EB;
  font-size: 30px;
}

.nav-item {
  margin-left: 10px;
}
</style>
