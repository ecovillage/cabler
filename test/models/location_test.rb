require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "validates" do
    assert !Location.new.save
  end
end
