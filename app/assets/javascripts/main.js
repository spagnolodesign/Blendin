$(document).on('turbolinks:load', function() {
    initAjaxBerryRequest();
    initSearchFilter();
    initFilterList();
    // initAjaxFormRequest ();
    //scrollHeader();
    closeOverlay();
    showModalAvatar();
    nav();
    // initGrid();
    // updateGrid();
    
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

function initSearchFilter() {
    Turbolinks.clearCache();
    var search = $('#berries-filter');
    if (search.length < 1 ) return;

    search.selectize({
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
            filterValue(this);
        },
    });

    function filterValue(data) {
        var tags = data.items.toString();
        Turbolinks.visit("?berries="+tags);
    }

}

function initFilterList () {
    Turbolinks.clearCache();
    var filterEl = $('#filter-column');
    var selected = [];

    if (filterEl.length < 1) return;
    
    filterEl.on( "click", "li", storeValue);
    selected = filterEl.attr('data-selected').split(',');
    if (selected[0].length == 0){
        selected = [];
    }
    filterEl.find('li').filter(function( index, el ) {
       var el = $(el);
       var text = el.text().replace(/\s/g, '');
       $.each(selected, function(i,v){
            if (text == v) {
                el.addClass('active');
            }
       });
    });

    function storeValue(e) {
        var el = $(e.currentTarget);
        var tag = el.text().replace(/\s/g, '');
        if (el.hasClass('active')) return;
        el.addClass('active');
        selected.push(tag);
        Turbolinks.visit("?berries="+selected);
    }
}

var grid;

function initGrid() {
    if ($('.cards').length != 1) return;
    grid = new Minigrid({
      container: '.cards',
      item: '.card',
      gutter: 8
    });
    grid.mount();
}
  
// mount
function updateGrid(e) {
    if ($('.cards').length != 1) return;
    var width = window.innerWidth;
    console.log(width)
    if (width <= '480') {
      grid.props.gutter = 4
    }else if(width >= '700'){
      grid.props.gutter = 8
    }
    grid.mount();
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

function nav() {
        var t, e, n, r;
        return setTimeout(function() {
            return $("body").addClass("loaded")
        }, 100), e || (e = null), r || (r = null), t = function(t) {
            return null == t && (t = 300), clearTimeout(r), e = setTimeout(function() {
                return $("body").removeClass("overlord_active").removeClass("overlord_opened")
            }, t)
        }, n = function(t) {
            return null == t && (t = 50), clearTimeout(e), r = setTimeout(function() {
                return $("body").addClass("overlord_active"), setTimeout(function() {
                    return $("body").addClass("overlord_done")
                }, 20), setTimeout(function() {
                    return $("body").addClass("overlord_opened")
                }, 500)
            }, t)
        }, $("div#whiteout").on("click", function() {
            return t(0), !1
        }), $("ul#dropdown li a").on("click", function() {
            return t(0)
        }), $("#hamburger").on("click touchend", function() {
            return $("body").hasClass("overlord_opened") ? (t(0), $("body").removeClass("overlord_opened")) : n(0), !1
        }), $("#hamburger, ul#dropdown").on("mouseenter", function() {
            return n(200)
        }).on("mouseleave", function() {
            return t(600)
        }), !1
}
