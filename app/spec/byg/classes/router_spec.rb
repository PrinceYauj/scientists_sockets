RSpec.describe Byg::Classes::Router do
  subject(:router) { described_class.new(request[:verb], request[:path]) }

  context 'random request' do
    let(:request) { { verb: 'random', path: 'request' } }

    it { expect(router.valid?).to be_falsey }
    it { expect(router).not_to receive(:action) }
  end

  context 'valid verb with invalid path' do
    let(:request) { { verb: 'GET', path: '/inventions/a' } }

    it { expect(router.valid?).to be_falsey }
    it { expect(router).not_to receive(:action) }
  end

  context 'invalid verb with valid path' do
    let(:request) { { verb: 'ASD', path: '/scientists/1' } }

    it { expect(router.valid?).to be_falsey }
    it { expect(router).not_to receive(:action) }
  end

  context 'GET /inventions' do
    let(:request) { { verb: 'GET', path: '/inventions' } }

    it { expect(router.valid?).to be_truthy }
    it { expect(router.action).to be == Byg::Rest::Inventions.method(:show) }
    it { expect(router.id).to be_nil }
  end

  context 'GET /scientists' do
    let(:request) { { verb: 'GET', path: '/scientists' } }

    it { expect(router.valid?).to be_truthy }
    it { expect(router.action).to be == Byg::Rest::Scientists.method(:show) }
    it { expect(router.id).to be_nil }
  end 

  context 'GET /inventions/1' do
    let(:request) { { verb: 'GET', path: '/inventions/1' } }

    it { expect(router.valid?).to be_truthy }
    it { expect(router.action).to be == Byg::Rest::Inventions.method(:show) }
    it { expect(router.id).to be == '1' }
  end

  context 'GET /scientists/1' do
    let(:request) { { verb: 'GET', path: '/scientists/1' } }

    it { expect(router.valid?).to be_truthy }
    it { expect(router.action).to be == Byg::Rest::Scientists.method(:show) }
    it { expect(router.id).to be == '1' }
  end
  
  context 'POST /inventions {\"name\":\"Mr. Satan\",\"power\":\"9001\"}' do
    let(:request) { { verb: 'POST', path: '/inventions' } }

    it { expect(router.valid?).to be_truthy }
    it { expect(router.action).to be == Byg::Rest::Inventions.method(:create) }
    it { expect(router.id).to be_nil }
  end

  context 'PUT /scientists/1 {\"valid_parameter\":\"1\"}' do
    let(:request) { { verb: 'PUT', path: '/scientists/1' } }

    it { expect(router.valid?).to be_truthy }
    it { expect(router.action).to be == Byg::Rest::Scientists.method(:update) }
    it { expect(router.id).to be == '1' }
  end

  context 'DELETE /inventions/1' do
    let(:request) { { verb: 'POST', path: '/inventions/1' } }

    it { expect(router.valid?).to be_truthy }
    it { expect(router.action).to be == Byg::Rest::Inventions.method(:create) }
    it { expect(router.id).to be == '1' }
  end
end
