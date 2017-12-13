class Room < ApplicationRecord
  belongs_to :type
  belongs_to :hotel
  has_many :orders
  has_many :users , :through => :orders
  validates :status , default: false
end
