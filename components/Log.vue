<style>
  table td { font-family: monospace; }
</style>
<template>
  <sui-table selectable celled inverted>
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
    }
  }
</script>
