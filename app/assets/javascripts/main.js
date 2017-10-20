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

});
