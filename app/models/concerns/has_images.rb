# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module HasImages
  extend ActiveSupport::Concern

  included do
    has_many_attached :images
    validate :image_sizes

    # TODO Extract into own validator
    def image_sizes
      if images.attached?
        images.select{|f| f.blob.byte_size > 10_000_000}.each do |file|
          #file.purge on Rails5 and maybe with direct uploads.
          errors.add(:base, :file_too_big)
        end
      end
    end
  end
end
