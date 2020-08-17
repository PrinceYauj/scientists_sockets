require_relative 'requirements'

serv = Byg::Classes::Server.new('127.0.0.1', 3000)
serv.run

