class Room < ApplicationRecord
  belongs_to :type
  belongs_to :hotel
  validates :status , default: false
  has_many :orders
end
