# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class SingleDeviceGraph
  include Rails.application.routes.url_helpers

  attr_reader :g

  def initialize device: device
    @device = device
    @nodes  = {}

    algorithm = 'dot'
    @g = GraphViz.new(:G, type: :graph, use: algorithm)
    @g["rankdir"] = 'TB'
    @g["esep"] = '1'
    @g["overlap"] = 'scale'
    @g["splines"] = 'ortho'

    add_device_node_with_ports @device

    @device.links.each do |link|
      add_edge link
    end
  end

  def node_for object
    return @nodes[object] if @nodes[object]

    if object.instance_of? Location
      node = graph_for(object).add_nodes(object.human_identifier)
      node[:href] = location_path(object)
    else
      node = graph_for(object).add_nodes(object.human_identifier)
      node[:href] = device_path(object)
      if object.connector?
        node[:shape] = 'box'
      end
    end
    node[:fontname] = "Arial"

    @nodes[object] = node
  end

  def add_device_node_with_ports device
    # probably node_for would suffice

    device_node = graph_for(device.location).add_nodes(device.human_identifier)
    device_node[:label] = DeviceGraph::LabelBuilder.label_for device
    device_node[:fontname] = "Arial"
    device_node[:style]    = "filled"
    device_node[:fillcolor] = "#eeeeee"
    device_node[:href]  = device_path(device)

    @nodes[device] = device_node
  end

  def graph_for object
    @g
  end

  def to_svg
    (@g.output svg: String).force_encoding 'UTF-8'
  end

  def to_png
    @g.output png: String 
  end

  def to_dot
    (@g.output canon: String).force_encoding 'UTF-8'
  end

  def add_edge link
    if link.one_end && link.other_end
      edge = @g.add_edges(
        {node_for(link.one_end)   => "p#{link.port_one_end}"},
        {node_for(link.other_end) => "p#{link.port_other_end}"}
      )
      edge[:label]     = link.name
      edge[:arrowhead] = "normal"
      edge[:arrowtail] = "normal"
      edge[:dir]       = "both"
      #edge[:labeltooltip] = "tooltip"
    end
  end
end
