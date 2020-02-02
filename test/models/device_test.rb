require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  test "name is validated" do
    device = Device.new
    assert_not device.save

    device = Device.new(name: 'AB Switch')
    assert device.save
  end

  test "link association" do
    device = Device.new(name: 'AB Switch')
    assert device.save

    device.link.create(name: 'red cable')

    assert device.save
    assert_equal 1, device.links.count
  end
end
