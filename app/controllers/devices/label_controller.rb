# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Devices::LabelController < ApplicationController
  before_action :authenticate_user!

  # GET /device/1/label
  def show
    # layout: pretty plain
    @label_configuration = LabelConfiguration.new(port_side: LabelConfiguration::LEFT_ORIENTED)
    set_device
  end

  private
  def set_device
    device = Device.friendly.find params[:device_id]
    @device = ConnectedDevice.new(device: device)
  end
end
