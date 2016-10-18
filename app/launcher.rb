require 'sinatra'
require 'slim'
require 'csv'
require_relative 'controllers/courses_processus'

=begin
before do
  run = CSVReader.new
  run.mise_en_memoire("/db/data.csv") #"../db/data.csv ??
end
=end

get '/' do 
  slim :index
end

get '/slider' do
  slim :slider
end

get '/graph' do
  slim :graph
end
