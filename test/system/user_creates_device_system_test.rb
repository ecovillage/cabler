# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

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

