import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clearform"
export default class extends Controller {
  connect() {
    console.log("Connect to clearform controller")
    const largeForm = document.getElementById("large-search-form");
    const smallForm = document.getElementById("small-search-form");
    largeForm.reset();
    smallForm.reset();
  }

  clearForm(event) {
    event.preventDefault();
    const form = event.target.closest("form");
    form.reset();
  }
}
