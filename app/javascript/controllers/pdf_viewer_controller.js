// import {Controller} from "@hotwired/stimulus"
// import * as pdfjsLib from "pdfjs-dist";
// import pdfWorker from "pdfjs-dist/build/pdf.worker.min.mjs?worker"; // Import as a worker
//
//
// export default class extends Controller {
//     static targets = ["canvas", "pageNum"]
//     static values = { url: String }
//
//     currentPage = 1
//     pdf = null
//
//     connect() {
//         const workerBlob = new Blob([pdfWorker], { type: "application/javascript" });
//         pdfjsLib.GlobalWorkerOptions.workerSrc = URL.createObjectURL(workerBlob);
//     }
//
//     async loadPdf() {
//         const loadingTask = pdfjsLib.getDocument(this.urlValue)
//         this.pdf = await loadingTask.promise
//         this.pageNumTarget.value = this.currentPage
//         await this.renderPage()
//         console.log()
//     }
//
//     async renderPage() {
//         const page = await this.pdf.getPage(this.currentPage)
//         const viewport = page.getViewport({ scale: 1.75 })
//         const canvas = this.canvasTarget
//         canvas.width = viewport.width
//         canvas.height = viewport.height
//
//         const context = canvas.getContext("2d")
//         const renderContext = {
//             canvasContext: context,
//             viewport: viewport
//         }
//         await page.render(renderContext)
//     }
//
//     async prevPage() {
//         if (this.currentPage > 1) {
//             this.currentPage -= 1
//             await this.renderPage()
//             this.pageNumberTarget.value = this.currentPage
//         }
//     }
//
//     async nextPage() {
//         if (this.currentPage < this.pdf.numPages) {
//             this.currentPage += 1
//             await this.renderPage()
//             this.pageNumberTarget.value = this.currentPage
//         }
//     }
//
//     async changePage() {
//         let requestedPage = Number(this.pageNumberTarget.value)
//         if (requestedPage > 0 && requestedPage <= this.pdf.numPages) {
//             this.currentPage = requestedPage
//             await this.renderPage()
//         } else {
//             alert(`Invalid page number (Max: ${this.pdf.numPages})`)
//             this.pageNumberTarget.value = this.currentPage
//         }
//     }
// }