class SatellitePosition

  attr_reader :name,
              :norad_id,
              :sat_lat,
              :sat_lng

  def initialize(data)
    @name = data[:info][:satname]
    @norad_id = data[:info][:satid]
    @sat_lat = data[:positions].first[:satlatitude]
    @sat_lng = data[:positions].first[:satlongitude]
  end

end