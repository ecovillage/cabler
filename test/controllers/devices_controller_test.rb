# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @device = devices(:one)
  end

  test "should not get index when unauthenticated" do
    get devices_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get devices_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_device_url
    assert_response :success
  end

  test "should create device" do
    sign_in users(:admin)
    assert_difference('Device.count') do
      post devices_url, params: { device: { kind: @device.kind, location_id: @device.location_id, name: @device.name + "non_unique" } }
    end

    assert_redirected_to device_url(Device.last)
  end

  test "should show device" do
    sign_in users(:admin)
    get device_url(@device)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_device_url(@device)
    assert_response :success
  end

  test "should update device" do
    sign_in users(:admin)
    patch device_url(@device), params: { device: { kind: @device.kind, location_id: @device.location_id, name: @device.name } }
    assert_redirected_to device_url(@device)
  end

  test "should destroy device" do
    sign_in users(:admin)
    assert_difference('Device.count', -1) do
      delete device_url(@device)
    end

    assert_redirected_to devices_url
  end

  test "should allow tricky new location creation (assign location by name)" do
    sign_in users(:admin)

    assert_difference('Device.count', 1) do
      post devices_url, params: {
        device: {
          kind: @device.kind,
          create_new_location: 'Office',
          name: @device.name + "_unique" } }
    end

    new_device = Device.last
    assert_redirected_to device_url(new_device)
    assert_equal locations(:office), new_device.location
  end
end
