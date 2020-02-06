require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @location = locations(:one)
  end

  test "should not get index when unauthenticated" do
    get locations_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:one)
    get locations_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_location_url
    assert_response :success
  end

  test "should create location" do
    sign_in users(:one)
    assert_difference('Location.count') do
      post locations_url, params: { location: { name: "top floor" } }
    end

    assert_redirected_to location_url(Location.last)
  end

  test "should show location" do
    sign_in users(:one)
    get location_url(@location)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_location_url(@location)
    assert_response :success
  end

  test "should update location" do
    sign_in users(:one)
    patch location_url(@location), params: { location: { name: @location.name } }
    assert_redirected_to location_url(@location)
  end

  test "should destroy location" do
    sign_in users(:one)
    assert_difference('Location.count', -1) do
      delete location_url(@location)
    end

    assert_redirected_to locations_url
  end
end
