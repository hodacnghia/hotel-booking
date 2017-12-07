class Hotel < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy
end
