$(document).on('turbolinks:load', function() {
    initAjaxBerryRequest();
    initSearchFilter();
    // initFilterList();
    // initAjaxFormRequest ();
    //scrollHeader();
    closeOverlay();
    //showModalAvatar();
    // nav();
    // initGrid();
    // updateGrid();
    dropdown();
    initTagSelection();
    paginate();
    paginateMessages();
    animCards();
    slidePanel();

    var filterEl = $('#filter-column');
    var tmp = generateColor('#FFFFFF','#74CED2', filterEl.find('li').length);

    filterEl.find('li span').filter(function( index, el ) {
       var el = $(el);
       el.css("background-color","#"+tmp[index]);
    });
});

function slidePanel() {
    $('#close-overlay').click(function(event) {
       $('#panel-overlay').hide().find('.content').toggleClass('slide-in-bounce');
    });
}

function animCards(){
    var cards = $('.cards-list .card').not('.spin-up');
    var time = 100;

    cards.each(function() {
      setTimeout( function(){ $(this).addClass('spin-up') }.bind(this), time)
      time += 140;
    });
}
function paginate(){
    if ($('.users-layout').find('.pagination').length) {
        $(window).scroll(function() {
          var url = $('.pagination .next_page').attr('href');
          if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 20) {
            $('.pagination').text("Please Wait...");
            return $.getScript(url);
          }
          animCards();
          initAjaxBerryRequest();
        });
        return $(window).scroll();
      }
}
function paginateMessages(){
    if ($('.chat-messages-layout .pagination').length) {
        $('#messages').scroll(function() {
          var url = $('.pagination .next_page').attr('href');
          if (url && $('#messages').scrollTop() <= 0) {
            $('.pagination').text("Please Wait...");
            return $.getScript(url);
          }
          animCards();
          initAjaxBerryRequest();
        });
        return $(window).scroll();
      }
}
function dropdown() {
    
    var dropAccount;
    dropAccount = new Drop({
      target: document.getElementById("drop-account"),
      content: $('#main-sub-nav').html(),
      position: 'bottom left',
      openOn: 'click',
      classes: 'drop-theme-arrows',
      constrainToWindow: false,
      constrainToScrollParent: false,
      classPrefix: "my-dop"
    });
}

function hex (c) {
  var s = "0123456789abcdef";
  var i = parseInt (c);
  if (i == 0 || isNaN (c))
    return "00";
  i = Math.round (Math.min (Math.max (0, i), 255));
  return s.charAt ((i - i % 16) / 16) + s.charAt (i % 16);
}

/* Convert an RGB triplet to a hex string */
function convertToHex (rgb) {
  return hex(rgb[0]) + hex(rgb[1]) + hex(rgb[2]);
}

/* Remove '#' in color hex string */
function trim (s) { return (s.charAt(0) == '#') ? s.substring(1, 7) : s }

/* Convert a hex string to an RGB triplet */
function convertToRGB (hex) {
  var color = [];
  color[0] = parseInt ((trim(hex)).substring (0, 2), 16);
  color[1] = parseInt ((trim(hex)).substring (2, 4), 16);
  color[2] = parseInt ((trim(hex)).substring (4, 6), 16);
  return color;
}

function generateColor(colorStart,colorEnd,colorCount){

    // The beginning of your gradient
    var start = convertToRGB (colorStart);    

    // The end of your gradient
    var end   = convertToRGB (colorEnd);    

    // The number of colors to compute
    var len = colorCount;

    //Alpha blending amount
    var alpha = 0.0;

    var saida = [];
    
    for (i = 0; i < len; i++) {
        var c = [];
        alpha += (1.0/len);
        
        c[0] = start[0] * alpha + (1 - alpha) * end[0];
        c[1] = start[1] * alpha + (1 - alpha) * end[1];
        c[2] = start[2] * alpha + (1 - alpha) * end[2];

        saida.push(convertToHex (c));
        
    }
    
    return saida;
    
}
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
    $(".noc-btn").on("ajax:success", function(e, data, status, xhr) {
        var event = xhr.responseJSON.event;
        console.log(event)
        $(e.currentTarget).hide();
        if (event == "is_match"){
            showMatchModal(data.data.token);
        }else{
            return;
        }
    }).on("ajax:error", function(e, xhr, status, error) {
        swal({
            title: 'You alredy blend it!',
            text: 'Start blend other people.',
            confirmButtonText: 'Ok!',
            confirmButtonClass: 'btn btn-lg btn-primary btn-success',
            cancelButtonClass: 'btn btn-lg btn-primary btn-danger',
            buttonsStyling: false
        });
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
        title: 'You have a new a match!',
        text: 'Start chat now',
        showCancelButton: true,
        padding:'2.5em 0',
        confirmButtonText: 'Yes, go!',
        imageUrl: '/assets/ico-chat.svg',
        imageWidth: 150,
        imageHeight: 150,
        confirmButtonClass: 'btn btn-lg btn-primary btn-success',
        cancelButtonClass: 'btn btn-lg btn-primary btn-danger',
        buttonsStyling: false
    }).then(function() {
      Turbolinks.visit('/rooms/'+t);
    })
}

function initSearchFilter() {
    Turbolinks.clearCache();
    var search = $('#tags-filter');
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
        Turbolinks.visit("?t="+tags);
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


function initTagSelection() {
    var tagList,input,submit,userTagList, btnAdd;

    tagList = $('#select-tag-list');
    btnAdd = $('#add-new-tag');
    if (tagList.length == 0) return;
    
    tagList.on( "click", "li:not('.insert')", storeValue);
    // tagList.on( "click", "button", addBubble);
    // tagList.on("keyup", "#new-tag-value", setBubble);


    input = $('#user_tag_list');
    submit = $('#btn-add-tag');
    
    userTagList = usertags.replace(/\s/g, '').split(',');

    init();
    validate(userTagList);

    function init() {

        tagList.find('li').filter(function( index, el ) {
            var el = $(el);
            var text = el.text().replace(/\s/g, '');
            $.each(userTagList, function(i,v){
                if (text == v) {
                    el.addClass('active');
                }
            });
        });
    }

    function storeValue(e) {
        var el = $(e.currentTarget);
        var tag = el.text().replace(/\s/g, '');
        el.toggleClass('active');
            toggleArrayItem(userTagList, tag);
            setValueInput(userTagList);
            validate(userTagList)
    }

    function toggleArrayItem(a, v) {
        var i = a.indexOf(v);
        if (i === -1)
            a.push(v);
        else
            a.splice(i,1);
    }

    function setValueInput(v) {
        input.val(v);
    }

    function validate(v) {
        if(userTagList.length > 3 ){
            submit.addClass('anim-next');
        }
        if(userTagList.length < 3 ){
            submit.removeClass('anim-next');
        }
    }

    function addBubble(e) {
        e.preventDefault();
        tagList.prepend('<li class="tag-bubble insert"><textarea id="new-tag-value"></textarea></li>');
    }
    function setBubble(e){
        if(e.keyCode == 13)
        {
           var el = $(e.currentTarget).parent();
           var value = $(e.currentTarget).val().replace(/\s+/g, '');
            el.append('<span>'+value+'</span>');
            $(e.currentTarget).remove();
            el.toggleClass('insert');
            el.toggleClass('active');
        }
    }
}

