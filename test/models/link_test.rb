require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "has polymorphic ends" do
    assert Link.new(one_end: devices(:one),
                   other_end: locations(:one)).save
  end
end
