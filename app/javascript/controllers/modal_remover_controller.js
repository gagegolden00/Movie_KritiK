import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-remover"
export default class extends Controller {
  connect() {
    // SEE IF WERE CONNECTED TO THE CONTROLLER WITH THIS //
    console.log("Connected modal remover =)")
  }
  hideModal() {
    this.element.remove()
  }
}
