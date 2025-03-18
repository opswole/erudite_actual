// Stimulus & Turbo imports
import '~/entrypoints/application.css';
import "@hotwired/turbo-rails";
import '../controllers';

// Vue imports
import { createApp } from "vue";
import { registerLicense } from "@syncfusion/ej2-base";
import App from "../components/App.vue";

// Syncfusion license
// TODO: Make this work in prod
const licenseKey = import.meta.env.VITE_SYNCFUSION_KEY;
registerLicense(licenseKey);


function mountVueApp() {
    const el = document.querySelector("#app");
    if (el) {
        if (!el.__vue_app__) {
            createApp(App).mount("#app");
        }
    }
}

function unmountVueApp() {
    const el = document.querySelector("#app");
    if (el && el.__vue_app__) {
        el.__vue_app__.unmount();
    }
}

// Initial load
document.addEventListener('DOMContentLoaded', () => {
    mountVueApp();
});

// Load on turbo-frame
document.addEventListener('turbo:frame-load', (event) => {
    if (event.target.id === 'tab_content' || event.target.id === 'topic_content') {
        mountVueApp();
    }
});

document.addEventListener('turbo:before-frame-render', (event) => {
    if (event.target.id === 'tab_content' || event.target.id === 'topic_content') {
        unmountVueApp();
    }
});