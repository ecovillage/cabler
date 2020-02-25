# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Link < ApplicationRecord
  #belongs_to :location
  # one_end
  # other_end
  #
  belongs_to :one_end, polymorphic: true, optional: true#, inverse_of: :link_one_end

  belongs_to :other_end, polymorphic: true, optional: true

  validates :slot_one_end, :slot_other_end, numericality: { only_integer: true }, allow_blank: true
end
