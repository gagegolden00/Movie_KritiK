import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clearform"
export default class extends Controller {
  connect() {
    console.log("Connect to clearform controller")
    const form = document.getElementById("search-form");
    form.reset();
  }

  clearForm(event) {
    event.preventDefault();
    const form = event.target.closest("form");
    form.reset();
  }
}
