require "rubygems"
require "eventmachine"

# Playing with EventMachine
# http://everburning.com/news/playing-with-eventmachine/

# EventMachineとEMは同じ
# runでイベントループが開始されるが、引数として渡されるブロックをその前に実行する
EventMachine::run do
  # 定期的に実行されるタイマーを設定
  EM.add_periodic_timer(1) { puts "Tick ..." }
  
  # 指定した秒数が経過した後に、1回実行されるタイマーを設定
  EM.add_timer(3) do
    puts "I waited 3 seconds"
    EM.stop_event_loop
  end
end

puts "All done"


