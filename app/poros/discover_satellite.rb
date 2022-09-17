class DiscoverSatellite 

  attr_reader :satid, :satname, :launch_date

  def initialize(data)
    @satid = data[:satid]
    @satname = data[:satname]
    @launch_date = data[:launchDate]
  end
end