<template>
  <section class="container">
    <div>
      <h1 class="title">
        duci
      </h1>
      <h4>
        {{ $route.params.id }}
      </h4>
      <log :log-id="$route.params.id" />
    </div>
  </section>
</template>

<script>
import Log from "~/components/Log.vue";

export default {
  components: {
    Log
  }
};
</script>

<style>
.container {
  width: auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.container > div {
  width: 100%;
}

.title {
  font-family: "Quicksand", "Source Sans Pro", -apple-system, BlinkMacSystemFont,
    "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; /* 1 */
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
