# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class GraphConfiguration
  include ActiveModel::Model
  include ActiveModel::Attributes


  attribute :rank_dir,         default: 'TB'
  attribute :box_locations, :boolean, default: true
  attribute :splines,          default: true

  attribute :show_ports,       default: :all
end
