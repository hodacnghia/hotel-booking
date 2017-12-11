class Location < ApplicationRecord
    
    geocoded_by :address
    after_validation :geocode
    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode
end
