class PriceLevelConfig
  include Mongoid::Document
  belongs_to :location

  validate :day_part_has_order_type
  validate :order_type_and_day_part_are_unique_within_location

  field :dayPartName, type: String
  field :orderTypeName, type: String
  field :priceLevelName, type: String

  def order_type_and_day_part_are_unique_within_location
    if location
      plc = location.priceLevelConfigs.where(
        :id.ne => self.id,
        :orderTypeName => orderTypeName, 
        :dayPartName => dayPartName
      ).first
      if plc
        errors.add(:save, "Could not save \"#{priceLevelName}\" because \"#{plc.priceLevelName}\" has the same configuration.")
      end
    end
  end

  def day_part_has_order_type
    if dayPartName != "" && orderTypeName == ""
      errors.add(:save, "Need to specify an Order Type.")
    end
  end
end