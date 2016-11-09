require 'csv'
require_relative 'courses_processus'

run = CSVReader.new
run.mise_en_memoire("../../db/data.csv")

puts run.all_case "dist"


