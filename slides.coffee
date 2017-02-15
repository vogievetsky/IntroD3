empty_svg = ->
  d3.select('div.output')
    .append('svg')

rect1 = ->
  svg = d3.select('div.output')
    .append('svg')

  svg.append("rect")
    .attr("x", 150)
    .attr("y", 100)
    .attr("width", 60)
    .attr("height", 300)


rect3 = ->
  svg = d3.select('div.output')
    .append('svg')

  svg.append("rect")
    .attr("x", 200)
    .attr("y", 300)
    .attr("width", 40)
    .attr("height", 50)

  svg.append("rect")
    .attr("x", 100)
    .attr("y", 20)
    .attr("width", 30)
    .attr("height", 50)

  svg.append("rect")
    .attr("x", 10)
    .attr("y", 200)
    .attr("width", 25)
    .attr("height", 90)

# ----------------------------------------------------

slide.title "First, some JavaScript"

slide.code "JavaScript", null, """
// In JS functions are first class citizens.
// This is a very powerful concept!
function sq1(x) {
  return x * x
}

var sq2 = function(x) {
  return x * x
}

console.log("sq1(4) ==", sq1(4)) // == 16
console.log("sq2(4) ==", sq2(4)) // == 16

sq1.foo = 8
sq2.bar = 3

console.log("Trippy:", sq1(sq1.foo + sq2.bar))
"""

slide.code "JavaScript to the Max", null, """
// Functions can be used to 'bake in' state

var formatter = function(prefix, fixed) {
  if (prefix == null) { prefix = '' }
  if (fixed == null) { fixed = 2 }
  return function(number) {
    return prefix + number.toFixed(fixed)
  }
}

var currency = formatter('$', 2)
var roughly = formatter('~ ', 1)

console.log("currency(31/3) ==", currency(31/3))

console.log("roughly(31/3) ==", roughly(31/3))
"""

slide.code "JavaScript to the Max", null, """
// D3 has many helper methods
// d3.scaleLinear() returns a function that
// will map the given domain to the given
// range linearly.

// D3 v4 change: d3.scaleLinear was 
// d3.scale.linear in v3
var w = 640, h = 320

// x is a function!
var x = d3.scaleLinear()
  .domain([-1, 1])
  .range([0, w])

// y is also a function!
var y = d3.scaleLinear()
  .domain([0, 1])
  .range([0, h])

console.log("x(0) ==", x(0)) // == w/2
console.log("y(3) ==", y(3)) // == 3*h
"""

slide.title "Core D3"

# -----------------------------------------------
slide.code_title title = ".select()"

slide.code title, rect1, """
var svg = d3.select("div.output svg")


var myRect = svg.select("rect")
myRect.attr("width", 100)
myRect.attr("height", 100)
myRect.style("fill", "steelblue")
"""

slide.code title, rect1, """
var svg = d3.select("div.output svg")

// Chain style
svg.select("rect")
  .attr("width", 100)
  .attr("height", 100)
  .style("fill", "steelblue")
"""

slide.code title, rect1, """
var svg = d3.select("div.output svg")

// Object map style
// NOT RECOMMENDED in D3 v4
// IMPORTANT: this requires d3-selection-multi
//   to be loaded as a separate plugin library;
//   it is not part of the default bundle
// https://d3js.org/d3-selection-multi.v1.min.js

// D3 v4 change .attrs instead of .attr
svg.select("rect")
  .attrs({
    width: 100,
    height: 100
  })
  .style("fill", "steelblue")
"""

# -----------------------------------------------
slide.code_title title = ".selectAll()"

slide.code title, rect3, """
var svg = d3.select("div.output svg")

svg.select("rect")
  .attr("width", 100)
  .attr("height", 100)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
var svg = d3.select("div.output svg")

svg.selectAll("rect")
  .attr("width", 100)
  .attr("height", 100)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
var svg = d3.select("div.output svg")

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
slide.code_title title = ".data()"

slide.code title, rect3, """
var svg = d3.select("div.output svg")

svg.selectAll("rect")
  .data([127, 61, 256])
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

# -----------------------------------------------
slide.code_title title = ".enter()"

slide.code title, rect3, """
var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([127, 61, 256, 71])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([127, 61, 256, 71])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")

selection.enter().append("rect")
  .attr("x", 10) // let's just put it somewhere
  .attr("y", 10)
  .attr("width", 30)
  .attr("height", 30)
  .style("fill", "green")
"""

slide.code title, rect3, """
var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([127, 61, 256, 71])

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
var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([127, 61, 256, 71])

// Shorter
// D3 v4 change: in v3, selections
// were mutable and enter changed selection
// now, merge makes this explicit
selection.enter().append("rect")
  .merge(selection)
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
"""

title += " // a common pattern"
slide.code title, empty_svg, """
var svg = d3.select("div.output svg")

svg.selectAll("rect")
  .data([127, 61, 256])
  .enter().append("rect")
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
"""


# -----------------------------------------------
slide.code_title title = ".exit()"

slide.code title, rect3, """
var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([127, 61])

selection
  .attr("x", 0)
  .attr("y", function(d,i) { return i*90+50 })
  .attr("width", function(d,i) { return d; })
  .attr("height", 20)
  .style("fill", "steelblue")
"""

slide.code title, rect3, """
var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([127, 61])

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
slide.code_title title = ".transition()"

slide.code title, rect3, """
var svg = d3.select("div.output svg")

svg.selectAll("rect")
  .data([127, 61, 256])
  .transition()
  .duration(3000) // 3 seconds
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
"""

slide.code title, rect3, """
var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([127, 61, 256, 71])

