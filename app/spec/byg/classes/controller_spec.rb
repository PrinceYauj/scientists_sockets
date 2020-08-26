# frozen_string_literal: true

RSpec.describe Byg::Classes::Controller do
  subject(:controller) { described_class.new }

  let(:response) { controller.call(parsed_req) }

  context 'with random request' do
    let(:parsed_req) { { verb: 'random', path: 'request' } }

    it { expect(response).to be == [400, ['bad request']] }
  end

  context 'with GET /inventions' do
    let(:parsed_req) { { verb: 'GET', path: '/inventions' } }

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Inventions).to receive(:show).and_return('not nil')
      expect(Byg::Rest::Inventions).to receive(:show).with({})
      expect(response[0]).to be == 200
    end
  end

  context 'with GET /scientists' do
    let(:parsed_req) { { verb: 'GET', path: '/scientists' } }

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Scientists).to receive(:show).and_return('not nil')
      expect(Byg::Rest::Scientists).to receive(:show).with({})
      expect(response[0]).to be == 200
    end
  end

  context 'with GET /inventions/1' do
    let(:parsed_req) { { verb: 'GET', path: '/inventions/1' } }

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Inventions).to receive(:show).and_return('not nil')
      expect(Byg::Rest::Inventions).to receive(:show).with({ route_id: '1' })
      expect(response[0]).to be == 200
    end
  end

  context 'with GET /scientists/1' do
    let(:parsed_req) { { verb: 'GET', path: '/scientists/1' } }

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Scientists).to receive(:show).and_return('not nil')
      expect(Byg::Rest::Scientists).to receive(:show).with({ route_id: '1' })
      expect(response[0]).to be == 200
    end
  end

  context 'with POST /inventions {\"name\":\"Mr. Satan\",\"power\":\"9001\"}' do
    let(:parsed_req) do
      { verb: 'POST',
        path: '/inventions',
        body: { name: 'Mr. Satan', power: '9001' }.to_json }
    end

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Inventions).to receive(:create).and_return('not nil')
      expect(Byg::Rest::Inventions).to receive(:create).
        with(JSON.parse(parsed_req[:body], symbolize_names: true))
      expect(response[0]).to be == 200
    end
  end

  context 'with POST /scientists {\"madness\":\"50\",\"attempts\":\"50\"}' do
    let(:parsed_req) do
      { verb: 'POST',
        path: '/scientists',
        body: { madness: '50', attempts: '50' }.to_json }
    end

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Scientists).to receive(:create).and_return('not nil')
      expect(Byg::Rest::Scientists).to receive(:create).
        with(JSON.parse(parsed_req[:body], symbolize_names: true))
      expect(response[0]).to be == 200
    end
  end

  context 'with PUT /inventions/1 {\"invalid_parameter\":\"-1\"}' do
    let(:parsed_req) do
      { verb: 'PUT',
        path: '/inventions/1',
        body: { invalid_parameter: '-1' }.to_json }
    end

    it 'returns http status 400 - bad request' do
      allow(Byg::Rest::Inventions).to receive(:update).
        and_raise(StandardError)
      expect(response[0]).to be == 400
    end
  end

  context 'with PUT /scientists/1 {\"valid_parameter\":\"1\"}' do
    let(:parsed_req) do
      { verb: 'PUT',
        path: '/scientists/1',
        body: { valid_parameter: '1' }.to_json }
    end

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Scientists).to receive(:update).and_return('not nil')
      expect(Byg::Rest::Scientists).to receive(:update).
        with({ route_id: '1', valid_parameter: '1' })
      expect(response[0]).to be == 200
    end
  end

  context 'with DELETE /inventions/1' do
    let(:parsed_req) { { verb: 'DELETE', path: '/inventions/1' } }

    it 'returns http status 200 - OK' do
      allow(Byg::Rest::Inventions).to receive(:destroy).and_return('not nil')
      expect(Byg::Rest::Inventions).to receive(:destroy).with({ route_id: '1' })
      expect(response[0]).to be == 200
    end
  end
end
