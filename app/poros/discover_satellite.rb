class DiscoverSatellite 

  attr_reader :satid, :satname

  def initialize(data)
    @satid = data[:satid]
    @satname = data[:satname]
    binding.pry
  end
end