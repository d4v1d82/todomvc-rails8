import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    url: String,
  };

  render(event) {
    const frame = this.element.closest("turbo-frame");
    frame.src = this.urlValue;
    frame.reload();
  }
}
