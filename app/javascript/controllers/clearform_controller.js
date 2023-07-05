import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clearform"
export default class extends Controller {
  connect() {
    console.log("Connect to clearform controller")
  }

  clearForm(event) {
    event.preventDefault();
    const form = event.target.closest("form");
    form.reset();
  }
}
