# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "validates" do
    assert !Location.new.save
  end
end
