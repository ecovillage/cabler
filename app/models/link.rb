# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Link < ApplicationRecord
  extend FriendlyId

  friendly_id :name, :use => [:slugged]

  belongs_to :one_end, polymorphic: true, optional: true#, inverse_of: :link_one_end

  belongs_to :other_end, polymorphic: true, optional: true

  validates :port_one_end, :port_other_end, numericality: { only_integer: true }, allow_blank: true

  def port_for device
    if device == one_end
      port_one_end
    elsif device == other_end
      port_other_end
    else
      nil
    end
  end
end
