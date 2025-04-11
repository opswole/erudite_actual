<template>
  <div class="pdf-viewer-container border-2 text-center p-8">
    <div class="pdf-controls mb-4">
      <button
          class="btn btn-primary mr-2"
          @click="page = Math.max(1, page - 1)"
          :disabled="page <= 1"
      >
        Prev
      </button>
      <span class="mx-4">{{ page }} / {{ totalPages }}</span>
      <button
          class="btn btn-primary"
          @click="page = Math.min(totalPages, page + 1)"
          :disabled="page >= totalPages"
      >
        Next
      </button>
    </div>

    <VuePDF
        :pdf="pdf"
        :page="page"
        class="pdf-display"
        v-if="pdf"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { VuePDF, usePDF } from '@tato30/vue-pdf'

const pdfContainer = document.getElementById('pdf-container')
const pdfUrl = pdfContainer.getAttribute('data-pdf-url')

const page = ref(1)
const { pdf, pages: totalPages } = usePDF(pdfUrl)
console.log(`PDF URL ${pdfUrl}`)
</script>

<style scoped>
.pdf-display {
  width: 100%;
}
</style>