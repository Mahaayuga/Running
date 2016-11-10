require 'csv'
require_relative 'courses_processus'

run = CSVReader.new
run.mise_en_memoire("../../db/data.csv")

print run.all_case "vitesse"
printf "\n"
print run.all_case "v.to_f"
printf "\n"

