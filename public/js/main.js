window.onload = function () {
  
  (function() {
    'use strict';

    var conf = {};

    conf.init = function() {
      this.setHeight();
    };

    conf.setHeight = function() {
      var el = document.getElementsByClassName('landing-container')[0];
      
      window.onresize = function() {
        el.style.height = window.screen.availHeight+"px";
      }
      el.style.height = window.screen.availHeight+"px";
    }

    conf.init();
  })();
  
}