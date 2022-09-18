class Message

  attr_reader :id,
              :satellite_id,
              :start_lat,
              :start_lng,
              :content,
              :created_at

  def initialize(data)
    @id = data[:data][:id].to_i
    @satellite_id = data[:data][:attributes][:satellite_id]
    @start_lat = data[:data][:attributes][:start_lat]
    @start_lng = data[:data][:attributes][:start_lng]
    @content = data[:data][:attributes][:content]
    @created_at = data[:data][:attributes][:created_at]
  end

end