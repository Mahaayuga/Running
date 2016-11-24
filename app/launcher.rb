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

  slim :slider, locals: { it_dates: my_run.all_inclusive("date"),  
                          it_temps: my_run.all_inclusive("temps"), 
                          it_dist: my_run.all_inclusive("dist"),
                          it_vitesse: my_run.all_inclusive("vitesse"),  
                          it_data: my_run.all_data(TRUE),  
                          it_marathon: my_run.all_data(FALSE) }
end

get '/graph' do
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")
  
  slim :graph, locals: { mes_x: my_run.all_inclusive("date"),
                         mes_y: my_run.all_inclusive("dist"),
                         mes_y2: my_run.all_inclusive("v.to_f") }
end

get '/courbes' do
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")

  slim :lines, locals: { mes_x: my_run.all_inclusive("date").reverse,
                         mes_y: my_run.all_inclusive("dist").reverse.cumulative_sum  }
end

get "/*" do
  redirect "/"
end
