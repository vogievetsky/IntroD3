(function() {
  "use strict"

  var slide = {};
  window.slide = slide;

  function fn_to_string(fn) {
    var lines = fn.toString()
      .replace(/^function\s*\([^)]*\)\s*{\s*\n/, '')
      .replace(/\s*}\s*$/, '')
      .split('\n');

    // remove common pre-space
    var minSpace = d3.min(lines.map(function(line) {
      return line ? line.match(/^\s*/)[0].length : Infinity;
    }));
    if (minSpace && isFinite(minSpace)) {
      lines = lines.map(function(line) { return line.substr(minSpace); })
    }

    return lines.join('\n');
  }

  slide.code = function(title, init, code) {
    var out, codeText;

    function myInit() {
      out.selectAll('*').remove();
      init(out.node());
    }

    var section = d3.select('body')
      .append('section')
      .data([myInit])
      .attr('class', "code_slide")

    section.append('h1')
      .text(title)

    var codes = section.append('div')
      .attr('class', 'codes')

    function run() {
      var code = codeText.property('value');
      code = '(function() {\n' + code + '\n})()';
      try {
        eval(code);
      } catch(err) {
        throw err; // ToDo
      }
    }

    codeText = codes.append('textarea')
      .attr('class', 'code')
      .property('value', fn_to_string(code))
      .on('keydown', function() {
          // Run if command + enter
          if (d3.event.keyCode === 13 && d3.event.metaKey) run();
          d3.event.stopPropagation();
        })

    var buttonBar = codes.append('div')
      .attr('class', 'button_bar')

    buttonBar.append('div')
      .attr('class', 'run')
      .text('Run')
      .on('click', run)

    buttonBar.append('div')
      .attr('class', 'reset')
      .text('Reset')
      .on('click', myInit)

    out = section.append('div')
      .attr('class', "svg_out")
  }

  slide.code_title = function(title) {
    d3.select('body')
      .append('section')
      .attr('class', "code_title")
        .append('h1')
        .text(title);
  }
})();


