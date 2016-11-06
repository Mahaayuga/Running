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

  def all_data
    mydata = { run:0, duree: 0, str_duree: "" , dist: 0 }
    @course.each do |item|
      mydata[:run]  += 1
      mydata[:duree] += item.temps.min * 60 +item.temps.sec
      mydata[:dist]  += item.dist
    end

    #Conversion sec => heures
    mm, ss = mydata[:duree].divmod(60)
    hh, mm = mm.divmod(60)
    mydata[:str_duree] = "#{hh} heures #{mm} minutes"
    
    return mydata
  end

  def marathon
    mydata = { run:0, duree: 0, str_duree: "", dist: 0 }

    @course.reverse_each do |item|
      mydata[:run]  += 1
      mydata[:duree] += item.temps.min * 60 +item.temps.sec
      mydata[:dist]  += item.dist
      break if mydata[:dist] >= 42.195
    end
    
    #Conversion sec => heures
    mm, ss = mydata[:duree].divmod(60)
    hh, mm = mm.divmod(60)
    mydata[:str_duree] = "#{hh}:#{mm}'"

    return mydata
  end


end
