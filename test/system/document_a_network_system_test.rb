# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class DocumentANetworkSystemTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "change Patchpanel assignment" do
    sign_in users(:admin)

    visit devices_url

    click_on "New Device", match: :first

    fill_in "Name", with: "GB NAS"
    fill_in 'device_kind', with: 'NAS'
    fill_in "Url", with: 'http://nas.gb'
    fill_in "Description", with: 'The new GB NAS'
    fill_in 'device_create_new_location', with: 'Office'

    click_on 'Create device'

    assert_text 'device'
  end

  test "look at topology graph" do
    sign_in users(:admin)

    visit topology_url

    #assert_selector
  end
end
