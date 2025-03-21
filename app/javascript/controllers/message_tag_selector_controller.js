import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["userList", "taggedUsers", "hiddenInput"]

    connect() {
        this.selectedIds = new Set()
        this.updateTaggedUsers()
    }

    toggleUser(event) {
        const userId = event.currentTarget.dataset.userId
        const userName = event.currentTarget.dataset.userName

        if (this.selectedIds.has(userId)) {
            this.selectedIds.delete(userId)
        } else {
            this.selectedIds.add(userId)
        }

        this.updateTaggedUsers()
        this.updateHiddenInputs()
    }

    removeUser(event) {
        const userId = event.currentTarget.dataset.userId
        this.selectedIds.delete(userId)
        this.updateTaggedUsers()
        this.updateHiddenInputs()
    }

    updateTaggedUsers() {
        this.taggedUsersTarget.innerHTML = ""
        this.selectedIds.forEach(userId => {
            const userName = this.element.querySelector(`[data-user-id="${userId}"]`)?.dataset.userName
            if (userName) {
                const badge = document.createElement("span")
                badge.classList.add("badge", "badge-primary", "badge-sm", "cursor-pointer")
                badge.dataset.userId = userId
                badge.dataset.action = "click->message-tag-selector#removeUser"
                badge.textContent = userName
                this.taggedUsersTarget.appendChild(badge)
            }
        })
    }

    updateHiddenInputs() {
        // Clear existing hidden inputs
        this.hiddenInputTarget.parentElement.querySelectorAll('input[name="message[tagged_user_ids][]"]').forEach(input => input.remove())

        // Create a hidden input for each selected ID
        this.selectedIds.forEach(userId => {
            const input = document.createElement("input")
            input.type = "hidden"
            input.name = "message[tagged_user_ids][]"
            input.value = userId
            this.hiddenInputTarget.parentElement.appendChild(input)
        })
    }
}