# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

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
    @device = ConnectedDevice.new(device: device)
  end
end
