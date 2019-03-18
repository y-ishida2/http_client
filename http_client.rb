require 'net/http'
require 'uri'
require 'yaml'

class HttpClient
  def initialize(file_name)
    unless File.exist?("./request_data/#{file_name}")
      raise 'ファイル名が正しくありません。'
    end

    request_data = YAML.load_file("./request_data/#{file_name}")
    begin
      @uri = request_data['uri']
      @thread_counts = request_data['thread_counts']
      @type = request_data['type']
      @params = request_data['params']
    rescue
      raise 'request_dataの形式が正しくありません。'
    end
  end

  def http_request
    uri = URI.parse(@uri)

    if @type == 'get'
      uri.query = URI.encode_www_form(@params)
      req = Net::HTTP::Get.new(uri)
    end

    if @type == 'post'
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(@params)
    end

    threads = []
    @thread_counts.times do
      threads << Thread.new do
        res = Net::HTTP.start(uri.host, uri.port) do |http|
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
    puts 'usage: $ ruby http_client.rb <file_name>'
    exit!
  end

  begin
    HttpClient.new(ARGV[0]).http_request
  rescue => e
    puts 'エラーが発生しました。'
    puts e.message
  end
end
