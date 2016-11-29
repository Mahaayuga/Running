require 'csv'
require_relative 'courses_processus'

run = CSVReader.new
run.mise_en_memoire("../../db/data.csv")

# mes_data = run.all_inclusive("t.to_f")

# calcul du n° de semaine
# puts Time.now.strftime("%W").to_i # 26/11 => 47

# calcul de moyenne sur une partie d'un tableau
# five = mes_data[0..4].inject(0, :+) / mes_data[0..4].count
# printf "%i'%i \n",  five * 60, ( five * 3600 % 60 )

=begin
# calcul de la moyenne hebdo
my_x = []
my_y = []

37.upto(47) do |ww|
  my_x << ww
  my_y << run.data_hebdo("#{ww}.2016")
end

print my_y
print "\n"
=end

print run(@course)
print "\n"
