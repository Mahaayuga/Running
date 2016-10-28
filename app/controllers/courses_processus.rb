require 'csv'
require 'date'
require 'time'
require_relative 'var_courses'

class CSVReader
  def initialize
    @course = []
  end

  def mise_en_memoire(csv_file_name)
    CSV.foreach(csv_file_name) do |row|
      @course << Courses.new(row[0], row[1], row[2], row[3])
    end	
  end

  def lecture
    puts @course
  end

  def dist_totale #OK
    sum = 0.0
    tmp = 0
    @course.each do |value|
      sum += value.dist
      tmp += value.temps.min * 60 + value.temps.sec
    end
    return sum
  end

  #Code pour le slider
  #Pour l'instant, je vais sortir toutes les variables séparément
  def all_temps
    temps = []
    @course.reverse_each do |item|
      temps << item.temps
    end
    return temps
  end

  def all_date
    dates = []
    @course.reverse_each do |item|
      dates << item.date.to_s
    end
    return dates
  end

  def all_dist
    dist = []
    @course.reverse_each do |item|
      dist << item.dist
    end
    return dist
  end

  def all_vitesse
    vitesse = []
    @course.reverse_each do |item|
      vitesse << item.vitesse
    end
    return vitesse
  end


  #Génération des graphiques
  def html_date
    dates = []
    @course.each do |value|
      dates << value.date.to_s
    end
    return dates
  end

  def html_dist
    dist = []
    @course.each do |value|
      dist << (value.dist.to_f)
    end
    return dist.inspect
  end

end
