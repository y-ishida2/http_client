require "net/http" require "uri" 
uri = URI.parse('http://13.112.58.85/echo/index.html')

req = Net::HTTP::Get.new(uri.path)
res = Net::HTTP.start(uri.host, uri.port) do |http|
  http.request(req)
end
puts res.body

