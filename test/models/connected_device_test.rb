require 'test_helper'

class ConnectedDeviceTest < ActiveSupport::TestCase
  test 'loads connections' do
    device = ConnectedDevice.new(device: devices(:tln1))
    assert_equal 4, device.connections.count
  end

  test 'finds connection at slot' do
    device = ConnectedDevice.new(device: devices(:tln1))
    connections = device.connections_at port: 1

    assert_equal 1, connections.count
    connection = connections.first

    assert_equal devices(:router), connection.target
  end

  test 'finds connections at slot' do
    device = ConnectedDevice.new(device: devices(:ppb))
    connections = device.connections_at port: 3

    assert_equal 2, connections.count
    assert_equal [devices(:tln1), devices(:ppo)], connections.map(&:target)
  end
end

