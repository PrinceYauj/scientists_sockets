RSpec.describe Byg::Classes::Request do
  subject(:request) { described_class.new(req) }

  context 'random request' do
    let(:req) { 'random request' }

    it 'contains { verb: "random", path: "request" }' do
      expect(request.parse).to be > {
        verb: "random",
        path: "request"
      }
    end
  end

  context 'GET /inventions' do
    let(:req) { 'GET /inventions' }

    it 'contains { verb: "GET", path: "/inventions" }' do
      expect(request.parse).to be > {
        verb: "GET",
        path: "/inventions"
      }
    end
  end 

  context 'GET /scientists/1' do
    let(:req) { 'GET /scientists/1' }

    it 'contains { verb: "GET", path: "/scientists/1" }' do
      expect(request.parse).to be > {
        verb: "GET",
        path: "/scientists/1"
      }
    end
  end 

  context 'PUT -d \'{"id":"2"}\' /scientists/1' do
    let(:req) { "PUT /scientists/1 \r\n" +
                "Content-Type: application/json\r\n" + 
                "Content-Length: 10\r\n\r\n" +

                "{\"id\":\"2\"}" }

    it 'contains 
      {
        verb: "PUT", 
        path: "/scientists/1", 
        body: "{\"id\":\"2\"}", 
        headers: {"Content-Type"=>"application/json", 
        "Content-Length"=>"10"}
      }' do
      expect(request.parse).to be == {
        verb: "PUT", 
        path: "/scientists/1", 
        body: "{\"id\":\"2\"}", 
        headers:
          {"Content-Type"=>"application/json", 
          "Content-Length"=>"10"}
      }
    end
  end 

  context 'it will parse a GET with body, no problem' do
    let(:req) { "GET /inventions/-666 \r\n" +
                "Content-Type: ANYTHING\r\n" + 
                "Power: OVER 9000\r\n\r\n" +

                "{some_key: 'some_value'}" }

    it 'contains corresponding parsed hash' do
      expect(request.parse).to be == {
        verb: "GET", 
        path: "/inventions/-666", 
        body: "{some_key: 'some_value'}", 
        headers:
          {"Content-Type"=>"ANYTHING", 
          "Power"=>"OVER 9000"}
      }
    end
  end
end
