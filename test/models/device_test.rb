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

  test "human identifier defaults to name" do
    device = Device.new(name: 'ABS', model: 'TL2', manufacturer: 'Toolo')
    assert_equal 'ABS', device.human_identifier
  end

  test "human identifier uses model + kind + location if name not present" do
    device = Device.new(model: 'TL2', manufacturer: 'Toolo')
    assert_equal 'TL2', device.human_identifier

    device.kind = "Switch"
    assert_equal 'Switch TL2', device.human_identifier

    device.location = locations(:one)
    device.model = nil
    assert_equal 'Switch Basement', device.human_identifier
  end

end
