class PriceLevel
  include Mongoid::Document
  belongs_to :brand

  field :name, type: String

  validates_presence_of :name, presence: true, :message => "Name should not be empty."
  validates_uniqueness_of :name, :scope => :brand_id, :message => "Name should be unique."
end