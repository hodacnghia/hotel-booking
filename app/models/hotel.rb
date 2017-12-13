class Hotel < ApplicationRecord

  belongs_to :user
  has_many :rooms, dependent: :destroy
  mount_uploaders :picture, PictureUploader
  validate  :picture_size
  ratyrate_rateable 'rate'
  include PgSearch
  pg_search_scope :whose_name_starts_with, against: [:name, :description]  ,  :using => {
    :tsearch => {:prefix => true}
}
      # Validates the size of an uploaded picture.
      def picture_size
        if picture.size > 5.megabytes
          errors.add(:picture, "should be less than 5MB")
        end
      end
end
