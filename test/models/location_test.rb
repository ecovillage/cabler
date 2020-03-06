# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "validates" do
    assert !Location.new.save
  end

  test "parent cannot be child" do
    country =         Location.create(name: 'country')
    village = country.children.create(name: 'village')
    street  = village.children.create(name: 'street')
    house   =  street.children.create(name: 'house')

    continent = Location.create(name: 'continent')

    # direct child
    country.parent = village
    assert_equal false, country.valid?

    # grandchild
    country.parent = street
    assert_equal false, country.valid?

    country.parent = continent
    assert_equal true, country.valid?
  end
end
