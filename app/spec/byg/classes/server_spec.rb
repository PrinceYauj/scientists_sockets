# frozen_string_literal: true

RSpec.describe Byg::Classes::Server do
  subject(:server) { described_class.new('127.0.0.1', 4000) }

  after do
    server.listener.close
  end

  def create_double(klass, method, result)
    d = double(klass.to_s)
    allow(Byg::Classes.const_get(klass)).to receive(:new).and_return(d)
    allow(d).to receive(method.to_sym).and_return result
  end

  context 'with random request' do
    let(:request) { 'random request' }

    it { expect(server.send(:handle_data, request)).to include('bad request') }
  end

  context 'with GET /scientists' do
    let(:request) { 'GET /scientists' }

    it 'returns http status 200 OK' do
      create_double(:Controller, :call, [200, '1'])
      expect(server.send(:handle_data, request)).to include('200')
    end
  end

  context 'with GET /inventions/1' do
    let(:request) { 'GET /inventions/1' }

    it 'returns http status 200 OK' do
      create_double(:Controller, :call, [200, '1'])
      expect(server.send(:handle_data, request)).to include('200')
    end
  end
end
