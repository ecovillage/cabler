# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# == Schema Information
#
# Table name: links
#
#  id             :integer          not null, primary key
#  name           :string
#  kind           :string
#  one_end_type   :string
#  one_end_id     :integer
#  other_end_type :string
#  other_end_id   :integer
#  slot_one_end   :integer
#  slot_other_end :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "has polymorphic ends" do
    assert Link.new(one_end: devices(:one),
                   other_end: locations(:one)).save
  end

  test "#port_for answers correctly" do
    assert_equal 1, links(:tln1_router).port_for(devices(:tln1))
    assert_equal 2, links(:tln1_router).port_for(devices(:router))
    assert_nil links(:tln1_router).port_for(devices(:tln2))
  end
end
