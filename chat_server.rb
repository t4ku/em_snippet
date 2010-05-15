require "rubygems"
require "eventmachine"

# EventMachine: 高速でスケーラブルなEvent-Driven I/Oフレームワーク
# http://www.infoq.com/jp/news/2008/07/eventmachine

module Chat
  def post_init
    # クライアントリストに入れる
    (@@connections ||= []) << self  
    send_data "Please enter your name: "
  end
  
  # クライアントからデータを受け取るたびに実行される
  def receive_data(data)
    @name ||= data.strip
    
    @@connections.each do |client|
      client.send_data "#{@name} says: #{data}"
    end
  end
end

EventMachine::run do
  EventMachine::start_server "localhost",8081,Chat
end