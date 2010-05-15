require "rubygems"
require "eventmachine"

# From "An EventMachine Tutorial"
# http://20bits.com/articles/an-eventmachine-tutorial/

module HttpHeaders
  # connectionがセットアップされた直後に呼び出される。
  # クライアントアプリならサーバーにつながった直後/サーバーアプリならクライアントが接続してきた直後
  def post_init
    send_data "GET /\r\n\r\n"
    @data = ""
  end
  
  def receive_data(data)
    @data << data
  end
  
  # クライアント/サーバー側のいずれかの接続が終了した時
  # このhttp_clientの場合は、サーバーがデータを送り終えたら呼び出される
  def unbind
    puts "server have sent data"
    if @data =~ /[\n][\r]*[\n]/m
      $`.each do |line|
        puts ">>> #{line}"
      end
    end
    
    # ループを終了させる
    EventMachine::stop_event_loop
  end
end

EventMachine::run do
  EventMachine::connect "google.com",80,HttpHeaders
end
