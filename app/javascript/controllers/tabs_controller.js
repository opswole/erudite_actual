import { Controller } from "@hotwired/stimulus"

const TAB_ACTIVE_CLASS = "tab-active"

export default class extends Controller {
    static targets = ["tab"]

    connect() {
        this.validateAndInitialize()
    }

    activate(event) {
        this.deactivateAllTabs()
        event.currentTarget.classList.add(TAB_ACTIVE_CLASS)
    }

    // Private methods
    validateAndInitialize() {
        if (!this.hasTabTargets) {
            return
        }

        this.ensureActiveTab()
    }

    deactivateAllTabs() {
        this.tabTargets.forEach(tab => tab.classList.remove(TAB_ACTIVE_CLASS))
    }

    ensureActiveTab() {
        const hasActiveTab = this.tabTargets.some(tab =>
            tab.classList.contains(TAB_ACTIVE_CLASS)
        )

        if (!hasActiveTab) {
            this.tabTargets[0].classList.add(TAB_ACTIVE_CLASS)
        }
    }
}