# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class GraphTest < ActiveSupport::TestCase
  test 'creates correct .dot representation' do
    skip 'tbi'
  end

  test 'creates correct representation' do
    graph = Graph.new(group_locations: false)

    assert_equal 7, graph.nodes.count

    assert_equal 7, graph.g.graph_count

    # count nodes and edges over all nested graphs
    # pick specific device and check its edges
    # pick specific location and check its edges

    assert_equal 7, graph.g.node_count
  end
end

