$(document).on('turbolinks:load', function() {
    initAjaxBerryRequest();
    initFilterBerrisHome();
    // initAjaxFormRequest ();
    scrollHeader();
    closeOverlay();
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
        console.log(event)
        $(e.currentTarget).remove();

        if (event == "is_match"){
            alert("You got a berry go to message and start to chat!")
        }else{
            return;
        }

    }).on("ajax:error", function(e, xhr, status, error) {

        alert("Umm, seems you alredy nocced.");

    });
}

function initFilterBerrisHome () {
    Turbolinks.clearCache();

    if ($('#berries-filter').length < 1) return;
    $('#berries-filter').selectize({
        persist: false,
        createOnBlur: true,
        maxItems: 10,
        create: true,
        openOnFocus:false,
        delimiter: ',',
        plugins: ['remove_button'],
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
