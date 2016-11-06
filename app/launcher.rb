require 'sinatra'
require 'slim'
require 'csv'
require_relative 'controllers/courses_processus.rb'

get '/' do 
  slim :index
end

get '/slider' do
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")

  slim :slider, locals: { it_dates: my_run.all_date,  
                          it_temps: my_run.all_temps, 
                          it_dist: my_run.all_dist,  
                          it_vitesse: my_run.all_vitesse,  
                          it_data: my_run.all_data,  
                          it_marathon: my_run.marathon }
end

get '/graph' do
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")
  
  slim :graph, locals: { mes_x: my_run.all_date, mes_y: my_run.all_dist, mes_y2: my_run.all_temps }
end

get "/*" do
  redirect "/"
end
