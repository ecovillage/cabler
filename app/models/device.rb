class Device < ApplicationRecord
  belongs_to :location, optional: true

  has_many :link_one_ends, as: :one_end, class_name: 'Link', inverse_of: :one_end
  has_many :link_other_ends, as: :other_end, class_name: 'Link', inverse_of: :other_end
  
  has_many_attached :images

  # only if not empty
  validates :name, presence: true, length: { minimum: 2 }#, uniqueness: true

  validate :identifiable

  def identifiable
    if !(name.present? || model.present? || (model.present? || kind.present? && location.present?))
      errors.add(:name, "need something to identify this device (name, model or kind + location)")
    end
  end

  def links
    Link.where(one_end: self).or(Link.where(other_end: self))
  end

  def link
    link_one_ends
  end
end