selection.enter().append("rect")
    .attr("x", 200)
    .attr("y", 200)
    .attr("width", 10)
    .attr("height", 10)
    .style("fill", "red")
  .merge(selection)
    .transition()
    .duration(3000)
      .attr("x", 0)
      .attr("y", function(d,i) { return i*90+50 })
      .attr("width", function(d,i) { return d; })
      .attr("height", 20)
      .style("fill", "steelblue")
      .transition()
      // D3 v4 change: delays relative
      //  to previous transition (none needed)
      .duration(3000)
        .style("fill", "green")
        .attr("width", function(d,i) {
            return d*1.5;
          })

selection.exit()
  .attr("opacity", 1)
  .transition()
  .duration(3000)
    .attr("opacity", 0)
    .remove()
"""

# -----------------------------------------------
slide.code_title title = ".data(..., join)"

init_svg = ->
  svg = d3.select("div.output").append("svg")

  svg.selectAll("rect")
    .data([127, 61, 256])
    .enter().append("rect")
      .attr("x", 0)
      .attr("y", (d,i) -> i*90+50)
      .attr("width", (d,i) -> d)
      .attr("height", 20)
      .style("fill", "steelblue")

slide.code title, init_svg, """
var svg = d3.select("div.output svg")

// Let's say we start here:
/*
svg.selectAll("rect")
  .data([127, 61, 256])
  .enter().append("rect")
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
*/

// And then we do this:
var selection = svg.selectAll("rect")
  .data([61, 256, 71]) // <- incomplete?

selection.enter().append("rect")
    .attr("x", 0)
    .attr("y", function(d,i) { return i*90+50 })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
  .merge(selection)
    .transition()
    .duration(3000)
      .attr("x", 0)
      .attr("y", function(d,i) { return i*90+50 })
      .attr("width", function(d,i) { return d; })
      .attr("height", 20)
      .style("fill", "steelblue")

selection.exit()
  .remove()
"""

slide.code title, init_svg, """
// Start the same as before

var svg = d3.select("div.output svg")

var selection = svg.selectAll("rect")
  .data([61, 256, 71], function(d) { return d; })

selection.enter().append("rect")
    .attr("x", 0)
    .attr("y", function(d,i) {
        return (i+1)*90+50
      })
    .attr("width", function(d,i) { return d; })
    .attr("height", 20)
    .style("fill", "steelblue")
    .style("opacity", 0)
  .merge(selection)
    .transition()
    .duration(3000)
      .attr("y", function(d,i) { return i*90+50 })
      .attr("height", 20)
      .style("opacity", 1)

selection.exit()
  .transition()
  .duration(3000)
    .attr("y", function(d,i) {
        return (i-1)*90+50
      })
    .style("opacity", 0)
    .remove()
"""

# -----------------------------------------------
slide.title title = "Nested Selections"

slide.code title, empty_svg, """
var myData = [
  [15, 20],
  [40, 10],
  [30, 17]
]

var svg = d3.select("div.output svg")

// First selection (within svg)

var selA = svg.selectAll("g").data(myData)
var merged = selA.enter().append("g")
  .merge(selA)
    .attr("transform", function(d,i) {
      return 'translate(70,' + (i*100+50) + ')' })
selA.exit().remove()

// Second selection (within first selection)

var selB = merged.selectAll('circle')
  .data(function(d) { return d })
selB.enter().append('circle')
  .merge(selB)
    .attr("cx", function(d,i) { return i*80 })
    .attr("r", function(d,i) { return d })
selB.exit().remove()
"""

# -----------------------------------------------
slide.title "Useful Examples"

slide.code "Shuffle", empty_svg, """
var cards = [
  "J\\u2665", "J\\u2666", "J\\u2663", "J\\u2660",
  "K\\u2665", "K\\u2666", "K\\u2663", "K\\u2660",
  "Q\\u2665", "Q\\u2666", "Q\\u2663", "Q\\u2660",
  "A\\u2665", "A\\u2666", "A\\u2663", "A\\u2660"]

cards.sort(function() {return Math.random()-.5})

var svg = d3.select("div.output svg")

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

var svg = d3.select("div.output svg")

var selection = svg.selectAll("text")
  .data(cards, String)

selection
  .transition().duration(500)
  .attr("x", function(d,i) {return (i%8)*30+30})
  .transition().duration(500)
  .attr("y", function(d,i) { return i*35+40 })
  .transition().duration(500)
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
var svg = d3.select("div.output svg")

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

// D3 v4 change: d3.line was d3.svg.line in v3
var lineFn = d3.line()
  .x(function(d) { return d.x })
  .y(function(d) { return d.y })
  // D3 v4 change: .curve(d3.curveCardinal) was
  // .interpolate("cardinal") in v3
  //.curve(d3.curveCardinal)

var svg = d3.select("div.output svg")

svg.append("path")
  .style("fill", "none")
  .style("stroke", "black")
  .style("stroke-width", 2)
  .attr("d", lineFn(points))
"""

slide.code "Drawing lines", empty_svg, """
var pointsSin = d3.range(21).map(function(i) {
  return {x: i, y: Math.sin(i/3) }
})
var pointsCos = d3.range(21).map(function(i) {
  return {x: i, y: Math.cos(i/3) }
})


var w = 480
var h = 300
var x = d3.scaleLinear()
          .domain([0, 20]).range([0, w])
var y = d3.scaleLinear()
          .domain([-1, 1]).range([h, 0])

var lineFn = d3.line()
  .x(function(d) { return x(d.x) })
  .y(function(d) { return y(d.y) })

var svg = d3.select("div.output svg")

svg.selectAll("path")
  .data([pointsSin, pointsCos])
  .enter().append("path")
  .style("fill", "none")
  .style("stroke", "black")
  .style("stroke-width", 2)
  .attr("d", lineFn)
"""

