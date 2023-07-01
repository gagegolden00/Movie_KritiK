import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets =["modal"]
  connect() {
    console.log("Connected to modal controller")

  }

  removeModal(event) {
    console.log("removeModal function triggered ")
    event.preventDefault();
    this.element.closest("div").remove();
  }
}
