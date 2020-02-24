class ConnectionBranches < StandardError
end

# Decorator around a Device or location with advanced querying functionality.
class ConnectedDevice
  include ActiveModel::Model

  attr_accessor :device
  delegate :id, :name, :human_identifier, :url, to: :device

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
