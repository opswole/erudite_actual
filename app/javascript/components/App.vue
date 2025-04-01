<template>
  <div>
    <PdfViewer v-if="showPdf" />
    <Scheduler v-if="showScheduler" />
  </div>
</template>

<script>
import PdfViewer from "./PdfViewer.vue";
import Scheduler from "./Scheduler.vue";

export default {
  name: "App",
  components: {
    PdfViewer,
    Scheduler: Scheduler
  },
  data() {
    return {
      showPdf: true,
      showScheduler: true
    };
  }
};
</script>
