# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Location < ApplicationRecord
  include HasImages
  extend FriendlyId

  friendly_id :human_identifier, :use => [:slugged]

  has_many :devices

  has_many :link_one_ends, as: :one_end, class_name: 'Link', inverse_of: :one_end
  has_many :link_other_ends, as: :other_end, class_name: 'Link', inverse_of: :other_end

  def links
    Link.where(one_end: self).or(Link.where(other_end: self))
  end

  def link
    link_one_ends
  end

  validates :name, presence: true, uniqueness: true

  def human_identifier
    name
  end
end
