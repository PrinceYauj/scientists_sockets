require 'socket'

serv = Socket.new(:INET, :STREAM, 0)
addr = Socket.sockaddr_in(3000, '127.0.0.1')
serv.bind(addr)
serv.listen(1)

client, _ = serv.accept
request = client.recv(1000)
puts request
client.send("HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n
Content-Length: #{'Basic response'.length}\r\n\r\nBasic response", 0)

client.close
serv.close
