require "net/http"
require "uri"

uri = URI.parse('http://13.112.58.85/echo/index.html')

req = Net::HTTP::Post.new(uri.path)
req.set_form_data({test: 'test_data'})
res = Net::HTTP.new(uri.host, uri.port).start do |http|
  http.request(req)
end
puts res.body

