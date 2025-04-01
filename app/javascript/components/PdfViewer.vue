<template>
  <div>
    <ejs-pdfviewer
        id="pdfViewer"
        :resourceUrl="resourceUrl"
        :documentPath="documentPath">
    </ejs-pdfviewer>
  </div>
</template>

<script>
import { PdfViewerComponent, Toolbar, Magnification, Navigation, LinkAnnotation,
  BookmarkView, ThumbnailView, Print, TextSelection, TextSearch,
  Annotation, PageOrganizer } from '@syncfusion/ej2-vue-pdfviewer';

export default {
  name: "PdfViewer",
  components: {
    "ejs-pdfviewer": PdfViewerComponent
  },
  props: {
    documentUrl: {
      type: String,
      default: 'https://cdn.syncfusion.com/content/pdf/pdf-succinctly.pdf'
    }
  },
  data() {
    return {
      resourceUrl: 'https://cdn.syncfusion.com/ej2/26.2.11/dist/ej2-pdfviewer-lib',
      documentPath: this.documentUrl
    };
  },
  provide: {
    PdfViewer: [Toolbar, Magnification, Navigation, LinkAnnotation, BookmarkView, ThumbnailView,
      Print, TextSelection, TextSearch, Annotation, PageOrganizer]
  }
};
</script>

<style>
@import '@syncfusion/ej2-base/styles/material.css';
@import '@syncfusion/ej2-buttons/styles/material.css';
@import '@syncfusion/ej2-dropdowns/styles/material.css';
@import '@syncfusion/ej2-inputs/styles/material.css';
@import '@syncfusion/ej2-navigations/styles/material.css';
@import '@syncfusion/ej2-popups/styles/material.css';
@import '@syncfusion/ej2-splitbuttons/styles/material.css';
@import '@syncfusion/ej2-lists/styles/material.css';
@import '@syncfusion/ej2-pdfviewer/styles/material.css';
</style>