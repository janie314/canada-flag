# frozen_string_literal: true

require 'erb'

def intersection(p)
  x = ( p[:d] - p[:b] - p[:c] * Math.tan(p[:a2]) + p[:a] * Math.tan(p[:a1]) ) / (Math.tan(p[:a1]) - Math.tan(p[:a2]))
  y = Math.tan(p[:a1]) * (x - p[:a]) + p[:b]
  {x: x, y: y}
end

def L(r, t)
  r / Math.tan(90 - t/2) 
end

def arc_point(p)

end

data = [
  {a: -18, b: -406, a1: 87, c: -203, d: -244, a2: 10, r: 19, t: 103 },
  {a: -203, b: -244, a1: 10, c: -372, d: -13, a2: 321, r: 13, t: 71},
  {a: -372, b: -13, a1: 321, c: -360, d: 137, a2: 288, r: 13, t: 83},
  {a: -360, b: 137, a1: 288, c: -216, d: 171, a2: 247, r: 13, t: 79},
  {a: -216, b: 171, a1: 247, c: -150, d: 302, a2: 281, r: 13, t: 148},
  {a: -150, b: 302, a1: 281, c: 0, d: 400, a2: 243, r: 13, t: 93},
]

template = ERB.new <<~SVG
  <svg width="1920" height="960" xmlns="http://www.w3.org/2000/svg">
    <rect width="480" height="960" x="0" y="0" fill="#ef3340" />
    <rect width="960" height="960" x="480" y="0" fill="white" />
    <rect width="480" height="960" x="1440" y="0" fill="#ef3340" />
    <% data.each do |p| %>
    <circle r="13" cx="<%= p[:a] + 960 %>" cy="<%= 480 - p[:b] %>" fill="#ef3340" />
    <% end %>
  </svg>
SVG

File.write(File.join(__dir__, 'flag.svg'), template.result)
