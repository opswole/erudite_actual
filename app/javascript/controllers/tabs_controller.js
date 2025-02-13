import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["tab", "content"]

    change(event) {
        event.preventDefault()

        // Get the selected tab ID
        const selectedTabId = event.currentTarget.dataset.tabsIdParam

        // Remove 'tab-active' from all tabs
        this.tabTargets.forEach(tab => {
            tab.classList.remove("tab-active")
        })

        // Hide all content sections
        this.contentTargets.forEach(content => {
            content.classList.add("hidden")
        })

        // Activate the selected tab
        event.currentTarget.classList.add("tab-active")

        console.log("change")

        // Show the corresponding content
        this.contentTargets.find(content => content.dataset.tabsIdParam === selectedTabId)
            ?.classList.remove("hidden")
    }
}
