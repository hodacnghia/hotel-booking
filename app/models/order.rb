class Order < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :form , presence: true
  validates :to , presence: true
  
end
