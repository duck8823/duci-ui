<style>
  div.log {
    padding-bottom: 2rem;
  }
  table td {
    font-family: monospace;
  }
</style>
<template>
  <div class="log">
    <sui-table unstackable celled compact inverted>
      <sui-table-body>
        <sui-table-row v-for="(logLine, index) in log" :key="index">
          <sui-table-cell>
            {{ index + 1 }}
          </sui-table-cell>
          <sui-table-cell>
            {{ logLine.time }}
          </sui-table-cell>
          <sui-table-cell>
            {{ logLine.message }}
          </sui-table-cell>
        </sui-table-row>
      </sui-table-body>
    </sui-table>
  </div>
</template>
<script>
  import oboe from 'oboe'
  import moment from 'moment'

  export default {
    data() {
      return {
        log: []
      }
    },
    created() {
      oboe('http://localhost:8080/logs/eb3334e6-ae9b-11e8-9bf0-4e16a2762ee3')
        .done((logLine) => {
          this.log.push({
            time: moment(logLine.time).format('YYYY-MM-DD HH:mm:ss.SSS'),
            message: logLine.message
          })
        })
    },
    updated() {
      let doc = document.documentElement;
      let point = doc.scrollHeight - doc.clientHeight;
      window.scroll(0, point);
    }
  }
</script>
