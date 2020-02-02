class LabeledDevice
  include ActiveModel::Model

  attr_accessor :device, :slots, :unslotted_links
  delegate :name, to: :device

  #attr_accessor :device, :slots
  def initialize device: device
    @device = device
    @slots = []
    @unslotted_links = []
    @device.links.each do |link|
      if link.one_end == @device
        if link.slot_one_end.nil?
          @unslotted_links << link
          next
        end
        @slots[link.slot_one_end] = DirectedLink.new(
          source_slot: link.slot_one_end,
          source_device: link.one_end,
          target_slot: link.slot_other_end,
          target_device: link.other_end,
          link: link
        )
      else
        if link.slot_other_end.nil?
          @unslotted_links << link
          next
        end
        @slots[link.slot_other_end] = DirectedLink.new(
          source_slot: link.slot_other_end,
          source_device: link.other_end,
          target_slot: link.slot_one_end,
          target_device: link.one_end,
          link: link
        )
      end
    end
  end

end
