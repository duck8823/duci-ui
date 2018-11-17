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
            <sui-label v-if="logLine.elapsed" circular size="tiny">
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
import oboe from "oboe";
import moment from "moment";
import url from "url";

export default {
  props: {
    logId: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      log: [],
      loading: true
    };
  },
  created() {
    let logsUrl = this.$env.DUCI_LOGS_URL || "http://localhost:8080/logs/";
    let job;
    oboe(`${url.resolve(logsUrl, this.logId)}`)
      .node("{time message}", logLine => {
        if (job) {
          let m = moment(logLine.time);
          let t = moment(job.time);
          let e =
            m.unix() * 1000 +
            m.milliseconds() -
            (t.unix() * 1000 + t.milliseconds());
          this.log.push({
            time: t.format("YYYY-MM-DD HH:mm:ss.SSS"),
            message: job.message,
            elapsed: e / 1000
          });
        }

        job = logLine;
      })
      .fail(err => {
        this.loading = false;
        console.error(err);
      })
      .on("end", () => {
        this.loading = false;
        if (!job) {
          return;
        }

        this.log.push({
          time: moment(job.time).format("YYYY-MM-DD HH:mm:ss.SSS"),
          message: job.message
        });
      });
  },
  updated() {
    let doc = document.documentElement;
    let point = doc.scrollHeight - doc.clientHeight;
    window.scroll(0, point);
  }
};
</script>
