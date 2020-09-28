# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Graph::Node
  def self.cluster_name obj
    "cluster_#{obj.id}"
  end
end
