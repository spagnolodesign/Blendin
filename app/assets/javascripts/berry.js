$(document).on('turbolinks:load', function() {
    initAjaxBerryRequest();
    initFilterBerrisHome();
    // initAjaxFormRequest ();
    scrollHeader();
    closeOverlay();
    showModalAvatar();

    $('#chat-list').fixedsticky();


});

function closeOverlay(){
    $('.close-btn').click(function(){
        $(this).parent().fadeOut(300);
    });
}

function initAjaxFormRequest (){
    $("form").on("ajax:success", function(e, data, status, xhr) {
        //console.log(xhr)
    }).on("ajax:error", function(e, xhr, status, error) {
       $('.error-form-ajax').html(xhr.responseText)
    });
}

function initAjaxBerryRequest (){
    $(".btn-berry").on("ajax:success", function(e, data, status, xhr) {
        var event = xhr.responseJSON.event;
        $(e.currentTarget).remove();
        if (event == "is_match"){
            showMatchModal(data.data.token);
        }else{
            return;
        }
    }).on("ajax:error", function(e, xhr, status, error) {
        alert("Umm, seems you alredy nocced.");
    });
}

function showModalAvatar(){
   
    $(".avatar-modal").on("click", function(e) {
        var imgPath = e.currentTarget.dataset.image;
        
        swal({
          imageUrl: imgPath,
          showConfirmButton: false,
          customClass: "modal-image"
        });
    });
}

function showMatchModal(token){
        var t = token;
        swal({
          title: 'Sweet!<br>You just got a beery',
          text: 'Start text now.',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes, go!',
          imageUrl: '/assets/berry-match.png',
          imageWidth: 124,
          imageHeight: 128,
        }).then(function() {
          Turbolinks.visit('/rooms/'+t);
        })

}

function initFilterBerrisHome () {
    Turbolinks.clearCache();

    if ($('#berries-filter').length < 1) return;
    $('#berries-filter').selectize({
        persist: false,
        createOnBlur: true,
        maxItems: 10,
        create: false,
        openOnFocus:true,
        maxOptions:2000,
        delimiter: ',',
        closeAfterSelect:true,
        plugins: ['remove_button'],
        valueField: 'name',
        labelField: 'name',
        searchField: ['name'],
        options: available_tags,
        onItemAdd: function(value, data) {
            filterValue(this)
        },
        onItemRemove: function(value) {
            console.log('yo')
            filterValue(this);
        },
    });

    function filterValue(data) {
        var tags = data.items.toString();
        Turbolinks.visit("?berries="+tags);
    }
}

function scrollHeader() {
    var didScroll;
    var lastScrollTop = 0;
    var delta = 5;
    var navbarHeight = $('header').outerHeight();

    $(window).scroll(function(event){
        didScroll = true;
    });

    setInterval(function() {
        if (didScroll) {
            hasScrolled();
            didScroll = false;
        }
    }, 250);

    function hasScrolled() {
        var st = $(this).scrollTop();
        
        // Make sure they scroll more than delta
        if(Math.abs(lastScrollTop - st) <= delta)
            return;
        
        // If they scrolled down and are past the navbar, add class .nav-up.
        // This is necessary so you never see what is "behind" the navbar.
        if (st > lastScrollTop && st > navbarHeight){
            // Scroll Down
            $('header').removeClass('nav-down').addClass('nav-up');
        } else {
            // Scroll Up
            if(st + $(window).height() < $(document).height()) {
                $('header').removeClass('nav-up').addClass('nav-down');
            }
        }
        
        lastScrollTop = st;
    }
}
