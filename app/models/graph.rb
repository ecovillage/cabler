# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Graph
  include Rails.application.routes.url_helpers

  attr_reader :g

  # box_locations: draw a frame around locations and group
  #                devices in them
  # see https://graphviz.gitlab.io/
  # rankdir:       Top-Bottom ('TB') or Left-Right ('LR')
  # splines:       ['ortho']
  def initialize(devices: nil,
    locations: nil,
    group_locations: true,
    rankdir: 'TB',
    splines: 'line',
    box_locations: true)

    # Other popular options:
    #  type: :digraph, use: "fdp"
    #  type: :digraph, use: "circo"
    #  ...
    @g = GraphViz.new(:G, type: :graph, use: "dot")

    @g["rankdir"] = rankdir
    @g["splines"] = splines

    @g["nodesep"] = "2"

    @devices   = devices || Device.all
    @locations = locations || Location.all
    @links     = Link.all

    # Subgraphs / clusters
    @location_clusters = {}

    @nodes = {}

    if box_locations
      @locations.each do |location|
        c = @g.add_graph("cluster_#{location.object_id}")
        c[:label]   = location.human_identifier
        c[:rankdir] = 'TB'
        c[:href]    = location_path(location)
        @location_clusters[location] = c
      end
    end

    @devices.each do |device|
      add_device_node_with_ports device
      #device_node = @g.add_nodes(device.human_identifier)
      ##device_node[:shape] = 'box3d'
      #device_node[:shape]='record'
      #device_node[:label] = "{#{device.human_identifier}|<p0> 1|<p1> 2|<p2> 3|<p3> 4|<p4> 5|<p5> 6}"
      #device_nodes[device] = device_node
      #nodes[device] = device_node
    end


    # if show_locations
    #@devices.each do |device|
    #  if device.location
    #    edge = @g.add_edges(@nodes[device], @nodes[device.location]) #, label: '<<br>html</br>label!>'
    #    edge[:arrowhead] = "none"
    #    #edge[:label] = "@"
    #    #edge[:href] = "@"
    #  end
    #end

    @links.each do |link|
      if link.one_end && link.other_end
        edge = @g.add_edges(
          {node_for(link.one_end)   => "p#{link.slot_one_end}"},
          {node_for(link.other_end) => "p#{link.slot_other_end}"}
        )
        edge[:label]     = link.name
        edge[:arrowhead] = "normal"
        edge[:arrowtail] = "normal"
        edge[:dir]       = "both"
      end
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

  # Allow locations to be in clusters (or not)
  def graph_for object
    @location_clusters[object] || @g
  end

  def node_for object
    return @nodes[object] if @nodes[object]
    if object.instance_of? Location
        #location_node[:shape]='ellipse'
        #location_node[:href]='ellipse'
      node = graph_for(object).add_nodes(object.human_identifier)
      @nodes[object] = node
    end
  end

  def add_device_node_with_ports device
    # node_for would suffice
    device_node = graph_for(device.location).add_nodes(device.human_identifier, shape: 'record')
    label = device.human_identifier
    (device.num_links || 0).times do |idx|
      label += "|<p#{idx}> #{idx+1}"
    end
    device_node[:label] = "{%s}" % label
    device_node[:href]  = device_path(device)
    @nodes[device] = device_node
  end


  def add_node
  end

  def add_edge
  end
end
