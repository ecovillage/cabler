# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class DashboardController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def show
    @devices   = Device.all
    @locations = Location.all
  end
end