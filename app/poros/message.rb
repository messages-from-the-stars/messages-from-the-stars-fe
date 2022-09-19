class Message

  attr_reader :id,
              :satellite_id,
              :start_lat,
              :start_lng,
              :content,
              :created_at

  def initialize(data)
    @id = data[:data].first[:id].to_i
    @satellite_id = data[:data].first[:attributes][:satellite_id]
    @start_lat = data[:data].first[:attributes][:start_lat]
    @start_lng = data[:data].first[:attributes][:start_lng]
    @content = data[:data].first[:attributes][:content]
    @created_at = data[:data].first[:attributes][:created_at]
  end

end