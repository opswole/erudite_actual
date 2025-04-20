import { Controller } from "@hotwired/stimulus"

const TAB_ACTIVE_CLASS = "tab-active"

export default class extends Controller {
    static targets = ["tab"]

    connect() {
        console.log("Connected")
        this.validateAndInitialize()

        this.setActiveTabFromUrl()

        document.addEventListener("turbo:load", this.setActiveTabFromUrl.bind(this))
    }

    disconnect() {
        document.removeEventListener("turbo:load", this.setActiveTabFromUrl.bind(this))
    }

    activate(event) {
        console.log(event)
        this.deactivateAllTabs()
        event.currentTarget.classList.add(TAB_ACTIVE_CLASS)
    }

    setActiveTabFromUrl() {
        const pathSegments = window.location.pathname.split('/')

        if (pathSegments.length >= 2) {
            const resourceName = pathSegments[2]

            const matchingTab = this.tabTargets.find(tab => {
                const tabId = tab.id.replace("_tab", "")
                return tabId === resourceName
            })

            if (matchingTab) {
                this.deactivateAllTabs()
                matchingTab.classList.add(TAB_ACTIVE_CLASS)
            }
        }
    }

    activateFromNav(event) {
        const url = event.currentTarget.href
        const tab = this.tabTargets.find(t => t.href === url)
        if (tab) {
            this.deactivateAllTabs()
            tab.classList.add(TAB_ACTIVE_CLASS)
        }
    }

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