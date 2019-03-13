require 'net/http'
require 'uri'
require 'yaml'

class HttpClient
  def initialize(file_name)
    post_data = YAML.load_file("./post_data/#{file_name}")
    @uri = post_data['uri']
    @form_data = post_data['form_data']
  end

  def create_uri
    URI.parse(@uri)
  end

  def post_http
    uri = create_uri
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(@form_data)
    res = Net::HTTP.new(uri.host, uri.port).start do |http|
      http.request(req)
    end
    puts res.body
  end
end

HttpClient.new(ARGV[0]).post_http

