# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module LocationHelper
  def get_parents(location, accumulator = [])
    if location.parent
      accumulator = accumulator.push(location.parent)
      return get_parents(location.parent, accumulator)
    end
    return accumulator
  end
end
