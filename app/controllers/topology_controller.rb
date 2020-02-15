# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class TopologyController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def show
    g = GraphViz.new(:G, type: :digraph)
    #g = GraphViz.new(:G, type: :digraph, use: "fdp")
    #g["rankdir"] = "LR"

    @devices = Device.all
    @locations = Location.all
    @links = Link.all

    device_nodes = {}
    location_nodes = {}

    nodes = {}

    @devices.each do |device|
      device_node = g.add_nodes(device.human_identifier)
      device_node[:shape] = 'box3d'
      device_node[:shape]='record'
      device_node[:label] = "{#{device.human_identifier}|<p0> 1|<p1> 2|<p2> 3|<p3> 4|<p4> 5|<p5> 6}"
      device_nodes[device] = device_node
      nodes[device] = device_node
    end

    @locations.each do |location|
      location_node = g.add_nodes(location.human_identifier)
      location_node[:shape]='ellipse'
      location_nodes[location] = location_node
      nodes[location] = location_node
    end


    @devices.each do |device|
      if device.location
        edge = g.add_edges(device_nodes[device], location_nodes[device.location])
        #edge[:label] = "@"
      end
      #connected_device = ConnectedDevice.new(device)
    end

    @links.each do |link|
      if link.one_end && link.other_end
        edge = g.add_edges(
          {nodes[link.one_end] => "p#{link.slot_one_end}"},
          {nodes[link.other_end] => "p#{link.slot_other_end}"}
        )
        edge[:label] = link.name
      end
      #g.add_edges
    end

    respond_to do |format|
      format.html { @png = g.output png: String }
      format.png { render plain: g.output(png: String) }
      format.svg { render plain: g.output(svg: String) }
      format.dot { render plain: g.output(dot: String) }
      #TODO better: send_data , send_file for .dot
    end
  end
end
