RSpec.describe Byg::Classes::Response do
  subject(:response) { described_class.new(res) }

  let(:res) { [200, 'something'] }

  it { expect(response).to respond_to(:generate) }
  it { expect(response.send(:status)).to be == 200 }
end
