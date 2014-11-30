require 'sinatra'
require 'pg'
#require 'sinatra/reloader'
#require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)

  ensure
    connection.close
  end
end

get '/actors' do
  db_connection do |connection|
    @actors = connection.exec("SELECT name, id FROM actors ORDER BY name LIMIT 10")
  end
  erb :'actors/index'
end

get '/actors/:id' do
  @id = params[:id]

  erb :'actors/show'
end

get '/movies' do

  erb :'movies/index'
end

get '/movies/:id' do
  @id = params[:id]

  erb :'movies/show'
end
