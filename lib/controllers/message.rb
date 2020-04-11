get '/api/messages' do
  payload = Message.all
  sleep(2.seconds)
  json payload
end
