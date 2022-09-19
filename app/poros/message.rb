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

  def formatted_creation_date
    datetime = DateTime.parse(@created_at)

    datetime.strftime("%d %B %Y, %l:%M %p")
  end

  def travel_time_days
    datetime = DateTime.parse(@created_at)
    today = DateTime.now

    (today - datetime).to_i
  end

end