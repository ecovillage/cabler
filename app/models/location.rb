class Location < ApplicationRecord
  has_many :devices

  validates :name, presence: true, uniqueness: true
end
