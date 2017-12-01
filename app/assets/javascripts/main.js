$(function () {
  console.log('ready')

  $('#toggle-nav').on('click', toggleNav);

  function toggleNav() {
      var x = document.getElementById("nav-js");
      if (x.className === "top-nav") {
          x.className += " responsive";
      } else {
          x.className = "top-nav";
      }
  }

  window.initIntroJs = function (section){
    var introInViews = introJs();
    var labelViewTour = section + "-done-tour";

    var doneTour = localStorage.getItem(labelViewTour);

    if (doneTour) {
      return;
    }else{
      introInViews.oncomplete(function() {
        localStorage.setItem(labelViewTour, true);
      }).start();
      introInViews.onexit(function() {
         localStorage.setItem(labelViewTour, true);
      }).start();
      introInViews.start();
    }
  }



});
