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
    <sui-table unstackable celled compact inverted selectable>
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
          <sui-table-cell>
            <sui-label circular size="tiny" v-if="logLine.elapsed">
              {{ logLine.elapsed }} sec
            </sui-label>
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
      let job
      oboe(`http://localhost:8080/logs/${this.logId}`)
        .node('{time message}', (logLine) => {
          if (job) {
            let m = moment(logLine.time)
            let t = moment(job.time)
            let e = (m.unix() * 1000 + m.milliseconds()) - (t.unix() * 1000 + t.milliseconds())
            this.log.push({
              time: t.format('YYYY-MM-DD HH:mm:ss.SSS'),
              message: job.message,
              elapsed: e / 1000
            })
          }

          job = logLine
        })
        .fail((err) => {
          console.error(err)
          this.loading = false
          this.error = err
        })
        .on('end', () => {
          this.log.push({
            time: moment(job.time).format('YYYY-MM-DD HH:mm:ss.SSS'),
            message: job.message
          })
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
