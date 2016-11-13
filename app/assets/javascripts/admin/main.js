/*!
 * beagle v1.1.1 (http://foxythemes.net/themes/beagle)
 * Copyright 2014-2016 Foxy Themes all rights reserved 
 */

var App = (function () {
  'use strict';
  //Basic Config
  var config = {
    assetsPath: 'assets',
    imgPath: 'img',
    jsPath: 'js',
    libsPath: 'lib',
    leftSidebarSlideSpeed: 200,
    leftSidebarToggleSpeed: 300,
    enableSwipe: false,
    swipeTreshold: 100,
    scrollTop: true,
    openRightSidebarClass: 'open-right-sidebar',
    closeRsOnClickOutside: true,
    removeLeftSidebarClass: 'be-nosidebar-left',
    transitionClass: 'be-animate',
    openSidebarDelay: 400
  };

  var colors = {};
  var body = $("body");
  var wrapper = $(".be-wrapper");
  var leftSidebar = $(".be-left-sidebar");
  var rightSidebar = $(".be-right-sidebar");
  var openSidebar = false;

  //Get the template css colors into js vars
  function getColor( c ){
    var tmp = $("<div>", { class: c }).appendTo("body");
    var color = tmp.css("background-color");
    tmp.remove();

    return color;
  }
  //Counter
  function counter(){
    $('[data-toggle="counter"]').each(function(i, e){
      var _el       = $(this);
      var prefix    = '';
      var suffix    = '';
      var start     = 0;
      var end       = 0;
      var decimals  = 0;
      var duration  = 2.5;

      if( _el.data('prefix') ){ prefix = _el.data('prefix'); }

      if( _el.data('suffix') ){ suffix = _el.data('suffix'); }

      if( _el.data('start') ){ start = _el.data('start'); }

      if( _el.data('end') ){ end = _el.data('end'); }

      if( _el.data('decimals') ){ decimals = _el.data('decimals'); }

      if( _el.data('duration') ){ duration = _el.data('duration'); }

      var count = new CountUp(_el.get(0), start, end, decimals, duration, { 
        suffix: suffix,
        prefix: prefix,
      });

      count.start();
    });
  }
  //Core private functions
  function leftSidebarInit(){

    var firstAnchor = $(".sidebar-elements > li > a");
    var lsc = $(".left-sidebar-scroll");
    var lsToggle = $(".left-sidebar-toggle");

    function updateScroller(){
      if( wrapper.hasClass("be-fixed-sidebar") ){
        lsc.perfectScrollbar('update');
      }
    }

    /*Open sub-menu functionality*/
      firstAnchor.on("click",function( e ){
        e.preventDefault();
        var $el = $(this), $open, $speed = config.leftSidebarSlideSpeed;
        var $li = $el.parent();
        var $subMenu = $el.next();

        $open = $li.siblings(".open");

        if( $open ){
          
          $open.find('> ul:visible').slideUp({ duration: $speed, complete: function(){
            $open.toggleClass('open');
            $(this).removeAttr('style');
            updateScroller();
          }});
        }

        if( $li.hasClass('open') ){

          $subMenu.slideUp({ duration: $speed, complete: function(){
            $li.toggleClass('open');
            $(this).removeAttr('style');
            updateScroller();
          }});
        }else{

          $subMenu.slideDown({ duration: $speed, complete: function(){
            $li.toggleClass('open');
            $(this).removeAttr('style');
            updateScroller();
          }});
        }

        //If current element has children stop link action
        if( $el.next().is('ul') ){
          e.preventDefault();
        }

      });

    /*Calculate sidebar tree active & open classes*/
      $("li.active", leftSidebar).parents(".parent").addClass("active open");

    /*Scrollbar plugin init when left sidebar is fixed*/
      if( wrapper.hasClass("be-fixed-sidebar") ){
        lsc.perfectScrollbar();

        /*Update scrollbar height on window resize*/
        $(window).resize(function () {
          waitForFinalEvent(function(){
            lsc.perfectScrollbar('update');
          }, 500, "be_update_scroller");
        });
      }

    /*Toggle sidebar on small devices*/
      lsToggle.on('click',function( e ){

        var spacer = $(this).next('.left-sidebar-spacer');
        var toggleBtn = $(this);
        toggleBtn.toggleClass('open');
        spacer.slideToggle(config.leftSidebarToggleSpeed, function(){
          $(this).removeAttr('style').toggleClass('open');
        });
      });
  }

  function rightSidebarInit(){

    var rsScrollbar = $(".be-scroller", rightSidebar);

    function oSidebar(){
      body.addClass( config.openRightSidebarClass  + " " + config.transitionClass );
      openSidebar = true;
    }

    function cSidebar(){
      body.removeClass( config.openRightSidebarClass ).addClass( config.transitionClass );
      sidebarDelay();
    }

    if( rightSidebar.length > 0 ){
      /*Open-Sidebar when click on topbar button*/
      $('.be-toggle-right-sidebar').on("click", function(e){
        if( openSidebar && body.hasClass( config.openRightSidebarClass ) ){
          cSidebar();
        }else if( !openSidebar ){
          oSidebar();
        }
        
        e.preventDefault();
      });

      /*Close sidebar on click outside*/
      $( document ).on("mousedown touchstart",function( e ){
        if ( !$( e.target ).closest( rightSidebar ).length && body.hasClass( config.openRightSidebarClass ) && (config.closeRsOnClickOutside || $.isXs()) ) {
          cSidebar();
        }
      });
    }

    rsScrollbar.perfectScrollbar();

    /*Update scrollbar height on window resize*/
    $(window).resize(function () {
      waitForFinalEvent(function(){
        rsScrollbar.perfectScrollbar('update');
      }, 500, "be_update_scroller");
    });

    /*Update scrollbar when click on a tab*/
    $('a[data-toggle="tab"]', rightSidebar).on('shown.bs.tab', function (e) {
      var scrollEl = $(e.target.getAttribute("href")).find('.be-scroller');
      if( scrollEl.length ){
        scrollEl.perfectScrollbar('update');
      }
    });
  }

  function sidebarDelay(){
    openSidebar = true;
    setTimeout(function(){
      openSidebar = false;
    }, config.openSidebarDelay );
  }

  function sidebarSwipe(){
    /*Open sidedar on swipe*/
    wrapper.swipe( {
      allowPageScroll: "vertical",
      preventDefaultEvents: false,
      fallbackToMouseEvents: false,
      swipeLeft: function(e){
        if( !openSidebar && rightSidebar.length > 0 ){
          body.addClass( config.openRightSidebarClass + " " + config.transitionClass );
          openSidebar = true;
        }
      },
      threshold: config.swipeTreshold
    });
  }

  function chatWidget(){
    var chat = $(".be-right-sidebar .tab-chat");
    var contactsEl = $(".chat-contacts", chat);
    var conversationEl = $(".chat-window", chat);
    var messagesContainer = $(".chat-messages", conversationEl);
    var messagesList = $(".content ul", messagesContainer);
    var messagesScroll = $(".be-scroller", messagesContainer);
    var chatInputContainer = $(".chat-input", conversationEl);
    var chatInput = $("input", chatInputContainer);
    var chatInputSendButton = $(".send-msg", chatInputContainer);

    function openChatWindow(){
      if( !chat.hasClass("chat-opened") ){
        chat.addClass("chat-opened");
      }
    }

    function closeChatWindow(){
      if( chat.hasClass("chat-opened") ){
        chat.removeClass("chat-opened");
      }
    }

    /*Open Conversation Window when click on chat user*/
    $(".user a", contactsEl).on('click',function( e ){
      openChatWindow();
      e.preventDefault();
    });

    /*Close chat conv window*/
    $(".title .return", conversationEl).on('click',function( e ){
      closeChatWindow();
      scrollerInit();
    });

    /*Send message*/
    function sendMsg(msg, self){
      var $message = $('<li class="' + ((self)?'self':'friend') + '"></li>');

      if( msg != '' ){
        $('<div class="msg">' + msg + '</div>').appendTo($message);
        $message.appendTo(messagesList);

        messagesScroll.stop().animate({
          'scrollTop': messagesScroll.prop("scrollHeight")
        }, 900, 'swing');

        messagesScroll.perfectScrollbar('update');
      }
    }

    /*Send msg when click on 'send' button or press 'Enter'*/
      chatInput.keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        var msg = $(this).val();

        if(keycode == '13'){
          sendMsg(msg, true);
          $(this).val("");
        }
        event.stopPropagation();
      });

      chatInputSendButton.on('click',function(){
        var msg = chatInput.val();
        sendMsg(msg, true);
        chatInput.val("");
      });
  }

  function scrollerInit(){
    $(".be-scroller").perfectScrollbar();
  }

  function scrollTopButton(){
    var offset = 220;
    var duration = 500;
    var button = $('<div class="be-scroll-top"></div>');
    button.appendTo("body");
    
    $(window).on('scroll',function() {
      if ( $(this).scrollTop() > offset ) {
        button.fadeIn(duration);
      } else {
        button.fadeOut(duration);
      }
    });
  
    button.on('touchstart mouseup',function( e ) {
      $( 'html, body' ).animate({ scrollTop: 0 }, duration);
      e.preventDefault();
    });
  }

  //Wait for final event on window resize
  var waitForFinalEvent = (function () {
    var timers = {};
    return function (callback, ms, uniqueId) {
      if (!uniqueId) {
        uniqueId = "x1x2x3x4";
      }
      if (timers[uniqueId]) {
        clearTimeout (timers[uniqueId]);
      }
      timers[uniqueId] = setTimeout(callback, ms);
    };
  })();

  return {
    //General data
    conf: config,
    color: colors,

    //Init function
    init: function (options) {
      
      //Extends basic config with options
        $.extend( config, options );

      /*FastClick on mobile*/
        FastClick.attach(document.body);

      /*Left Sidebar*/
        leftSidebarInit();
      
      /*Right Sidebar*/
        rightSidebarInit();
        chatWidget();

      /*Sidebars Swipe*/
        if( config.enableSwipe ){
          sidebarSwipe();
        }

      /*Scroll Top button*/
        if( config.scrollTop ){
          scrollTopButton();
        }

      /*Get colors*/
        colors.primary = getColor('clr-primary');
        colors.success = getColor('clr-success');
        colors.warning = getColor('clr-warning');
        colors.danger  = getColor('clr-danger');
        colors.grey    = getColor('clr-grey');

      //Prevent Connections Dropdown closes on click
        $(".be-connections").on("click",function( e ){
          e.stopPropagation();
        });

      //Scroller plugin init
        scrollerInit();

      /*Bind plugins on hidden elements*/
      /*Dropdown shown event*/
        $('.dropdown').on('shown.bs.dropdown', function () {
          $(".be-scroller").perfectScrollbar('update');
        });
        
      /*Tabs refresh hidden elements*/
        $('.nav-tabs').on('shown.bs.tab', function (e) {
          $(".be-scroller").perfectScrollbar('update');
        });

      /*Tooltips*/
        $('[data-toggle="tooltip"]').tooltip();
      
      /*Popover*/
        $('[data-toggle="popover"]').popover();

      /*Bootstrap modal scroll top fix*/
        $('.modal').on('show.bs.modal', function(){
          $("html").addClass('be-modal-open');
        });

        $('.modal').on('hidden.bs.modal', function(){
          $("html").removeClass('be-modal-open');
        });

      /* Counter */
      counter(); 
    }
  };
 
})();
//FastClick
function FastClick(a,b){"use strict";function c(a,b){return function(){return a.apply(b,arguments)}}var d;if(b=b||{},this.trackingClick=!1,this.trackingClickStart=0,this.targetElement=null,this.touchStartX=0,this.touchStartY=0,this.lastTouchIdentifier=0,this.touchBoundary=b.touchBoundary||10,this.layer=a,this.tapDelay=b.tapDelay||200,!FastClick.notNeeded(a)){for(var e=["onMouse","onClick","onTouchStart","onTouchMove","onTouchEnd","onTouchCancel"],f=this,g=0,h=e.length;g<h;g++)f[e[g]]=c(f[e[g]],f);deviceIsAndroid&&(a.addEventListener("mouseover",this.onMouse,!0),a.addEventListener("mousedown",this.onMouse,!0),a.addEventListener("mouseup",this.onMouse,!0)),a.addEventListener("click",this.onClick,!0),a.addEventListener("touchstart",this.onTouchStart,!1),a.addEventListener("touchmove",this.onTouchMove,!1),a.addEventListener("touchend",this.onTouchEnd,!1),a.addEventListener("touchcancel",this.onTouchCancel,!1),Event.prototype.stopImmediatePropagation||(a.removeEventListener=function(b,c,d){var e=Node.prototype.removeEventListener;"click"===b?e.call(a,b,c.hijacked||c,d):e.call(a,b,c,d)},a.addEventListener=function(b,c,d){var e=Node.prototype.addEventListener;"click"===b?e.call(a,b,c.hijacked||(c.hijacked=function(a){a.propagationStopped||c(a)}),d):e.call(a,b,c,d)}),"function"==typeof a.onclick&&(d=a.onclick,a.addEventListener("click",function(a){d(a)},!1),a.onclick=null)}}var deviceIsAndroid=navigator.userAgent.indexOf("Android")>0,deviceIsIOS=/iP(ad|hone|od)/.test(navigator.userAgent),deviceIsIOS4=deviceIsIOS&&/OS 4_\d(_\d)?/.test(navigator.userAgent),deviceIsIOSWithBadTarget=deviceIsIOS&&/OS ([6-9]|\d{2})_\d/.test(navigator.userAgent),deviceIsBlackBerry10=navigator.userAgent.indexOf("BB10")>0;FastClick.prototype.needsClick=function(a){"use strict";switch(a.nodeName.toLowerCase()){case"button":case"select":case"textarea":if(a.disabled)return!0;break;case"input":if(deviceIsIOS&&"file"===a.type||a.disabled)return!0;break;case"label":case"video":return!0}return/\bneedsclick\b/.test(a.className)},FastClick.prototype.needsFocus=function(a){"use strict";switch(a.nodeName.toLowerCase()){case"textarea":return!0;case"select":return!deviceIsAndroid;case"input":switch(a.type){case"button":case"checkbox":case"file":case"image":case"radio":case"submit":return!1}return!a.disabled&&!a.readOnly;default:return/\bneedsfocus\b/.test(a.className)}},FastClick.prototype.sendClick=function(a,b){"use strict";var c,d,e,f;document.activeElement&&document.activeElement!==a&&document.activeElement.blur(),f=b.changedTouches[0],e=document.createEvent("MouseEvents"),e.initMouseEvent("mousedown",!0,!0,window,1,f.screenX,f.screenY,f.clientX,f.clientY,!1,!1,!1,!1,0,null),e.forwardedTouchEvent=!0,a.dispatchEvent(e),d=document.createEvent("MouseEvents"),d.initMouseEvent("mouseup",!0,!0,window,1,f.screenX,f.screenY,f.clientX,f.clientY,!1,!1,!1,!1,0,null),d.forwardedTouchEvent=!0,a.dispatchEvent(d),c=document.createEvent("MouseEvents"),c.initMouseEvent(this.determineEventType(a),!0,!0,window,1,f.screenX,f.screenY,f.clientX,f.clientY,!1,!1,!1,!1,0,null),c.forwardedTouchEvent=!0,a.dispatchEvent(c)},FastClick.prototype.determineEventType=function(a){"use strict";return deviceIsAndroid&&"select"===a.tagName.toLowerCase()?"mousedown":"click"},FastClick.prototype.focus=function(a){"use strict";var b;deviceIsIOS&&a.setSelectionRange&&0!==a.type.indexOf("date")&&"time"!==a.type?(b=a.value.length,a.setSelectionRange(b,b)):a.focus()},FastClick.prototype.updateScrollParent=function(a){"use strict";var b,c;if(b=a.fastClickScrollParent,!b||!b.contains(a)){c=a;do{if(c.scrollHeight>c.offsetHeight){b=c,a.fastClickScrollParent=c;break}c=c.parentElement}while(c)}b&&(b.fastClickLastScrollTop=b.scrollTop)},FastClick.prototype.getTargetElementFromEventTarget=function(a){"use strict";return a.nodeType===Node.TEXT_NODE?a.parentNode:a},FastClick.prototype.onTouchStart=function(a){"use strict";var b,c,d;if(a.targetTouches.length>1)return!0;if(b=this.getTargetElementFromEventTarget(a.target),c=a.targetTouches[0],deviceIsIOS){if(d=window.getSelection(),d.rangeCount&&!d.isCollapsed)return!0;if(!deviceIsIOS4){if(c.identifier&&c.identifier===this.lastTouchIdentifier)return a.preventDefault(),!1;this.lastTouchIdentifier=c.identifier,this.updateScrollParent(b)}}return this.trackingClick=!0,this.trackingClickStart=a.timeStamp,this.targetElement=b,this.touchStartX=c.pageX,this.touchStartY=c.pageY,a.timeStamp-this.lastClickTime<this.tapDelay&&a.preventDefault(),!0},FastClick.prototype.touchHasMoved=function(a){"use strict";var b=a.changedTouches[0],c=this.touchBoundary;return Math.abs(b.pageX-this.touchStartX)>c||Math.abs(b.pageY-this.touchStartY)>c},FastClick.prototype.onTouchMove=function(a){"use strict";return!this.trackingClick||((this.targetElement!==this.getTargetElementFromEventTarget(a.target)||this.touchHasMoved(a))&&(this.trackingClick=!1,this.targetElement=null),!0)},FastClick.prototype.findControl=function(a){"use strict";return void 0!==a.control?a.control:a.htmlFor?document.getElementById(a.htmlFor):a.querySelector("button, input:not([type=hidden]), keygen, meter, output, progress, select, textarea")},FastClick.prototype.onTouchEnd=function(a){"use strict";var b,c,d,e,f,g=this.targetElement;if(!this.trackingClick)return!0;if(a.timeStamp-this.lastClickTime<this.tapDelay)return this.cancelNextClick=!0,!0;if(this.cancelNextClick=!1,this.lastClickTime=a.timeStamp,c=this.trackingClickStart,this.trackingClick=!1,this.trackingClickStart=0,deviceIsIOSWithBadTarget&&(f=a.changedTouches[0],g=document.elementFromPoint(f.pageX-window.pageXOffset,f.pageY-window.pageYOffset)||g,g.fastClickScrollParent=this.targetElement.fastClickScrollParent),d=g.tagName.toLowerCase(),"label"===d){if(b=this.findControl(g)){if(this.focus(g),deviceIsAndroid)return!1;g=b}}else if(this.needsFocus(g))return a.timeStamp-c>100||deviceIsIOS&&window.top!==window&&"input"===d?(this.targetElement=null,!1):(this.focus(g),this.sendClick(g,a),deviceIsIOS&&"select"===d||(this.targetElement=null,a.preventDefault()),!1);return!(!deviceIsIOS||deviceIsIOS4||(e=g.fastClickScrollParent,!e||e.fastClickLastScrollTop===e.scrollTop))||(this.needsClick(g)||(a.preventDefault(),this.sendClick(g,a)),!1)},FastClick.prototype.onTouchCancel=function(){"use strict";this.trackingClick=!1,this.targetElement=null},FastClick.prototype.onMouse=function(a){"use strict";return!this.targetElement||(!!a.forwardedTouchEvent||(!a.cancelable||(!(!this.needsClick(this.targetElement)||this.cancelNextClick)||(a.stopImmediatePropagation?a.stopImmediatePropagation():a.propagationStopped=!0,a.stopPropagation(),a.preventDefault(),!1))))},FastClick.prototype.onClick=function(a){"use strict";var b;return this.trackingClick?(this.targetElement=null,this.trackingClick=!1,!0):"submit"===a.target.type&&0===a.detail||(b=this.onMouse(a),b||(this.targetElement=null),b)},FastClick.prototype.destroy=function(){"use strict";var a=this.layer;deviceIsAndroid&&(a.removeEventListener("mouseover",this.onMouse,!0),a.removeEventListener("mousedown",this.onMouse,!0),a.removeEventListener("mouseup",this.onMouse,!0)),a.removeEventListener("click",this.onClick,!0),a.removeEventListener("touchstart",this.onTouchStart,!1),a.removeEventListener("touchmove",this.onTouchMove,!1),a.removeEventListener("touchend",this.onTouchEnd,!1),a.removeEventListener("touchcancel",this.onTouchCancel,!1)},FastClick.notNeeded=function(a){"use strict";var b,c,d;if("undefined"==typeof window.ontouchstart)return!0;if(c=+(/Chrome\/([0-9]+)/.exec(navigator.userAgent)||[,0])[1]){if(!deviceIsAndroid)return!0;if(b=document.querySelector("meta[name=viewport]")){if(b.content.indexOf("user-scalable=no")!==-1)return!0;if(c>31&&document.documentElement.scrollWidth<=window.outerWidth)return!0}}if(deviceIsBlackBerry10&&(d=navigator.userAgent.match(/Version\/([0-9]*)\.([0-9]*)/),d[1]>=10&&d[2]>=3&&(b=document.querySelector("meta[name=viewport]")))){if(b.content.indexOf("user-scalable=no")!==-1)return!0;if(document.documentElement.scrollWidth<=window.outerWidth)return!0}return"none"===a.style.msTouchAction},FastClick.attach=function(a,b){"use strict";return new FastClick(a,b)},"function"==typeof define&&"object"==typeof define.amd&&define.amd?define(function(){"use strict";return FastClick}):"undefined"!=typeof module&&module.exports?(module.exports=FastClick.attach,module.exports.FastClick=FastClick):window.FastClick=FastClick;

/*!
 * jQuery bootstrap 3 breakpoint check
 * Check the current visibility of bootstrap 3 breakpoints
 *
 * @example `$.isXs()` function alias for `$.isBreakpoint("xs")`
 * @example `$.isSm()` function alias for `$.isBreakpoint("sm")`
 * @example `$.isMd()` function alias for `$.isBreakpoint("md")`
 * @example `$.isLg()` function alias for `$.isBreakpoint("lg")`
 * @version 1.0.0
 * @copyright Jens A. (cakebake) and other contributors
 * @license Released under the MIT license
 */
!function(a){a.isBreakpoint=function(b){var c,d;return c=a("<div/>",{"class":"visible-"+b}).appendTo("body"),d=c.is(":visible"),c.remove(),d},a.extend(a,{isXs:function(){return a.isBreakpoint("xs")},isSm:function(){return a.isBreakpoint("sm")},isMd:function(){return a.isBreakpoint("md")},isLg:function(){return a.isBreakpoint("lg")}})}(jQuery);