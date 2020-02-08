class ConnectionBranches < StandardError
end

class ConnectedDevice
  include ActiveModel::Model

  attr_accessor :device
  delegate :name, to: :device

  def devices_on_path port:
    connections = connections_at(port: port)
    raise ConnectionBranches.new("Connection at port #{port} is not unique") if connections.length > 1

    return nil if connections.length == 0

    bad_iterative = []

    connection = connections.first
    bad_iterative << connection
    # GOSH informatics 101 TODO this is just horrible code
    max_hops = 10
    num_hops = 1
    while (connection.next_hop && connection = Connection.new(link: connection.next_hop, source: connection.target)) && num_hops < max_hops
      bad_iterative << connection
      num_hops += 1
    end

    bad_iterative.map{|c| c.target}

    #next_device = ConnectedDevice.new device: connection.target

    #return [next_device + next_device.devices_on_path(port: connection.target_slot)]
    ## TODO make it enumerator
  end

  def connections
    @connections ||= load_connections
  end

  def connections_at port:, incoming_link: nil
    if incoming_link
      connections.select do |connection|
        connection.source_slot == port && connection.link != incoming_link
      end
    else
      connections.select{|connection| connection.source_slot == port}
    end
  end

  private

  def load_connections
    connections = @device.links.map do |link|
      Connection.new link: link, source: @device
    end
  end
end
