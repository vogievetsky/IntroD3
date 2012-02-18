empty_svg = (parent) ->
  window.svg = d3.select(parent).append("svg")

rect1 = (parent) ->
  empty_svg(parent);

  svg
    .append("rect")
    .attr("x", 150)
    .attr("y", 100)
    .attr("width", 60)
    .attr("height", 300)


rect3 = (parent) ->
  empty_svg(parent)

  svg.append("rect")
    .attr("x", 200)
    .attr("y", 300)
    .attr("width", 40)
    .attr("height", 50);

  svg.append("rect")
    .attr("x", 100)
    .attr("y", 20)
    .attr("width", 30)
    .attr("height", 50);

  svg.append("rect")
    .attr("x", 10)
    .attr("y", 200)
    .attr("width", 25)
    .attr("height", 90)

# ----------------------------------------------------

slide.code "JavaScript", empty_svg, """
// In JS functions are first class citizens.
// This is a very powerful concept!
var squared = function(x) { return x*x };
console.log("squared(7) ==", squared(7));


// D3 has many helper methods
// d3.scale.linear() returns a function that
// will map the given domain to the given
// range linearly.
var w = 640, h = 320;

var x = d3.scale.linear()
  .domain([-1, 1])
  .range([0, w]);

var y = d3.scale.linear()
  .domain([0, 1])
  .range([0, h]);

console.log("x(0) ==", x(0)); // == w/2
console.log("y(3) ==", y(3)); // == 3*h
"""

slide.title "Core D3"

# -----------------------------------------------
slide.code_title(title = ".select()");

slide.code title, rect1, """
// svg = d3.select("svg.that_svg_to_the_right")
var myRect = svg.select("rect")
myRect.attr("width", 100)
myRect.attr("height", 100)
myRect.style("fill", "steelblue")
"""

slide.code title, rect1, """
// svg = d3.select("svg.that_svg_to_the_right")
svg.select("rect")
  .attr("width", 100)
  .attr("height", 100)
  .style("fill", "steelblue")
"""


# -----------------------------------------------
slide.code_title(title = ".selectAll()");

slide.code title, rect3, """
svg.select("rect")
  .attr("width", 100)
  .attr("height", 100)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
svg.selectAll("rect")
  .attr("width", 100)
  .attr("height", 100)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
svg.selectAll("rect")
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) {
      return i*150+100;
    })
  .attr("height", 20)
  .style("fill", "steelblue")
"""


# -----------------------------------------------
slide.code_title(title = ".data()");

slide.code title, rect3, """
svg.selectAll("rect")
  .data([64, 128, 256])
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

# -----------------------------------------------
slide.code_title(title = ".enter()");

slide.code title, rect3, """
var selection = svg.selectAll("rect")
  .data([64, 128, 256, 71])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
var selection = svg.selectAll("rect")
  .data([64, 128, 256, 71])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")

selection.enter().append("rect")
  .attr("x", 10) // let"s just put it somewhere
  .attr("y", 10)
  .attr("width", 30)
  .attr("height", 30)
  .style("fill", "green")
"""

slide.code title, rect3, """
var selection = svg.selectAll("rect")
  .data([64, 128, 256, 71])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")

selection.enter().append("rect")
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
var selection = svg.selectAll("rect")
  .data([64, 128, 256, 71])

// Shorter
selection.enter().append("rect")

// when updating the regular selection then
// enter selection is joined in to the update
// selection for convenience.
selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

title += " // a common pattern"
slide.code title, empty_svg, """
svg.selectAll("rect")
  .data([64, 128, 256])
  .enter().append("rect")
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
"""


# -----------------------------------------------
slide.code_title(title = ".exit()");

slide.code title, rect3, """
var selection = svg.selectAll("rect")
  .data([64, 128])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
var selection = svg.selectAll("rect")
  .data([64, 128])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")

selection.exit()
  .remove()
"""


# -----------------------------------------------
slide.code_title(title = ".transition()");

slide.code title, rect3, """
svg.selectAll("rect")
  .data([64, 128, 256])
  .transition()
  .duration(3000) // 3 seconds
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
"""

slide.code title, rect3, """
var selection = svg.selectAll("rect")
  .data([64, 128, 256, 71])

selection.enter().append("rect")
  .attr("x", 200)
  .attr("y", 200)
  .attr("width", 10)
  .attr("height", 10)
  .style("fill", "red")

selection
  .transition()
  .duration(3000)
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
    .transition()
    .duration(3000)
    .delay(3000)
      .style("fill", "green")
      .attr("width", function(d,i) {
          return d*1.5;
        })

selection.exit()
  .attr("opacity", 1)
  .transition()
  .duration(3000)
    .attr("opacity", 0)
    .remove();
"""

# -----------------------------------------------
slide.code_title(title = ".data(..., join)");

init_svg = (parent) ->
  empty_svg(parent);
  svg.selectAll("rect")
    .data([64, 128, 256])
    .enter().append("rect")
      .attr("x", 0)
      .attr("y", (d,i) -> i*90+50)
      .attr("width", (d,i) -> d)
      .attr("height", 20)
      .style("fill", "steelblue")

