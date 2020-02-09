require 'test_helper'

class Devices::LinksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @link = links(:one)
    @device = devices(:one)
  end

  test "should not get index when unauthenticated" do
    get device_links_url(device_id: @device), params: { device_id: devices(:one) }
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get device_links_url(device_id: @device), params: { device_id: devices(:one) }
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_device_link_url(device_id: @device), params: {device: @device}
    assert_response :success
  end

  #test "should create link" do
  #  assert_difference('Link.count') do
  #    post device_links_url, params: { device_id: @device, link: { location_id: @link.location_id, name: @link.name } }
  #  end

  #  assert_redirected_to device_link_url(Link.last)
  #end

  #test "should show link" do
  #  get device_link_url(devices(:one), @link)
  #  assert_response :success
  #end

  #test "should get edit" do
  #  get edit_device_link_url(devices(:one), @link)
  #  assert_response :success
  #end

  #test "should update link" do
  #  patch device_link_url(@link), params: { link: { location_id: @link.location_id, name: @link.name } }
  #  assert_redirected_to link_url(@link)
  #end

  #test "should destroy link" do
  #  assert_difference('Link.count', -1) do
  #    delete device_link_url(@link)
  #  end

  #  assert_redirected_to device_links_url
  #end
end
