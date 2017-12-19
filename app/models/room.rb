class Room < ApplicationRecord
  belongs_to :type
  belongs_to :hotel
  has_many :orders
  has_many :users , :through => :orders
  validates :status , default: false
  has_many :orders

  def self.date_order
    dateordered = []
    self.orders.each do |order|
      dateordered += order.from
      
    end
end
end
