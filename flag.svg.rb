require "erb"

template = ERB.new <<~SVG
  <svg width="1920" height="960" xmlns="http://www.w3.org/2000/svg">
    <rect width="480" height="960" x="0" y="0" fill="#ef3340" />
    <rect width="960" height="960" x="480" y="0" fill="white" />
    <rect width="480" height="960" x="1440" y="0" fill="#ef3340" />
    <% points.each do |point| %>
    <circle r="13" cx="<%= point[0] + 960 %>" cy="<%= 480 - point[1] %>" fill="#ef3340" />
    <% end %>
  </svg> 
SVG

File.write(File.join(__dir__, "flag.svg"), template.result)
