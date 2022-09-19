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

  def formatted_creation_date
    datetime = DateTime.parse(@created_at)

    datetime.strftime("%d %B %Y, %l:%M %p")
  end

  def travel_time_days
    datetime = DateTime.parse(@created_at)
    today = DateTime.now

    (today - datetime).to_i
  end

  def orbit_count
    travel_time_days * 16
  end

  def miles_traveled
    orbit_count * 24_902
  end

end