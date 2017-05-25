require 'sinatra'
require 'slim'
require_relative 'controllers/courses_processus.rb'

#int variable
my_run = Courses.new
my_run.mise_en_memoire("../db/data.csv")


get '/' do

  #nouvelles chaussures
  asics = Date.parse('2016-12-10')

  slim :index, locals: { debut: my_run.premier,
                         it_data: my_run.all_data(TRUE),
                         it_shoes: my_run.all_data(asics),
                         it_marathon: my_run.all_data("marathon") }

end

get '/slider/:qt' do

  slim :slider, locals: { it_dates: my_run.catalogue("date"),
                          it_temps: my_run.catalogue("temps"),
                          it_dist: my_run.catalogue("dist"),
                          it_vitesse: my_run.catalogue("vitesse") }

end

get '/slider' do

  slim :slider, locals: { it_dates: my_run.catalogue("date"),
                          it_temps: my_run.catalogue("temps"),
                          it_dist: my_run.catalogue("dist"),
                          it_vitesse: my_run.catalogue("vitesse") }
end

get '/graph' do

  slim :graph, locals: { mes_x: my_run.catalogue("date"),
                         mes_y: my_run.catalogue("dist"),
                         mes_y2: my_run.catalogue("v.to_f") }
end

get '/courbes' do

  slim :lines, locals: { mes_x: my_run.catalogue("date").reverse,
                         mes_y: my_run.catalogue("dist").reverse.cumulative_sum }
end

get '/hebdo' do

  #calcul hebdo
  x_hebdo = []
  y_hebdo = []
  y2_hebdo = []

  2016.upto(2017) do |yy|
    a, b = 37, 52                if yy == 2016
    a, b =  1, Date.today.cweek  if yy == 2017  

    a.upto(b) do |ww|
      x_hebdo  << ww
      y_hebdo  << my_run.data_hebdo("#{ww}.#{yy}", "dist"  )
      y2_hebdo << my_run.data_hebdo("#{ww}.#{yy}", "t.to_f")
    end
  end

  slim :hebdo, locals: { mes_x: x_hebdo,
                         mes_y: y_hebdo,
                         mes_y_2: y2_hebdo }

end

# get "/*" do
#   redirect "/"
# end
