# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class SingleLocationGraph
  include Rails.application.routes.url_helpers

  attr_reader :g

  def initialize location: location
    @location = location
    @nodes    = {}
    @clusters = {}

    algorithm = 'dot'

    @g = GraphViz.new(:G, type: :graph, use: algorithm)
    @g["rankdir"] = 'TB'
    @g["esep"] = '1'
    @g["overlap"] = 'scale'
    @g["splines"] = 'multiline'

    location_root = @location
    while location_root.parent.present?
      location_root = location_root.parent
    end

    location_cluster = @g.add_graph("cluster_%s" % @location.object_id)
    location_cluster['label'] = @location.human_identifier
    @clusters[location] = location_cluster

    location.devices.find_each do |device|
      @nodes[device] = location_cluster.add_node(device.human_identifier)
    end

    location.devices.find_each do |device|
      device.links.each do |link|
        if @nodes[link.one_end] && @nodes[link.other_end]
          @g.add_edge(@nodes[link.one_end], @nodes[link.other_end])
        end
      end
    end
  end

  def to_svg
    # Modify to use width = 100%
    svg = (@g.output svg: String).force_encoding 'UTF-8'
    xml = Nokogiri.XML(svg)
    xml.at('svg')['width'] = "100%"
    #shape-rendering="crispEdges" for the rectangle, "auto" for others
    xml
  end

  def to_png
    @g.output png: String 
  end

  def to_dot
    (@g.output canon: String).force_encoding 'UTF-8'
  end
end
