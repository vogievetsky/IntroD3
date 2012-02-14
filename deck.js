(function() {
  "use strict";
  var m, n, slide;
  slide = null;
  n = d3.selectAll('section')[0].length;

  function update(newSlide) {
    newSlide = Math.min(Math.max(newSlide, 0), n - 1);
    if (slide === newSlide) return;
    slide = newSlide;
    window.location.href = window.location.href.replace(/#.+$/, '') + '#' + String(slide + 1);
    d3.selectAll('section').style('display', function(d, i) {
      if (i === slide) {
        return null;
      } else {
        return 'none';
      }
    }).each(function(d, i) {
      if (i === slide && typeof d === 'function') {
        d();
      }
    });
  };

  if (m = window.location.href.match(/#(\d+)$/)) {
    update(parseInt(m[1], 10) - 1);
  } else {
    update(0);
  }

  d3.select('body').on('keydown', function() {
    var newSlide;
    switch (d3.event.keyCode) {
      case 40:
      case 34:
      case 39:
        newSlide = d3.event.metaKey ? Infinity : slide + 1;
        break;
      case 38:
      case 33:
      case 37:
        newSlide = d3.event.metaKey ? 0 : slide - 1;
        break;
      case 32:
        newSlide = d3.event.shiftKey ? slide - 1 : slide + 1;
        break;
      default:
        return;
    }
    update(newSlide);
    d3.event.preventDefault();
  });
})();
