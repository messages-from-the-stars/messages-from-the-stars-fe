class SatMapMaker
  def initialize(sat_lat, sat_lng)
    @sat_lat =  sat_lat
    @sat_lng =  sat_lng
  end

  def result_url
    "http://maps.googleapis.com/maps/api/staticmap?" + image_style + sat_marker_params + api_key
  end

  def image_style
    "&zoom=3&size=600x400&style=visibility:on&maptype=hybrid"
  end

  def sat_marker_params
    "&markers=size:medium|color:red|label:S|#{@sat_lat},#{@sat_lng}"
  end

  def api_key
    "&key=#{ENV['google_maps_key']}"
  end
end