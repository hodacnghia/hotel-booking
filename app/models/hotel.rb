class Hotel < ApplicationRecord
  belongs_to :user
  has_many :rooms
  include PgSearch
  
  pg_search_scope :search_content_for, against: :content, using: { tsearch: { any_word: true } }
end
