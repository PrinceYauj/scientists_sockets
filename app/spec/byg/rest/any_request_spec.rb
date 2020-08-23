RSpec.describe Byg::Rest do

  def act
    @client.send(req, 0)
    @server.start(@serv_sock)
  end

  context 'any request' do
    let(:req) { 'any request' }

    it 'invokes Request\'s instance_method #parse' do
      r = spy('Request')
      allow(Byg::Classes::Request).to receive(:new).and_return(r)
      act
      expect(r).to have_received(:parse)
    end

    it 'invokes Controller\'s instance_method #call' do
      c = spy('Controller')
      allow(Byg::Classes::Controller).to receive(:new).and_return(c)
      act
      expect(c).to have_received(:call)
    end

    it 'does not invoke Router\'s instance_method #action' do
      r = Byg::Classes::Router.new('any', 'request')
      allow(r).to receive(:valid?).and_call_original
      expect(r).not_to receive(:action)
      act
    end

    it 'invokes Response\'s instance_method #generate' do
      r = spy('Response')
      allow(Byg::Classes::Response).to receive(:new).and_return(r)
      act
      expect(r).to have_received(:generate)
    end
  end
end
