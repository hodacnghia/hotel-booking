class Location < ApplicationRecord
    belongs_to :hotel
    geocoded_by :address
    after_validation :geocode, :reverse_geocode
    reverse_geocoded_by :latitude, :longitude

end
