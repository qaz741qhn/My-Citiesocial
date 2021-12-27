import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "quantity", "sku", "addToCartButton" ];

  quantity_minus(event) {
    event.preventDefault();
    let q = Number(this.quantityTarget.value);
    if (q > 1) {
      this.quantityTarget.value = q - 1;
    }
  }

  quantity_plus(event) {
    event.preventDefault();
    let q = Number(this.quantityTarget.value);
    this.quantityTarget.value = q + 1;
  }

  add_to_cart(event) {
    event.preventDefault();

    let product_id = this.data.get("id");
    let quantity = this.quantityTarget.value;
    let sku = this.skuTarget.value;

    // 幫class加上內容用classList
    if (quantity > 0) {
      this.addToCartButtonTarget.classList.add("is-loading");
      // 打api
      let data = new FormData();
      data.append("id", product_id);
      data.append("quantity", quantity);
      data.append("sku", sku);

      Rails.ajax({
        url: "/api/v1/cart",
        data,
        type: "POST",
        success: response => {
          console.log(response);
        },
        error: err => {
          console.log(err);
        }
      });
    }

  }
}