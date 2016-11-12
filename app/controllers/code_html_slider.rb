require 'csv'
require_relative 'courses_processus'

run = CSVReader.new
run.mise_en_memoire("../../db/data.csv")

mes_x = run.all_inclusive("date")

puts Date.strptime(mes_x.first, "%Y-%m-%d")+1

#Date.strptime(it_dates.last, "%Y-%m-%d")
