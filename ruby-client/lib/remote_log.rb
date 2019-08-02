require 'net/http'

require_relative './proto/logservice_pb'

class RemoteLog

  def initialize(endpoint, client_name)
    @endpoint = endpoint
    @client_name = client_name
  end

  def log(level, msg)
    time = Time.now.utc
    date_time =  DateTime.new(:year => time.year, :month => time.month, :day => time.day,
                              :hours => time.hour, :minutes => time.min, :seconds => time.sec)

    message = LogMessage.new(:level => level,
                             :message => msg,
                             :date_time => date_time,
                             :source => @client_name)

    uri = URI("#{@endpoint}/post")
    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/x-protobuf;charset=UTF-8')
    request.body = LogMessage.encode(message)

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
  end

  def last(n = nil)
    if n.nil?
      uri = URI("#{@endpoint}/last")
      LogMessage.decode(Net::HTTP.get(uri))
    else
      uri = URI("#{@endpoint}/last/#{n}")
      LogMessageList.decode(Net::HTTP.get(uri))
    end
  end

end
