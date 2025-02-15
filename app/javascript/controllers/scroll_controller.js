import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("Scroll Controller Connected");
  }

  scrollLeft() {
    this.containerTarget.scrollBy({ left: -200, behavior: "smooth" });
  }

  scrollRight() {
    this.containerTarget.scrollBy({ left: 200, behavior: "smooth" });
  }
}
