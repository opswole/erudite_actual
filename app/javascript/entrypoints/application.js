import '~/entrypoints/application.css'
import "@hotwired/turbo-rails"
import '../controllers'

// Create Vue App
import { createApp } from "vue";

// Import App Component
import App from "../components/App.vue";

// Create Vue App
const app = createApp(App).mount("#app");