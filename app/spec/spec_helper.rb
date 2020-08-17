require 'json'
require 'socket'

require_relative '/vagrant/app/byg/classes/classes'
require_relative '/vagrant/app/byg/rest/rest'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before do
    host = '127.0.0.1'
    port = 4000
    @server = Byg::Classes::Server.new(host, port)
    @client = TCPSocket.new(host, port)
    @serv_sock = @server.listener.accept
  end

  config.after do
    @client.close
    @serv_sock.close
    @server.listener.close
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

=begin
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
=end
end
