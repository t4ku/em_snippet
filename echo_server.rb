require "rubygems"
require "eventmachine"

# From "An EventMachine Tutorial"
# http://20bits.com/articles/an-eventmachine-tutorial/

# ハンドラー
module EchoServer
  # connectionからデータを受け取った時に呼び出されるメソッド
  def receive_data(data)
    # receive_dataを呼び出したconnectionにデータを返す
    # receive_dataしたらsend_dataする
    send_data(data)
  end
end

# イベントループ開始
# EventMachine::stop_event_loopを呼び出すまで止まらない
EventMachine::run do
  host = '0.0.0.0'
  port = 8080
  
  # 3番目の引数はHandlerで、コールバック用の関数でグローバル変数を汚染しないために
  # moduleを定義することが多い。
  EventMachine::start_server host,port,EchoServer
  puts "started EchoServer on #{host}:#{port}"
end