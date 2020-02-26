# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Device < ApplicationRecord
  include HasImages
  extend FriendlyId

  friendly_id :human_identifier, :use => [:slugged]

  belongs_to :location, optional: true

  has_many :link_one_ends, as: :one_end, class_name: 'Link', inverse_of: :one_end
  has_many :link_other_ends, as: :other_end, class_name: 'Link', inverse_of: :other_end
  
  # only if not empty
  #validates :name, presence: true, length: { minimum: 2 }#, uniqueness: true

  validates :num_links, numericality: {only_integer: true, greater_than: 0}, allow_nil: true

  validate :identifiable?

  def identifiable?
    if !(name.present? || model.present? || (model.present? || kind.present? && location.present?))
      errors.add(:name, "need something to identify this device (name, model or kind + location)")
    end
  end

  def human_identifier
    return name if name.present?
    [kind, model, location&.name].compact.join(' ')
  end

  def links
    Link.where(one_end: self).or(Link.where(other_end: self))
  end

  def link
    link_one_ends
  end

end

