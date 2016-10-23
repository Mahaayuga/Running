require 'csv'
require_relative 'courses_processus'

run = CSVReader.new
run.mise_en_memoire("../../db/data.csv")


run.html_slider
