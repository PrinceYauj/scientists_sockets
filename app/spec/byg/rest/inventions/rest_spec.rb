RSpec.describe Byg::Rest::Inventions do

  def act
    @client.send(req, 0)
    @server.start(@serv_sock)
  end

  context 'GET /inventions' do
    let(:req) { 'GET /inventions' }

    it 'invokes Router\'s instance_methods' do
      request = {'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/inventions'}
      c = Byg::Classes::Controller.new
      allow(c).to receive(:handle_route).with(request).and_call_original
      r = double('Router')
      expect(Byg::Classes::Router).to receive(:new).and_return(r)
      allow(r).to receive(:valid?).and_return(:true)
      expect(r).to receive(:valid?)
      expect(r).to receive(:action).and_return(Proc.new{})
      expect(r).to receive(:id)
      c.send(:handle_route, request)
    end

    it 'invokes Byg::Rest::Inventions.show method' do
      expect(described_class).to receive(:show).with({})
      act
    end
  end

  context 'GET /inventions/1' do
    let(:req) { 'GET /inventions/1' }

    it 'invokes Byg::Rest::Inventions.show method with parameters' do
      expect(described_class).to receive(:show).with({'route_id' => '1'})
      act
    end
  end

  context 'if there is no matching row' do
    let(:req) { 'GET /inventions/-666' }

    it 'still invokes corresponding method' do
      expect(described_class).to receive(:show).with({'route_id' => '-666'})
      act
    end

    it 'returns 400 - bad request with error' do
      r = Byg::Classes::Response.new([400, 'Sequel::Error'])
      allow(r).to receive(:generate).and_call_original
      expect(r.generate).to include('Sequel::Error')
    end
  end

  context 'POST /inventions' do
    let(:req) { 'POST /inventions' }

    it 'invokes Byg::Rest::Inventions.create method' do
      expect(described_class).to receive(:create).with({})
      act
    end

    it 'returns 400 - bad request with error' do
      c = double('Controller')
      allow(Byg::Classes::Controller).to receive(:new).and_return(c)
      allow(c).to receive(:call).and_return([400, 'Sequel::Error'])
      r = Byg::Classes::Response.new(c.call)
      expect(r.generate).to include('Sequel::Error')
      act
    end
  end

  context 'POST /inventions' do
    let(:req) { 'POST /inventions/1' }
  end

  context 'PUT /inventions' do
    let(:req) { 'PUT /inventions' }

    it 'invokes Byg::Rest::Inventions.update method' do
      expect(described_class).to receive(:update)
      act
    end
  end

  context 'DELETE /inventions' do
    let(:req) { 'DELETE /inventions' }

    it 'invokes Byg::Rest::Inventions.destroy method' do
      expect(described_class).to receive(:destroy)
      act
    end
  end
end
