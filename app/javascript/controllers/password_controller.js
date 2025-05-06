import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
    static targets = ["password", "confirmation", "error"];

    connect() {

    }

    validate(event) {
        const password = this.passwordTarget.value;
        const confirmation = this.confirmationTarget.value;

        if (password === "" && confirmation === "") {
            this.hideError();
        } else if (password !== confirmation) {
            event.preventDefault();
            this.showError();
        } else {
            this.hideError();
        }
    }

    showError() {
        this.errorTarget.classList.remove("hidden");
        this.confirmationTarget.classList.add("input-error");
    }

    hideError() {
        this.errorTarget.classList.add("hidden");
        this.confirmationTarget.classList.remove("input-error");
    }
}