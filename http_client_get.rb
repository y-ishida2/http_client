require "net/http"
require "uri"

class HttpClient
  def create_uri(uri)
    URI.parse(uri)
  end

  def get_http(uri)
    uri = create_uri(uri)
    req = Net::HTTP::Get.new(uri.path)
    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(req)
    end
    puts res.body
  end
end

HttpClient.new.get_http(ARGV[0])

