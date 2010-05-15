require "rubygems"
require "eventmachine"

# From "An EventMachine Tutorial"
# http://20bits.com/articles/an-eventmachine-tutorial/

class Server < EventMachine::Connection
  attr_accessor :options,:status
  
  def receive_data
    puts "#{@status} -- #{data}"
    send_data("hello\n")
  end
end

EventMachine::run do
  # start_serverは3番目の引数に指定されたハンドラーを引数にyeildする
  EM::start_server host,port,Server do |conn|
    conn.options = {:my => 'options'}
    conn.status = :OK
  end
end