require 'rails_helper'

RSpec.describe MapMaker do

  it 'exists' do
    map_maker = MapMaker.new(39.7392,104.9903,38.9072,77.0369)

    expect(map_maker).to be_a MapMaker
  end

end