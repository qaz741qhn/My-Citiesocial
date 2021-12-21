import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["email"];

  add(event) {
    event.preventDefault();

    let email = this.emailTarget.value.trim();
    let data = new FormData();
    data.append("subscribe[email]", email);

    Rails.ajax({
      url: '/api/v1/subscribe',
      data: data,
      type: 'POST',
      dataType: 'json',
      //arrow scope，如直接使用function(){}會讓this.emailTarget的this變成在success本身找，運用arrow scope可讓範圍擴大到整個event
      success: (response) => {
        switch (response.status) {
          case 'ok':
            alert('完成訂閱！')
            this.emailTarget.value = ''
            break
          case 'duplicated':
            alert(`${response.email}已經訂閱過了！`)
            this.emailTarget.value = "";
            break
        }
      },
      error: function(err) {
        console.log(err)
      }
    });
  }
}