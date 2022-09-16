require 'rails_helper'

RSpec.describe BaseService do
  describe '#n2yo_connection' do
    it 'returns a response' do
      service = BaseService.n2yo_connection

      expect(service).to be_a(Object)
    end
  end
end