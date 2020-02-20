class LabelConfiguration
  include ActiveModel::Model

  LEFT_ORIENTED  = :left
  RIGHT_ORIENTED = :right

  attr_accessor :orientation

  def left_oriented?
    @orientation == nil || @orientation == LEFT_ORIENTED
  end
end
