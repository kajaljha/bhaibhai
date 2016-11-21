class ParkingPlace < ApplicationRecord
  #searchkick
  serialize :days_availability

  belongs_to :user
  #validates :street, :city, :state, :zip, :address, presence: true
  
  scope :only_available_places, -> {where(availability_status: true)}

  geocoded_by :full_address
  serialize :days, Array
  
  DAYS = [['Sunday', 'sunday'], ['Monday', 'monday'], ['Tuesday', 'tuesday'], ['Wednesday', 'wednesday'], ['Thursday', 'thursday'], ['Friday', 'friday'], ['Saturday', 'saturday']]

  after_validation :geocode,
  :if => lambda{ |obj| obj.full_address_changed? }
  
  #after_commit  :reindex_parking_places
  
  def self.search(query)
    if query == ""
      parking_places = ParkingPlace.all    
    else
      parking_places = ParkingPlace.where(zip: query)
    end
  end

  def self.search_parking_places_for_api(zip, time_start, time_end)
    available_spaces = ParkingPlace.only_available_places
    spaces_with_zip_code = available_spaces.where(zip: zip)
    parking_places = []
    unless spaces_with_zip_code.blank?
      spaces_with_zip_code.each do |s|
        if (!s.time_start.nil? && !s.time_end.nil?) && (s.time_start.try(:strftime, "%H:%M") >= time_start) && (s.time_end.try(:strftime, "%H:%M") <= time_end)
          parking_places << s.jquery_map_data_as_json
        end
      end
    end      
    return parking_places rescue []    
  end

  def full_address
    [street, address, city, state, zip].compact.join(', ')
  end

  def full_address_changed?
    street_changed? || address_changed? || city_changed? || state_changed? || zip_changed?
  end

  def as_json(options={})
    super(:only => [:id, :latitude, :longitude, :street, :city, :state, :zip, :address, :owner_name, :owner_number, :avail_spaces, :total_spaces, :price, :time_start, :time_end])
  end

  def self.parking_places_with_lat_long
    parking_places = []
    ParkingPlace.all.each do |place|
      parking_places << { 
        lat: place.latitude, 
        long: place.longitude,
        city: place.city,
        state: place.state,
        address: place.address, 
        owner_name: place.owner_name,
        owner_number: place.owner_number,
        avail_spaces: place.avail_spaces,
        total_spaces: place.total_spaces,
        price: place.price,
        time_start: place.time_start,
        time_end: place.time_end
      }
    end
    return parking_places rescue []
  end

  def jquery_map_data_as_json
    {
      lat: self.latitude, 
      long: self.longitude,
      city: self.city,
      state: self.state,
      address: self.address, 
      owner_name: self.owner_name,
      owner_number: self.owner_number,
      avail_spaces: self.avail_spaces,
      total_spaces: self.total_spaces,
      price: self.price,
      time_start: self.time_start,
      time_end: self.time_end
    }
  end
  # def reindex_parking_places
  #   ParkingPlace.reindex
  # end

  # def self.search_results(query)
  #   query == "" ? "*" : query
  #   options = 
  #   { 
  #     where: {active: true},
  #     fields: [:city, :state, :address],
  #     operator: "or",
  #     misspellings: {distance: 2}
  #   } 
  #   result = Picture.search query, options  rescue []
  # end
end
