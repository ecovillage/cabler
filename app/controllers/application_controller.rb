# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ApplicationController < ActionController::Base
  before_action :set_locations_for_nav, unless: :devise_controller?

  def set_locations_for_nav
    @nav_locations = Location.all.order(:name).where(parent: nil)
  end
end
