# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get changelog" do
    get changelog_url
    assert_response :success
    assert_select "h1", text: "Changelog"
  end
end
