# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
module DeviceGraph
  module LabelBuilder
    def self.label_for device, horizontal: true
      ports = device.links.map {|l| l.port_for(device)}.compact.uniq.sort

      label = "<<TABLE BORDER=\"1\" CELLSPACING=\"0\" CELLPADDING=\"0\">"
      label += "<TR>"
      label += "<TD COLSPAN=\"#{horizontal ? ports.count : 1}\"><FONT FACE=\"Arial\">#{device.human_identifier}</FONT></TD>"
      label += "</TR>"
      if ports.present? && horizontal
        label += "<TR>"
        ports.each do |port|
          label += td_port(port)
        end
        label += "</TR>"
      elsif ports.present? && !horizontal
        ports.each do |port|
          label += "<TR>"
          label += td_port(port)
          label += "</TR>"
        end
      end
      label += "</TABLE>>"
    end

    def self.td_port name
      '<TD PORT="p%s"><FONT FACE="Arial">%s</FONT></TD>' % [name, name]
    end
  end
end
