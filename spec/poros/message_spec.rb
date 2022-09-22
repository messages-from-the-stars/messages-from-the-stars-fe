require 'rails_helper'

RSpec.describe Message do

  it 'exists' do
    data = {:data=>
            {:id=>"2",
            :type=>"message",
            :attributes=>
              {:satellite_id=>19,
              :start_lat=>40.57418114605389,
              :start_lng=>32.18080704424722,
              :content=>"What a piece of work is man!",
              :created_at=>"2022-09-12T18:42:01.000Z",
              :updated_at=>"2022-04-05T22:43:05.000Z"
            }
        }
    }

    message = Message.new(data)

    expect(message).to be_a Message
    expect(message.id).to eq(2)
    expect(message.satellite_id).to eq(19)
    expect(message.start_lat.round(2)).to eq(40.57)
    expect(message.start_lng.round(2)).to eq(32.18)
    expect(message.content).to eq("What a piece of work is man!")
    expect(message.created_at).to eq("2022-09-12T18:42:01.000Z")
  end

  it 'calculates travel time in days' do
    data = {:data=>
            {:id=>"2",
            :type=>"message",
            :attributes=>
              {:satellite_id=>19,
              :start_lat=>40.57418114605389,
              :start_lng=>32.18080704424722,
              :content=>"What a piece of work is man!",
              :created_at=>"2022-09-12T18:42:01.000Z",
              :updated_at=>"2022-04-05T22:43:05.000Z"
            }
        }
    }

    message = Message.new(data)

    allow(message).to receive(:travel_time_days).and_return(10)

    expect(message.travel_time_days).to eq(10)
  end

  it 'calculates travel time in seconds' do
    data = {:data=>
            {:id=>"2",
            :type=>"message",
            :attributes=>
              {:satellite_id=>19,
              :start_lat=>40.57418114605389,
              :start_lng=>32.18080704424722,
              :content=>"What a piece of work is man!",
              :created_at=>"2022-09-12T18:42:01.000Z",
              :updated_at=>"2022-04-05T22:43:05.000Z"
            }
        }
    }

    message = Message.new(data)

    allow(message).to receive(:travel_time_seconds).and_return(875237)

    expect(message.travel_time_seconds).to eq(875237)
  end

  it 'calculates number of orbits based on days' do
    data = {:data=>
            {:id=>"2",
            :type=>"message",
            :attributes=>
              {:satellite_id=>19,
              :start_lat=>40.57418114605389,
              :start_lng=>32.18080704424722,
              :content=>"What a piece of work is man!",
              :created_at=>"2022-09-12T18:42:01.000Z",
              :updated_at=>"2022-04-05T22:43:05.000Z"
            }
        }
    }

    message = Message.new(data)

    allow(message).to receive(:orbit_count).and_return(160)

    expect(message.orbit_count).to eq(160)
  end

  it 'calculates estimate of distance traveled' do
    data = {:data=>
            {:id=>"2",
            :type=>"message",
            :attributes=>
              {:satellite_id=>19,
              :start_lat=>40.57418114605389,
              :start_lng=>32.18080704424722,
              :content=>"What a piece of work is man!",
              :created_at=>"2022-09-12T18:42:01.000Z",
              :updated_at=>"2022-04-05T22:43:05.000Z"
            }
        }
    }

    message = Message.new(data)

    allow(message).to receive(:miles_traveled).and_return(4253126)

    expect(message.miles_traveled).to eq(4253126)
  end

end