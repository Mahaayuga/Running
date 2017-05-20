require 'csv'
require 'time'
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

7.upto(8) do |ww|
  my_x << ww
  my_y << run.data_hebdo("#{ww}.2017")
end

print my_y
print "\n"
=end

#asics = Date.parse('2016-12-10')
#puts asics.is_a?(Date)
#puts run.all_data(asics)

#myTime = Time.strptime(temps, "0:40:33")
#print myTime.strftime("%H")
#print"\n" 

print Date.today.cweek
print"\n" 
