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

end