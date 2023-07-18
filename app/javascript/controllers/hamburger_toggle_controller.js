import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menuContent"];

  connect() {
    this.menuContentTarget.classList.toggle("hidden");
  }

  toggleMenu() {
    console.log("toggle menu");
    this.menuContentTarget.classList.toggle("hidden");
  }

}

