import "@hotwired/turbo-rails"

import '../controllers'

document.addEventListener("turbo:frame-load", (event) => {
    console.log("Turbo Frame Loaded:", event.target);
});

