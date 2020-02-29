require "application_system_test_case"

class LocationsSystemTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @location = locations(:one)
  end

  test "visiting the index without login" do
    visit locations_url
    assert_selector "h1", text: "Devices"
  end

  test "visiting the index" do
    sign_in users(:admin)
    visit locations_url
    assert_selector "h1", text: "Locations"
  end

  test "creating a Location" do
    sign_in users(:admin)
    visit locations_url
    click_on "New Location"

    fill_in "Name", with: @location.name
    click_on "Create Location"

    assert_text "Location was successfully created"
    click_on "Back"
  end

  test "updating a Location" do
    sign_in users(:admin)
    visit locations_url
    click_on "Edit", match: :first

    fill_in "Name", with: @location.name
    click_on "Update Location"

    assert_text "Location was successfully updated"
    click_on "Back"
  end

  test "destroying a Location" do
    sign_in users(:admin)
    visit locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Location was successfully destroyed"
  end
end
