import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["notifications"]

    connect() {
        this.modal = this.element
    }

    open() {
        if (!this.modal.open) {
            this.modal.showModal()
        }
    }

    close(event) {
        this.modal.close()

        if (event.target.closest('[data-modal-target="mention-link"]')) {
            this.dispatch("mentionClicked", { detail: { message: "Mention link was clicked!" } })
        }
    }
}