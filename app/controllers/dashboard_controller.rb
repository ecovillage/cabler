class DashboardController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def show
    @devices   = Device.all
    @locations = Location.all
  end
end
