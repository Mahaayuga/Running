require 'sinatra'
require 'slim'
require 'csv'
require_relative 'controllers/courses_processus.rb'

get '/' do 
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")

  #nouvelles chaussures 
  asics = Date.parse('2016-12-10')

  slim :index, locals: { it_dates: my_run.all_inclusive("date"),
                         it_data: my_run.all_data(TRUE),
                         it_shoes: my_run.all_data(asics),
                         it_marathon: my_run.all_data("marathon") }
end

get '/slider' do
  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")

  slim :slider, locals: { it_dates: my_run.all_inclusive("date"),  
                          it_temps: my_run.all_inclusive("temps"), 
                          it_dist: my_run.all_inclusive("dist"),
                          it_vitesse: my_run.all_inclusive("vitesse") }
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
                         mes_y: my_run.all_inclusive("dist").reverse.cumulative_sum }
end

get '/hebdo' do

  #init variable
  my_run = CSVReader.new
  my_run.mise_en_memoire("../db/data.csv")

  #calcul hebdo
  x_hebdo = []
  y_hebdo = []
  y2_hebdo = []

  2016.upto(2017) do |yy|
    a, b = 37, 52 if yy == 2016
    a, b = 1, 12   if yy == 2017    

    a.upto(b) do |ww|
      x_hebdo << ww	
      y_hebdo << my_run.data_hebdo("#{ww}.#{yy}", "dist")
      y2_hebdo << my_run.data_hebdo("#{ww}.#{yy}", "t.to_f")
    end
  end

  slim :hebdo, locals: { mes_x: x_hebdo,
                         mes_y: y_hebdo,
                         mes_y_2: y2_hebdo }

end

get "/*" do
  redirect "/"
end
