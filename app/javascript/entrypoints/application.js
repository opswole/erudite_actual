import '~/entrypoints/application.css';
import "@hotwired/turbo-rails";
import '../controllers';

import { createApp } from "vue";
import { registerLicense } from "@syncfusion/ej2-base";
import PdfViewer from "../components/PdfViewer.vue";
import Scheduler from "../components/Scheduler.vue";

const licenseKey = import.meta.env.VITE_SYNCFUSION_KEY;

function ensureLicenseRegistered() {
    if (!licenseKey) {
        console.error("Syncfusion license key is missing! Check VITE_SYNCFUSION_KEY in your environment.");
        return;
    }

    try {
        registerLicense(licenseKey);
        console.log("Syncfusion license registered successfully.");
    } catch (error) {
        console.error("Failed to register Syncfusion license:", error);
    }
}

ensureLicenseRegistered();

function mountComponent(selector, component) {
    const el = document.querySelector(selector);
    if (el && !el.__vue_app__) {
        const app = createApp(component, el.dataset);
        app.mount(el);
        el.__vue_app__ = app;
        console.log(`Mounted ${selector}`);
    }
}

function unmountComponent(selector) {
    const el = document.querySelector(selector);
    if (el && el.__vue_app__) {
        el.__vue_app__.unmount();
        delete el.__vue_app__;
        console.log(`Unmounted ${selector}`);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    mountComponent("#pdf-viewer", PdfViewer);
    mountComponent("#scheduler", Scheduler);
});

document.addEventListener('turbo:frame-load', () => {
    ensureLicenseRegistered();
    mountComponent("#pdf-viewer", PdfViewer);
    mountComponent("#scheduler", Scheduler);
});

document.addEventListener('turbo:before-frame-render', () => {
    unmountComponent("#pdf-viewer");
    unmountComponent("#scheduler");
});

document.addEventListener('turbo:load', () => {
    ensureLicenseRegistered();
    mountComponent("#pdf-viewer", PdfViewer);
    mountComponent("#scheduler", Scheduler);
});