class DayPart
  include Mongoid::Document
  belongs_to :location

  field :name, type: String

  validates_presence_of :name, presence: true, :message => "Name should not be empty."
  validates_uniqueness_of :name, :scope => :location_id, :message => "Name should be unique."
end