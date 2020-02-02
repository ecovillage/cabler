class DashboardController < ApplicationController
  # GET /dashboard
  def show
    @devices   = Device.all
    @locations = Location.all
  end
end
