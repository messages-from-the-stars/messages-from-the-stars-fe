class MapMaker

  def initialize(user_lat, user_lng, sat_lat,sat_lng, message_start_lat, message_start_lng)
    @user_lat = user_lat
    @user_lng = user_lng
    @sat_lat = sat_lat
    @sat_lng = sat_lng
    @message_start_lat = message_start_lat
    @message_start_lng = message_start_lng
  end

  def result_url
    "http://maps.googleapis.com/maps/api/staticmap?" + image_style + user_marker_params + sat_marker_params + message_origin_marker_params + api_key
  end

  def image_style
    "&size=600x400&style=visibility:on&maptype=satellite"
  end

  def user_marker_params
    "&markers=size:medium|color:blue|label:U|#{@user_lat},#{@user_lng}"
  end

  def sat_marker_params
    "&markers=size:medium|color:red|label:S|#{@sat_lat},#{@sat_lng}"
  end

  def message_origin_marker_params
    "&markers=size:medium|color:green|label:M|#{@message_start_lat},#{@message_start_lng}"
  end

  def api_key
    "&key=#{ENV['google_maps_key']}"
  end
end
