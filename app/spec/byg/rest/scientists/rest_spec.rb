RSpec.describe Byg::Rest::Scientists do

  def act
    @client.send(req, 0)
    @server.start(@serv_sock)
  end

  context 'GET /scientists' do
    let(:req) { 'GET /scientists' }

    it 'invokes Request\'s instance_method #parse' do
      r = double('Request')
      allow(Byg::Classes::Request).to receive(:new).and_return(r)
      c = double('Controller').as_null_object
      allow(Byg::Classes::Controller).to receive(:new).and_return(c)
      expect(r).to receive(:parse)
      act
    end

    it 'invokes Byg::Rest::Scientists.show method' do
      expect(Byg::Rest::Scientists).to receive(:show)
      act
    end
  end

  context 'POST /scientists' do
    let(:req) { 'POST /scientists' }

    it 'invokes Byg::Rest::Scientists.create method' do
      expect(Byg::Rest::Scientists).to receive(:create)
      act
    end
  end

  context 'PUT /scientists' do
    let(:req) { 'PUT /scientists' }

    it 'invokes Byg::Rest::Scientists.update method' do
      expect(Byg::Rest::Scientists).to receive(:update)
      act
    end
  end

  context 'DELETE /scientists' do
    let(:req) { 'DELETE /scientists' }

    it 'invokes Byg::Rest::Scientists.destroy method' do
      expect(Byg::Rest::Scientists).to receive(:destroy)
      act
    end
  end
end
