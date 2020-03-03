# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase
  test "gets source and target right" do
    connection = Connection.new link: links(:tln1_router), source: devices(:router)

    assert_equal devices(:tln1), connection.target
    assert_equal 2, connection.source_port
    assert_equal 1, connection.target_port

    connection = Connection.new link: links(:ppb_tln1), source: devices(:tln1)

    assert_equal devices(:ppb), connection.target
    assert_equal 2, connection.source_port
    assert_equal 3, connection.target_port
  end

  test "#next_connection returns nil for location target" do
    connection = Connection.new(link: links(:floor_tln1), source: devices(:tln1))
    refute connection.next_connection
  end

  test "#next_connection returns nil for no connectors" do
    connection = Connection.new(link: links(:tln2_ppo), source: devices(:ppo))
    refute connection.next_connection
  end


  test "finds connection hop of connectors" do
    connection = Connection.new(link: links(:ppb_tln1), source: devices(:tln1))
    assert connection.next_connection
    assert_equal links(:ppb_ppo), connection.next_connection.link
  end

  test "connection#next_connection is memoized" do
    connection = Connection.new(link: links(:ppb_tln1), source: devices(:tln1))
    first_call_next_connection = connection.next_connection
    second_call_next_connection = connection.next_connection
    assert first_call_next_connection.object_id == second_call_next_connection.object_id
  end

  test "finds next_connection" do
    connection = Connection.new(link: links(:ppb_tln1), source: devices(:tln1))
    assert connection.next_connection
    assert_equal links(:ppb_ppo), connection.next_connection.link
  end

  test "next_connection throws Branches if it does" do
    skip("implement me, create a situation where multiple connections are done to one port")
  end

end

