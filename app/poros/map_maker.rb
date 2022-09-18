class MapMaker

  def initialize(user_lat, user_long, sat_lat,sat_lng)
    @user_lat
    @user_long
    @sat_lat
    @sat_lng

    @parameters = []
  end

  def result_url
    "http://maps.googleapis.com/maps/api/staticmap?" + style_params + user_location_params + sat_location_params + message_origin_params
  end

  def user_location_params
    "&markers=anchor"
  end

  def sat_location_params

  end

  def message_origin_params

  end

  def style_params

  end

  def api_key
    ENV['google_maps_key']
  end
end

    
    
# &size=600x400&style=visibility:on
# &style=feature:water%7Celement:geometry%7Cvisibility:on
# &style=feature:landscape%7Celement:geometry%7Cvisibility:on
# &markers=anchor:32,10%7Cicon:https://goo.gl/5y3S82%7CCanberra+ACT
# &markers=anchor:topleft%7Cicon:http://tinyurl.com/jrhlvu6%7CMelbourne+VIC
# &markers=anchor:topright%7Cicon:https://goo.gl/1oTJ9Y%7CSydney+NSW
# &key=YOUR_API_KEY
# &signature=YOUR_SIGNATURE