class Room < ApplicationRecord
  belongs_to :type
  belongs_to :hotel
  has_many :orders, dependent: :destroy
  has_many :users , :through => :orders
  validates :status , default: false
  after_create :hotel_status
  after_destroy :hotel_empty
  
  def hotel_status
    self.hotel.update_attributes(:status => true)
  end
  def hotel_empty
    if self.hotel.rooms.empty?
    self.hotel.update_attributes(:status => false)
    end
  end

end

