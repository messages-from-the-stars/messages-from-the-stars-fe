class SatelliteAPI
  attr_reader :id,
              :name
              
  def initialize(data)
    @id = data[:satid]
    @name = data[:satname]
  end
end