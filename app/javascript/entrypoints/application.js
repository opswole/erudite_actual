import '~/entrypoints/application.css';
import "@hotwired/turbo-rails";
import '@rails/actiontext';
import 'trix';
import '../controllers';
import { createApp } from 'vue';
import PdfViewer from '~/components/PdfViewer.vue';
import Calendar from '~/components/Calendar.vue';
import vuetify from "~/components/vuetify.js";


let app = null;


function mountCalendar() {
    if (app) {
        console.log("unmounted");
        app.unmount();
        app = null;
    }

    const el = document.getElementById('calendar-container');
    if (el) {
        app = createApp(Calendar);
        app.use(vuetify);
        app.mount(el);
        console.log('Calendar mounted');
    }
}

function mountPdfViewer() {
    const el = document.getElementById('pdf-container');

    if (!el) {
        console.log('No PDF container found');
        return;
    }

    if (app) {
        console.log('Unmounted existing app');
        app.unmount();
    }

    app = createApp(PdfViewer);
    app.mount(el);
    console.log('PDF Viewer mounted');
}

function mountComponents(){
    mountPdfViewer();
    mountCalendar()
}

document.addEventListener('turbo:load', mountComponents);
document.addEventListener('turbo:frame-render', mountComponents);
// document.addEventListener('turbo:frame-load', mountComponents);

document.addEventListener('turbo:before-frame-render', () => {
    if (app) {
        app.unmount();
        app = null;
    }
});