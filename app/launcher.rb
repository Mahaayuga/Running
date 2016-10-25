require 'sinatra'
require 'slim'
require 'csv'
require_relative 'controllers/courses_processus.rb'

=begin
before do
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")
  my_run.dist_totale
  #slim :slider, locals: { nom: my_run.html_dist } #ça, ça marche!
end
=end

get '/' do 
  slim :index
end

get '/slider' do
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")

  slim :slider, locals: { nom: my_run.dist_totale, test: "test" }
end

get '/graph' do
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")
  
  slim :graph, locals: { mes_x: my_run.html_date, mes_y: my_run.html_dist }
end

get "/*" do
  redirect "/"
end
