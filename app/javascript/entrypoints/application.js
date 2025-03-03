import '~/entrypoints/application.css'
import "@hotwired/turbo-rails"
import '../controllers'

// Create Vue App
import { createApp } from "vue";
import { registerLicense } from "@syncfusion/ej2-base"

const licenseKey = import.meta.env.VITE_SYNCFUSION_KEY;

registerLicense(licenseKey)

// Import App Component
import App from "../components/App.vue";

// Create Vue App
const app = createApp(App).mount("#app");