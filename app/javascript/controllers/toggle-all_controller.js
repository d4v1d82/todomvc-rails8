import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };

  //   connect() {
  //     console.debug("connect");
  //     this.toggleAll = this.toggleAll.bind(this);
  //     this.element.addEventListener("click", this.toggleAll);
  //   }

  //   disconnect() {
  //     console.debug("disconnect");
  //     this.element.removeEventListener("click", this.toggleAll);
  //   }

  toggleAll(event) {
    this.token = document.querySelector('meta[name="csrf-token"]').content;
    const checkAll = this.element.checked;

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "X-CSRF-Token": this.token,
        "Content-Type": "application/json",
        Accept: "text/vnd.turbo-stream.html",
      },
      credentials: "same-origin",
      body: JSON.stringify({
        check_all: checkAll,
      }),
    })
      .then((response) => response.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }
}
