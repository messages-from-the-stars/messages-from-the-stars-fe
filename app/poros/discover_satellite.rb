class DiscoverSatellite 

  attr_reader :satid, :satname

  def initialize(data)
    @satid = data[:satid]
    @satname = data[:satname]
  end
end