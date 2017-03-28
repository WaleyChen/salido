class Location
  include Mongoid::Document
  belongs_to :brand

  has_many :dayParts
  has_many :priceLevelConfigs

  field :brandName, type: String
  field :name, type: String

  validates_presence_of :name, presence: true, :message => "Name can not be empty."
  validates_uniqueness_of :name, :scope => :brand_id, :message => "\"%{value}\" is already taken."

  def getDayPartNames
    return dayParts.collect{ |dp| [dp.name] }
  end

  def getPriceLevelConfig(id)
    return priceLevelConfigs.where(:id => id).first
  end
end