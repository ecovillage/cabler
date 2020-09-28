# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Implementation is a total hack
# still need to figure out how a sensible output would look like
class Graph
  include Rails.application.routes.url_helpers

  attr_reader :g, :nodes

  # box_locations: draw a frame around locations and group
  #                devices in them
  # see https://graphviz.gitlab.io/
  # rankdir:       Top-Bottom ('TB') or Left-Right ('LR')
  # splines:       ['ortho']
  # show_ports     ['all', 'filled', 'none']
  def initialize(group_locations: true,
    rankdir:         'TB',
    splines:         'line',
    box_locations:   true,
    algorithm:       'dot',
    label_edge_ends: true,
    show_ports:      :only_filled)

    # Other popular options:
    #  type: :digraph, use: "fdp"
    #  type: :digraph, use: "circo"
    #  ...
    @g = GraphViz.new(:G, type: :graph, use: algorithm)

    @g["rankdir"] = rankdir
    @g["splines"] = splines

    @g["nodesep"] = "2"

    @show_ports      = show_ports
    @label_edge_ends = label_edge_ends

    @devices     = Device.all
    @links       = Link.all

    # Subgraphs / clusters
    @location_clusters = {}

    @nodes = {}

    if box_locations
      create_location_clusers
    end

    add_device_nodes(@devices.includes(:location))

    # if show_locations
    #@devices.each do |device|
    #  if device.location
    #    edge = @g.add_edges(@nodes[device], @nodes[device.location]) #, label: '<<br>html</br>label!>'
    #    edge[:arrowhead] = "none"
    #    #edge[:label] = "@"
    #    #edge[:href] = "@"
    #  end
    #end

    add_links(@links.includes(:one_end, :other_end))
  end

  # scale shall be in percent (e.g. '100%')
  def to_svg(scale: nil, id: nil, classes: 'pannable')
    svg = @g.output svg: String
    if scale.nil?
      svg
    else
      xml = Nokogiri.XML(svg)
      xml.at('svg')['width']  = scale
      xml.at('svg')['height'] = scale
      xml.at('svg')['class']  = classes
      if id
        xml.at('svg')['id']  = id
      end
      xml
    end
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
      node[:style] = 'filled'
      node[:fillcolor] = '#ffffff'
      @nodes[object] = node
    else
      node = graph_for(object).add_nodes(object.human_identifier)
      @nodes[object] = node
    end
  end

  def add_device_nodes(devices)
    devices.find_each do |device|
      add_device_node_with_ports device
      #device_node = @g.add_nodes(device.human_identifier)
      ##device_node[:shape] = 'box3d'
      #device_node[:shape]='record'
      #device_node[:label] = "{#{device.human_identifier}|<p0> 1|<p1> 2|<p2> 3|<p3> 4|<p4> 5|<p5> 6}"
      #device_nodes[device] = device_node
      #nodes[device] = device_node
    end
  end

  def add_device_node_with_ports device
    # node_for would suffice
    device_node = graph_for(device.location).add_nodes(device.human_identifier, shape: 'record')
    label = device.human_identifier
    if @show_ports == :all
      (device.num_links || 0).times do |idx|
        label += "|<p#{idx+1}> #{idx+1}"
      end
    end
    if @show_ports == :only_filled || (@show_ports == :all && !device.num_links)
      device.links.map {|l| l.port_for(device)}.compact.uniq.sort.each do |port|
        label += "|<p#{port}> #{port}"
      end
    end
    device_node[:label] = "{%s}" % label
    device_node[:fontname] = 'Arial'
    device_node[:href]  = device_path(device)
    device_node[:style]     = 'filled'
    device_node[:fillcolor] = '#fefefe'
    @nodes[device] = device_node
  end

  def add_links(links)
    links.find_each do |link|
      if link.one_end && link.other_end
        edge = @g.add_edges(
          {node_for(link.one_end)   => "p#{link.port_one_end}"},
          {node_for(link.other_end) => "p#{link.port_other_end}"}
        )
        edge[:label]     = link.name
        edge[:arrowhead] = "normal"
        if @label_edge_ends
          edge[:headlabel] = link.port_other_end
          edge[:taillabel] = link.port_one_end
        end
        edge[:fontname]  = "Arial"
        edge[:arrowtail] = "normal"
        edge[:dir]       = "both"
        edge[:labeltooltip] = "tooltip"
      end
    end
  end

  def create_location_clusers
    Location.roots.find_each do |location|
      c = @g.add_graph("cluster_#{location.object_id}")
      c[:label]   = location.human_identifier
      c[:style]     = 'filled'
      c[:fillcolor] = '#f2f2f2'
      c[:fontname] = 'Arial'
      c[:rankdir] = 'TB'
      c[:href]    = Rails.application.routes.url_helpers.location_path(location)
      @location_clusters[location] = c

      add_child_locations(location)
    end
  end

  def add_child_locations location
    location.children.find_each do |child_location|
      Rails.logger.debug 'bla'
      c = graph_for(location).add_graph("cluster_#{child_location.object_id}")
      c[:label]   = child_location.human_identifier
      c[:style]     = 'filled'
      c[:fillcolor] = '#f9f9f9'
      c[:fontname] = 'Arial'
      c[:rankdir] = 'TB'
      c[:href]    = Rails.application.routes.url_helpers.location_path(child_location)
      @location_clusters[child_location] = c
      add_child_locations(child_location)
    end
  end
end
