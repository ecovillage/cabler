# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class TopologyController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def show
    g = Graph.new

    respond_to do |format|
      format.html { @png = g.to_png }
      format.png { render plain: g.to_png }
      format.svg { render plain: g.to_svg }
      format.dot { render plain: g.to_dot }
      #TODO better: send_data , send_file for .dot
    end
  end
end
