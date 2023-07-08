import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menuContent"];


  connect() {
    console.log("connected to menu controller");
    this.menuContentTarget.classList.toggle("hidden");
  }

  toggleMenu() {
    console.log("toggle menu");
    this.menuContentTarget.classList.toggle("hidden");
  }
}

