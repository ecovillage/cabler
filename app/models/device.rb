class Device < ApplicationRecord
  belongs_to :location, optional: true

  has_many :link_one_ends, as: :one_end, class_name: 'Link', inverse_of: :one_end
  has_many :link_other_ends, as: :other_end, class_name: 'Link', inverse_of: :other_end
  

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  def links
    Link.where(one_end: self).or(Link.where(other_end: self))
  end

  def link
    link_one_ends
  end
end

