# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module NavClassHelper
  def nav_item_classes target_url
    'navbar-item' + (' has-background-primary is-active' if current_page?(target_url)).to_s
  end
end
