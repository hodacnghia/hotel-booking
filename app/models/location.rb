class Location < ApplicationRecord
    
    geocoded_by :address
    after_validation :geocode, :reverse_geocode
    reverse_geocoded_by :latitude, :longitude

end
