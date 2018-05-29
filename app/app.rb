require 'date'
require 'sinatra'
require 'slim'
require_relative 'controllers/courses_processus.rb'

#int variable
my_run = Courses.new
my_run.mise_en_memoire("../db/data-reworked.csv")
#my_run.mise_en_memoire("../db/data.csv")

#style du graphique
chart_css = IO.read("./public/css/chart.js.css")

get '/' do

  #nouvelles chaussures
  #asics = Date.parse('2016-12-10')
  asics = Date.parse('2018-05-11')

  slim :index, locals: { debut:       my_run.premier,
                         it_data:     my_run.all_data(Float::NAN),
                         it_shoes:    my_run.all_data(asics),
                         it_year:     my_run.all_data(Date.today.prev_year),
                         it_marathon: my_run.all_data("marathon"),
                         halloffame:  my_run.hall_of_fame}

end

get '/slider' do

  slim :slider, locals: { it_dates:   my_run.catalogue("date"),
                          it_temps:   my_run.catalogue("temps"),
                          it_dist:    my_run.catalogue("dist"),
                          it_vitesse: my_run.catalogue("vitesse") }
end

get '/courbes' do

  slim :lines, locals: { mes_x: my_run.catalogue("date").reverse,
                         mes_y: my_run.catalogue("dist").reverse.cumulative_sum }
end

get '/hebdo' do

  #calcul hebdo
  x_hebdo, y_hebdo, y2hebdo = [], [], []

  début = Date.new(2016,9,15)
  today = Date.today
  arr = []

  (début..today).to_a.each do |n|
    arr << n.year.to_s.concat("." + n.cweek.to_s) unless arr.last ==  n.year.to_s.concat("." + n.cweek.to_s) or arr.last.to_s[-2,2] == n.cweek.to_s
  end

  arr.each do |x|
      yy, ww = x.split(".")
      x_hebdo  << ww
#     y_hebdo  << my_run.data_hebdo(ww, yy, "dist")
#     y2hebdo  << my_run.data_hebdo(ww, yy, "t.to_f")
      y_hebdo  << my_run.data_hebdo_test(ww, yy, "dist")
      y2hebdo  << my_run.data_hebdo_test(ww, yy, "rythm")
  end

  slim :hebdo, locals: {        mes_x: x_hebdo,
                                mes_y: y_hebdo,
                               mes_y2: y2hebdo,
                         my_chart_css: chart_css   }

end

# get "/*" do
#   redirect "/"
# end
