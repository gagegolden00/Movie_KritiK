import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-dropdown"
export default class extends Controller {
  static targets = ["genreContent", "yearContent", "ratingContent", "scoreContent"];

  connect() {
    console.log("Connected to filtering dropdown controller");
    this.genreContentTarget.classList.add("hidden");
    this.yearContentTarget.classList.add("hidden");
    this.ratingContentTarget.classList.add("hidden");
    this.scoreContentTarget.classList.add("hidden");
  }

  toggleGenre() {
    console.log("toggle genre menu");
    this.closeAllContentTargetsExcept(this.genreContentTarget);
  }

  toggleYear() {
    console.log("toggle year menu");
    this.closeAllContentTargetsExcept(this.yearContentTarget);
  }

  toggleRating() {
    console.log("toggle rating menu");
    this.closeAllContentTargetsExcept(this.ratingContentTarget);
  }

  toggleScore() {
    console.log("toggle score menu");
    this.closeAllContentTargetsExcept(this.scoreContentTarget);
  }

  closeAllContentTargetsExcept(targetToOpen) {
    const allContentTargets = [
      this.genreContentTarget,
      this.yearContentTarget,
      this.ratingContentTarget,
      this.scoreContentTarget
    ];

    allContentTargets.forEach((target) => {
      if (target !== targetToOpen) {
        target.classList.add("hidden");
      }
    });

    targetToOpen.classList.toggle("hidden");
  }
}
