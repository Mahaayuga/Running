require 'time'
require_relative 'courses_processus'

run = Courses.new
run.mise_en_memoire("../../db/data.csv")


puts run.rythme_mensuel ("8.2017")

#puts montest[:allure][:mm]

# Test sur methode 'data-hebdo'
#printf "#{run.data_hebdo(20.2017, 'dist'  )}\n"
#printf "#{run.data_hebdo(20.2017, 't.to_f')}\n"

#print run.to_seconde(Time.now)

# mes_data = run.all_inclusive("t.to_f")

# calcul de moyenne sur une partie d'un tableau
# five = run[0..4].inject(0, :+) / run[0..4].count
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
#puts run.all_data("marathon")

#myTime = Time.strptime(temps, "0:40:33")
#myTime = Time.at(46*3600+4*60)


#print myTime.strftime("%M")
#print myTime
#print"\n"
#print run.to_hour_float(myTime)
print"\n"
#print run.to_min_float(myTime)
#print run.to_allure(459.3,myTime)
#print"\n"


# calcul du n° de semaine
# puts Time.now.strftime("%W").to_i # 26/11 => 47
# print Date.today.cweek
# print"\n"
