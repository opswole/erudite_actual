import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["display"]

    connect() {
        this.updateTime()

        this.intervalId = setInterval(() => {
            this.updateTime()
        }, 1000)
    }

    disconnect() {
        // Clear interval when controller disconnects to prevent memory leaks
        if (this.intervalId) {
            clearInterval(this.intervalId)
        }
    }

    updateTime() {
        const now = new Date()
        const hours = this.formatTimeComponent(now.getHours())
        const minutes = this.formatTimeComponent(now.getMinutes())
        const seconds = this.formatTimeComponent(now.getSeconds())

        this.displayTarget.textContent = `${hours}:${minutes}:${seconds}`
    }

    formatTimeComponent(component) {
        return component.toString().padStart(2, '0')
    }
}