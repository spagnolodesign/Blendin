

function generateSubscriptionModal(){
  if (document.querySelectorAll(".confirm-button") !== null){
    var button =document.querySelectorAll(".confirm-button")
      button.forEach(function(element){
        element.addEventListener("click", function(){
          var body = document.querySelector("#modal-body")
          var link = "<span id = 'confirm'>" + I18n.t('events.index.subscribe_modal')+"<a class='btn btn-primary float-right' rel='nofollow' id='confirm' data-method='post' href=/events/" + element.dataset.value + "/participants>"+I18n.t('events.index.subscribe_button')+"</a>"
          body.insertAdjacentHTML('beforeend', link)
          closeModal = document.querySelector("#close-modal")
           closeModal.addEventListener("click", function(){
             if (document.querySelector("#confirm") !== null)
            {document.querySelector("#confirm").remove()}
          } )

        })
      })
  }
}

generateSubscriptionModal()
