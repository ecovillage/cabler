require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase
  test "gets source and target right" do
    connection = Connection.new link: links(:tln1_router), source: devices(:router)

    assert_equal devices(:tln1), connection.target
    assert_equal 2, connection.source_slot
    assert_equal 1, connection.target_slot

    connection = Connection.new link: links(:ppb_tln1), source: devices(:tln1)

    assert_equal devices(:ppb), connection.target
    assert_equal 2, connection.source_slot
    assert_equal 3, connection.target_slot
  end

  test "raises if path unclear" do
    ppb = devices(:ppb)

    origin = ConnectedDevice.new(device: ppb)

    assert_raises ConnectionBranches do
      origin.devices_on_path(port: 3)
    end
  end

  test "#next_hop returns nil for location target" do
    connection = Connection.new(link: links(:floor_tln1), source: devices(:tln1))
    refute connection.next_hop
  end

  test "#next_hop returns nil for no connectors" do
    connection = Connection.new(link: links(:tln2_ppo), source: devices(:ppo))
    refute connection.next_hop
  end


  test "finds next hop of connectors" do
    connection = Connection.new(link: links(:ppb_tln1), source: devices(:tln1))
    assert connection.next_hop
    assert_equal links(:ppb_ppo), connection.next_hop
  end

  test "finds a path" do
    tln1 = devices(:tln1)

    origin = ConnectedDevice.new(device: tln1)

    assert_equal [devices(:ppb), devices(:ppo), devices(:tln2)], origin.devices_on_path(port: 2)
  end
end

