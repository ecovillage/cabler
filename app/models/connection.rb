class Connection
  include ActiveModel::Model

  attr_accessor :link, :source_slot, :source, :target_slot, :target

  delegate :name, to: :link

  def initialize link:, source:
    @source = source
    @link = link
    if link.one_end == @source
      @source_slot = link.slot_one_end
      @target      = link.other_end
      @target_slot = link.slot_other_end
    else
      @source_slot = link.slot_other_end
      @target      = link.one_end
      @target_slot = link.slot_one_end
    end
  end

  def next_hop
    if target.instance_of? Location
      return nil
    elsif !target.connector?
      nil
    else
      target_device = ConnectedDevice.new(device: target)
      connections = target_device.connections_at port: target_slot, incoming_link: @link
      raise ConnectionBranches.new("next hop unclear") if connections.length > 1
      connections.first.link
    end
  end

  def next_connection
    if target.instance_of? Location
      return nil
    elsif !target&.connector?
      nil
    else
      target_device = ConnectedDevice.new(device: target)
      connections = target_device.connections_at port: target_slot, incoming_link: @link
      raise ConnectionBranches.new("next hop unclear") if connections.length > 1
      return nil if connections.empty?

      connection = connections.first
    end
  end
end
