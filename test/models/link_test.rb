require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "has polymorphic ends" do
    assert Link.new(one_end: devices(:one),
                   other_end: locations(:one)).save
  end

  test "#port_for answers correctly" do
    assert_equal 1, links(:tln1_router).port_for(devices(:tln1))
    assert_equal 2, links(:tln1_router).port_for(devices(:router))
    assert_equal nil, links(:tln1_router).port_for(devices(:tln2))
  end
end
