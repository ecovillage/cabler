require "application_system_test_case"

class DevicesSystemTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @device = devices(:one)
  end

  test "visiting the index without login" do
    visit devices_url
    assert_selector "h1", text: "Devices"
  end

  test "visiting the index after login" do
    sign_in users(:admin)
    visit devices_url
    assert_selector "h1", text: "Devices"
  end

  test "creating a Device" do
    sign_in users(:admin)
    visit devices_url
    click_on "New Device"

    fill_in "Kind", with: @device.kind
    fill_in "Location", with: @device.location_id
    fill_in "Name", with: @device.name
    click_on "Create Device"

    assert_text "Device was successfully created"
    click_on "Back"
  end

  test "updating a Device" do
    sign_in users(:admin)
    visit devices_url
    click_on "Edit", match: :first

    fill_in "Kind", with: @device.kind
    fill_in "Location", with: @device.location_id
    fill_in "Name", with: @device.name
    click_on "Update Device"

    assert_text "Device was successfully updated"
    click_on "Back"
  end

  test "destroying a Device" do
    sign_in users(:admin)
    visit devices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Device was successfully destroyed"
  end
end
