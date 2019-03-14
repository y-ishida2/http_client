require 'net/http'
require 'uri'
require 'yaml'

class HttpClient
  def initialize(file_name)
    post_data = YAML.load_file("./post_data/#{file_name}")
    @uri = post_data['uri']
    @thread_counts = post_data['thread_counts']
    @form_data = post_data['form_data']
  end

  def create_uri
    URI.parse(@uri)
  end

  def post_http
    uri = create_uri
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(@form_data)
    threads = []
    @thread_counts.times do
      threads << Thread.new do
        res = Net::HTTP.new(uri.host, uri.port).start do |http|
          http.request(req)
        end
        puts res.body
      end
    end
    threads.each { |thr| thr.join }
    puts "同時に#{@thread_counts}回アクセスしました。"
  end
end

if __FILE__ == $0
  unless ARGV.size == 1
    puts 'usage: $ ruby http_client_post.rb <file_name>'
    exit!
  end

  begin
    HttpClient.new(ARGV[0]).post_http
  rescue
    puts 'エラーが発生しました。'
  end
end

