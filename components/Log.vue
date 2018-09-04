<template>
  <pre>
    {{ log }}
  </pre>
</template>
<script>
  import axios from 'axios'
  import readline from 'linebyline'

  export default {
    data() {
      return {
        log: []
      }
    },
    created() {
      axios({
        method: 'get',
        url: 'http://localhost:8080/logs/eb3334e6-ae9b-11e8-9bf0-4e16a2762ee3',
        responseType: 'stream'
      }).then((response) => {
        readline(response.data)
          .on('line', (input) => console.log(input))
          .on('close', () => console.log('completed'))
      })
    }
  }
</script>
