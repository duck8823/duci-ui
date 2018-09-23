<style>
  div.log {
    padding: 0 3rem 2rem 3rem;
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
            <pre>{{ logLine.message }}</pre>
          </sui-table-cell>
        </sui-table-row>
        <sui-table-row v-if="loading">
          <sui-table-cell colspan="3" text-align="center">
            <sui-icon name="notched circle" loading />
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
    props:  ["logId"],
    data() {
      return {
        log: [],
        loading: true
      }
    },
    created() {
      oboe(`http://localhost:8080/logs/${this.logId}`)
        .node('{time message}', (logLine) => {
          this.log.push({
            time: moment(logLine.time).format('YYYY-MM-DD HH:mm:ss.SSS'),
            message: logLine.message
          })
        })
        .fail((err) => {
          console.error(err)
        })
        .on('end', () => {
          this.loading = false
        })
    },
    updated() {
      let doc = document.documentElement;
      let point = doc.scrollHeight - doc.clientHeight;
      window.scroll(0, point);
    }
  }
</script>
