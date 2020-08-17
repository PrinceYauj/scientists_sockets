RSpec.describe Byg::Rest::Inventions do

  def act
    @client.send(req, 0)
    @server.start(@serv_sock)
  end

  context 'GET /inventions' do
    let(:req) { 'GET /inventions' }

    it 'invokes Request\'s instance_method #parse' do
      r = double('Request')
      allow(Byg::Classes::Request).to receive(:new).and_return(r)
      c = double('Controller').as_null_object
      allow(Byg::Classes::Controller).to receive(:new).and_return(c)
      expect(r).to receive(:parse)
      act
    end

    it 'invokes Byg::Rest::Inventions.show method' do
      expect(Byg::Rest::Inventions).to receive(:show)
      act
    end
  end

  context 'POST /inventions' do
    let(:req) { 'POST /inventions' }

    it 'invokes Byg::Rest::Inventions.create method' do
      expect(Byg::Rest::Inventions).to receive(:create)
      act
    end
  end

  context 'PUT /inventions' do
    let(:req) { 'PUT /inventions' }

    it 'invokes Byg::Rest::Inventions.update method' do
      expect(Byg::Rest::Inventions).to receive(:update)
      act
    end
  end

  context 'DELETE /inventions' do
    let(:req) { 'DELETE /inventions' }

    it 'invokes Byg::Rest::Inventions.destroy method' do
      expect(Byg::Rest::Inventions).to receive(:destroy)
      act
    end
  end
end
