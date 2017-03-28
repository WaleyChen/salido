class Brand
  include Mongoid::Document
  has_many :locations
  has_many :menuItems
  has_many :orderTypes
  has_many :priceLevels

  field :name, type: String
  
  validates_presence_of :name, presence: true, :message => "Name can not be empty."
  validates_uniqueness_of :name, :message => "\"%{value}\" is already taken."

  def getOrderTypeNames
    return orderTypes.collect{|ot| [ot.name]}
  end

  def getPriceLevelNames
    return priceLevels.collect{|pl| [pl.name]}
  end
end