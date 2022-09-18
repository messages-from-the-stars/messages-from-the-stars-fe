class SatelliteMessage

  attr_reader :id,
              :satellite_id,
              :start_lat,
              :start_lng,
              :content,
              :created_at

  def initialize(data)
    @id = data[:id].to_i
    @satellite_id = data[:attributes][:satellite_id]
    @start_lat = data[:attributes][:start_lat]
    @start_lng = data[:attributes][:start_lng]
    @content = data[:attributes][:content]
    @created_at = data[:attributes][:created_at]
  end

end