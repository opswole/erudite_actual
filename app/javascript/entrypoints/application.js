import '~/entrypoints/application.css';
import "@hotwired/turbo-rails";
import '@rails/actiontext';
import 'trix';
import '../controllers';
import { createApp } from 'vue';
import PdfViewer from '~/components/PdfViewer.vue';

let app = null;

function mountPdfViewer() {
    if (app) {
        app.unmount();
    }

    const el = document.getElementById('pdf-container');
    if (el) {
        app = createApp(PdfViewer);
        app.mount(el);
        console.log('PDF Viewer mounted');
    }
}

// document.addEventListener('DOMContentLoaded', mountPdfViewer);


document.addEventListener('turbo:load', mountPdfViewer);
document.addEventListener('turbo:frame-render', mountPdfViewer);
document.addEventListener('turbo:frame-load', mountPdfViewer);

document.addEventListener('turbo:before-frame-render', () => {
    if (app) {
        app.unmount();
        app = null;
    }
});