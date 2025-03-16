import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["messages", "textArea"];

    connect() {
        // console.log("Message controller connected");

        this.setScrollPosition();

        if (this.hasMessagesTarget) {
            this.messagesTarget.addEventListener("DOMNodeInserted", () => this.setScrollPosition());
        }
    }

    setScrollPosition() {
        if (this.hasMessagesTarget) {
            this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight - this.messagesTarget.clientHeight;
        }
    }

    submitForm(event) {
        console.log(event)
        if (event.key === "Enter" && !event.shiftKey) {
            event.preventDefault();
            const form = event.target.closest("form");
            if (form) {
                form.requestSubmit();
                form.reset();
            }
        }
    }
}

document.addEventListener("turbo:frame-load", (event) => {
    // console.log("Turbo Frame Loaded:", event.target);
    setTimeout(() => {
        const application = window.Stimulus;
        if (application) {
            application.start();
        }
    }, 10);
});
