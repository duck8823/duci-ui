<template>
  <div>
    <p v-for='(line, index) in log' :key="index">{{ line }}</p>
  </div>
</template>
<script>
  import oboe from 'oboe'

  export default {
    data() {
      return {
        log: []
      }
    },
    created() {
      oboe('http://localhost:8080/logs/eb3334e6-ae9b-11e8-9bf0-4e16a2762ee3')
        .done((things) => {
          console.log(things.message)
          this.log.push(things.message)
        })
    }
  }
</script>