slide.code title, init_svg, """
// Let"s say we start here:
/*
svg.selectAll("rect")
  .data([64, 128, 256])
  .enter().append("rect")
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
*/
// And then we do this:

var selection = svg.selectAll("rect")
  .data([128, 256, 71]) // <- incomplete?

selection.enter().append("rect")
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")

selection
  .transition()
  .duration(3000)
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")

selection.exit()
  .remove()

// Note that String(5) === "5"
"""

slide.code title, init_svg, """
// Start the same as before

var selection = svg.selectAll("rect")
  .data([128, 256, 71], String)

selection.enter().append("rect")
  .attr("x", 0)
  .attr("y", function(d,i) {
      return (i+1)*100+50
    })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
  .style("opacity", 0)

selection
  .transition()
  .duration(3000)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("height", 20)
    .style("opacity", 1)

selection.exit()
  .transition()
  .duration(3000)
    .attr("y", function(d,i) {
        return (i-1)*100+50
      })
    .style("opacity", 0)
    .remove()
"""

# -----------------------------------------------
slide.title("Educational Examples");

slide.code "Shuffle", empty_svg, """
var cards = [
  "J\\u2665", "J\\u2666", "J\\u2663", "J\\u2660",
  "K\\u2665", "K\\u2666", "K\\u2663", "K\\u2660",
  "Q\\u2665", "Q\\u2666", "Q\\u2663", "Q\\u2660",
  "A\\u2665", "A\\u2666", "A\\u2663", "A\\u2660"]

cards.sort(function() {return Math.random()-.5})

var selection = svg.selectAll("text")
  .data(cards, String)

selection
  .transition()
  .duration(1000)
    .attr("y", function(d,i) { return i*35+40 })

selection.enter().append("text")
  .attr("x", 30)
  .attr("y", function(d,i) { return i*35+40 })
  .style("fill", function(d) {
      return "\\u2665\\u2666".indexOf(d[1]) < 0 ?
        "black" : "red";
    })
  .style("font", "20px monospace")
  .text(String)
"""

slide.code "Shuffle (v2)", empty_svg, """
var cards = [
  "J\\u2665", "J\\u2666", "J\\u2663", "J\\u2660",
  "K\\u2665", "K\\u2666", "K\\u2663", "K\\u2660",
  "Q\\u2665", "Q\\u2666", "Q\\u2663", "Q\\u2660",
  "A\\u2665", "A\\u2666", "A\\u2663", "A\\u2660"]

cards.sort(function() {return Math.random()-.5})

var selection = svg.selectAll("text")
  .data(cards, String)

selection
  .transition().duration(500)
  .attr("x", function(d,i) {return (i%8)*30+30})
  .transition().duration(500).delay(500)
  .attr("y", function(d,i) { return i*35+40 })
  .transition().duration(500).delay(1000)
  .attr("x", 30)

selection.enter().append("text")
  .attr("x", 30)
  .attr("y", function(d,i) { return i*35+40 })
  .style("fill", function(d) {
      return "\\u2665\\u2666".indexOf(d[1]) < 0 ?
        "black" : "red";
    })
  .style("font", "20px monospace")
  .text(String)
"""

# -----------------------------------------------
slide.code "Drawing lines", empty_svg, """
svg.append("path")
  .style("fill", "none")
  .style("stroke", "black")
  .style("stroke-width", 2)
  .attr("d", "M 10 10 L 200 200 "+
             "L 200 400 L 300 100 L 400 150")
"""

slide.code "Drawing lines", empty_svg, """
var points = [
  { x: 10,  y: 10  },
  { x: 200, y: 200 },
  { x: 200, y: 400 },
  { x: 300, y: 100 },
  { x: 400, y: 150 }
]

var lineFn = d3.svg.line()
  .x(function(d) { return d.x })
  .y(function(d) { return d.y })

svg.append("path").data([points])
  .style("fill", "none")
  .style("stroke", "black")
  .style("stroke-width", 2)
  .attr("d", lineFn)
"""

slide.code "Drawing lines", empty_svg, """
var pointsSin = d3.range(20).map(function(i) {
  return {x: i/19, y: (Math.sin(i/3) + 1) / 2}
})
var pointsCos = d3.range(20).map(function(i) {
  return {x: i/19, y: (Math.cos(i/3) + 1) / 2}
})


var w = 480
var h = 300
var x = d3.scale.linear()
          .domain([0, 1]).range([0, w])
var y = d3.scale.linear()
          .domain([0, 1]).range([h, 0])

var lineFn = d3.svg.line()
  .x(function(d) { return x(d.x); })
  .y(function(d) { return y(d.y); })

svg.selectAll("path")
  .data([pointsSin, pointsCos])
  .enter().append("path")
  .style("fill", "none")
  .style("stroke", "black")
  .style("stroke-width", 2)
  .attr("d", lineFn)
"""

