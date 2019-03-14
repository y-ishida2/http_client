require "net/http"
require "uri"

class HttpClient
  def create_uri(uri)
    URI.parse(uri)
  end

  def get_http(uri, counts)
    uri = create_uri(uri)
    req = Net::HTTP::Get.new(uri.path)
    threads = []
    counts.times do
      threads << Thread.new do
        Net::HTTP.start(uri.host, uri.port) do |http|
          http.request(req)
        end
      end
    end
    puts threads.size
    threads.each { |thr| thr.join }
    #counts.times do
    #  Net::HTTP.start(uri.host, uri.port) do |http|
    #    http.request(req)
    #  end
    #end
    puts "同時に#{counts}回アクセスしました。"
  end
end

if __FILE__ == $0
  unless ARGV.size == 2
    puts 'usage: $ ruby http_client_get.rb <uri> <thread_counts>'
    exit!
  end

  begin
    HttpClient.new.get_http(ARGV[0], ARGV[1].to_i)
  rescue
    puts 'エラーが発生しました。'
  end
end

