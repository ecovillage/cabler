# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Graph
  attr_reader :g

  def initialize devices: nil, locations: nil, group_locations: true
    @g = GraphViz.new(:G, type: :graph, use: "dot")
    #g = GraphViz.new(:G, type: :digraph, use: "fdp")

    @g["rankdir"] = "LR"

    @g["nodesep"] = "2"

    @devices = devices || Device.all
    @locations = locations || Location.all
    @links = Link.all


    @nodes = {}

    @locations.each do |location|
      location_node = @g.add_nodes(location.human_identifier)
      location_node[:shape]='ellipse'
      location_node[:href]='ellipse'
      @nodes[location] = location_node
    end

    @devices.each do |device|
      device_node = @g.add_nodes(device.human_identifier)
      #device_node[:shape] = 'box3d'
      device_node[:shape]='record'
      device_node[:label] = "{#{device.human_identifier}|<p0> 1|<p1> 2|<p2> 3|<p3> 4|<p4> 5|<p5> 6}"
      device_nodes[device] = device_node
      nodes[device] = device_node
    end


    @devices.each do |device|
      if device.location
        edge = @g.add_edges(@nodes[device], @nodes[device.location]) #, label: '<<br>html</br>label!>'
        edge[:arrowhead] = "none"
        #edge[:label] = "@"
        #edge[:href] = "@"
      end
      #connected_device = ConnectedDevice.new(device)
    end

    @links.each do |link|
      if link.one_end && link.other_end
        edge = @g.add_edges(
          {@nodes[link.one_end] => "p#{link.slot_one_end}"},
          {@nodes[link.other_end] => "p#{link.slot_other_end}"}
        )
        edge[:label] = link.name
        edge[:arrowhead] = "normal"
        edge[:arrowtail] = "normal"
        edge[:dir] = "both"
      end
      #g.add_edges
    end
  end

  def to_svg
    @g.output svg: String
  end

  def to_png
    @g.output png: String 
  end

  def to_dot
    @g.output canon: String
  end

  private

  def add_node_with_ports device
    device_node = @g.add_nodes(device.human_identifier, shape: 'record')
    label = device.human_identifier
    (device.num_links || 0).times do |idx|
      label += "|<p#{idx}> #{idx+1}"
    end
    device_node[:label] = "{%s}" % label
    @nodes[device] = device_node
  end


  def add_node
  end

  def add_edge
  end
end
