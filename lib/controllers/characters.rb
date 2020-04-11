get '/api/characters' do
  content_type :json
  Character.all.to_json include: :categories
end
