class DirectedLink
  include ActiveModel::Model

  attr_accessor :source_slot, :source_device, :target_slot, :target_device, :link

  #def initialize source_slot: source_slot,
  #  source_device: source_device,
  #  target_slot: target_slot,
  #  target_device: target_device,
  #  link: link
  #  # no-op
  #end
end
