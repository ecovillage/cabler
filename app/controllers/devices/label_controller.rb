class Devices::LabelController < ApplicationController
  before_action :authenticate_user!

  # GET /device/1/label
  def show
    # layout: pretty plain
    set_device
  end

  private
  def set_device
    device = Device.find params[:device_id]
    @device = LabeledDevice.new(device: device)
  end
end
