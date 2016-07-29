$(document).on('turbolinks:load', function() {
  init();
});

  var grid;
  
  function init() {
  	if ($('.cards').length != 1) return;
    grid = new Minigrid({
      container: '.cards',
      item: '.card',
      gutter: 5
    });
    grid.mount();
  }
  
  // mount
  function update() {
  	if ($('.cards').length != 1) return;
    grid.mount();
  }

  function submitNewMessage(){
	  $('textarea#message_content').keydown(function(event) {
	    if (event.keyCode == 13) {
	        $('[data-send="message"]').click();
	        $('[data-textarea="message"]').val(" ")
	        return false;
	     }
	  });
	}

  document.addEventListener('DOMContentLoaded', init);
  window.addEventListener('resize', update);

  /* When the user clicks on the button, 
  toggle between hiding and showing the dropdown content */
  function myFunction() {
      document.getElementById("myDropdown").classList.toggle("show");
  }

  // Close the dropdown menu if the user clicks outside of it
  window.onclick = function(event) {
    if (!event.target.matches('.dropbtn')) {

      var dropdowns = document.getElementsByClassName("dropdown-content");
      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }