class LabelConfiguration
  include ActiveModel::Model

  # port_side
  LEFT_ORIENTED  = :left
  RIGHT_ORIENTED = :right

  # port_direction
  TOP_BOTTOM = :top_bottom
  BOTTOM_TOP = :bottom_top

  attr_accessor :port_side
  attr_accessor :port_direction
  attr_accessor :exclude_empty_ports

  def ports_left?
    @ports_side == nil || @ports_side == LEFT_ORIENTED
  end

  def ports_top_bottom?
    @port_direction == nil || @port_direction == TOP_BOTTOM
  end

  def exclude_empty_ports?
    @exclude_empty_ports
  end
end
