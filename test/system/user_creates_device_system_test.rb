require "application_system_test_case"

class UserCreatesDeviceSystemTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in(users(:admin))
  end

  test "create a device with name" do
    visit devices_url
    click_on "Add Device"
  end
end

