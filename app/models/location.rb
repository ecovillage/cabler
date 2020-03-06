# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Location < ApplicationRecord
  include HasImages
  extend FriendlyId

  acts_as_tree order: "name"

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

  def parents
    parents = []
    location = self

    while (location = location.parent)
      parents << location
    end

    parents
  end

  validates :name, presence: true, uniqueness: true

  validate :parent_cannot_be_own_child

  def parent_cannot_be_own_child
    if parent.present?
      if self.children.exists? parent.id
        errors.add(:parent_id, 'Location cannot be sub location and parent location at the same time')
      end
    end
  end

  def human_identifier
    name
  end
end
