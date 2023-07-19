import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-dropdown"
export default class extends Controller {
  static targets = ["genreContent", "yearContent", "ratingContent", "scoreContent"];

  connect() {
    console.log("Connected to filtering dropdown controller");
    this.genreContentTarget.classList.toggle("hidden");
    this.yearContentTarget.classList.toggle("hidden");
    this.ratingContentTarget.classList.toggle("hidden");
    this.scoreContentTarget.classList.toggle("hidden");

  }

  toggleGenre() {
    console.log("toggle menu");
    this.genreContentTarget.classList.toggle("hidden");
  }

  toggleYear() {
    console.log("toggle menu");
    this.yearContentTarget.classList.toggle("hidden");
  }

  toggleRating() {
    console.log("toggle menu");
    this.ratingContentTarget.classList.toggle("hidden");
  }
  toggleScore() {
    console.log("toggle menu");
    this.scoreContentTarget.classList.toggle("hidden");
  }
}
