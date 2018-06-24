

function generateUnsubscriptionModal(){
  if (document.querySelectorAll(".unsuscribe-button") !== null){
    var button = document.querySelectorAll(".unsuscribe-button")
      button.forEach(function(element){
        element.addEventListener("click", function(){
          var body = document.querySelector("#modal-body")
          var link = "<span id = 'confirm'>" + I18n.t('events.index.unsubscribe_modal') + "<a class='btn btn-primary mt-3' rel='nofollow' id='confirm' data-method='delete' href='/participants/" + element.dataset.value + "'>" + I18n.t('events.index.unsubscribe_button')+ "</a></span>"
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
