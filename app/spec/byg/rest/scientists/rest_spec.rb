RSpec.describe Byg::Rest::Scientists do

  def act
    @client.send(req, 0)
    @server.start(@serv_sock)
  end

  context 'GET /scientists' do
    let(:req) { 'GET /scientists' }

    it 'invokes Router\'s instance_method #action' do
      r = double('Router').as_null_object
      allow(Byg::Classes::Router).to receive(:new).
        and_return(r)
      expect(r).to receive(:action)
      expect(r).to receive(:id)
      act
    end

    it 'invokes described_class.show method' do
      expect(described_class).to receive(:show)
      act
    end
  end

  context 'POST /scientists' do
    let(:req) { 'POST /scientists' }

    it 'invokes described_class.create method' do
      expect(described_class).to receive(:create)
      act
    end
  end

  context 'PUT /scientists' do
    let(:req) { 'PUT /scientists' }

    it 'invokes described_class.update method' do
      expect(described_class).to receive(:update)
      act
    end
  end

  context 'DELETE /scientists' do
    let(:req) { 'DELETE /scientists' }

    it 'invokes described_class.destroy method' do
      expect(described_class).to receive(:destroy)
      act
    end
  end
end
