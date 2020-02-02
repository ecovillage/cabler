class Link < ApplicationRecord
  #belongs_to :location
  # one_end
  # other_end
  #
  belongs_to :one_end, polymorphic: true, optional: true#, inverse_of: :link_one_end

  belongs_to :other_end, polymorphic: true, optional: true
end
