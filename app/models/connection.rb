# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Decorator around a Link with a direction (seen from _one_ device or location).
class Connection
  include ActiveModel::Model

  attr_accessor :link, :source_port, :source, :target_port, :target

  delegate :name, :kind, to: :link

  def initialize link:, source:
    @source = source
    @link = link
    if link.one_end == @source
      @source_port = link.port_one_end
      @target      = link.other_end
      @target_port = link.port_other_end
    else
      @source_port = link.port_other_end
      @target      = link.one_end
      @target_port = link.port_one_end
    end
  end

  def next_hop
    if target.instance_of? Location
      return nil
    elsif !target.connector?
      nil
    else
      target_device = ConnectedDevice.new(device: target)
      connections = target_device.connections_at port: target_port, incoming_link: @link
      raise ConnectionBranches.new("next hop unclear") if connections.length > 1
      connections.first.link
    end
  end

  def next_connection
    return @next_connection if @next_connection

    if target.instance_of? Location
      return nil
    elsif !target&.connector?
      nil
    else
      target_device = ConnectedDevice.new(device: target)
      connections = target_device.connections_at port: target_port, incoming_link: @link
      raise ConnectionBranches.new("next hop unclear") if connections.length > 1
      return nil if connections.empty?

      @next_connection = connections.first
    end
  end
end
