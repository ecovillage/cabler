# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class GraphConfiguration
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :show_locations, :location_shape, :device_shape, :show_ports

  attribute :rank_dir, default: 'TB'
  attribute :box_locations, default: true
  attribute :splines, default: true
end
