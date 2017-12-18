class Room < ApplicationRecord
  belongs_to :type
  belongs_to :hotel
  validates :status , default: false
  has_many :orders

  def self.date_order
    dateordered = []
    self.orders.each do |order|
      dateordered += order.from
      
    end
end
end
