class Location < ApplicationRecord
  has_many :devices

  has_many_attached :images

  validates :name, presence: true, uniqueness: true
end
