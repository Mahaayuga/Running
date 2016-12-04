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

  # SLIDER
  def all_inclusive(type)
    mydata = []
    @course.reverse_each do |item|
      mydata << item.date.to_s if type == "date"
      mydata << item.temps     if type == "temps"
      mydata << item.dist      if type == "dist"
      mydata << item.vitesse   if type == "vitesse"
      mydata << item.vitesse.min / 60.00 + item.vitesse.sec / 3600.00 if type == "v.to_f"
      mydata << item.temps.min / 60.000 + item.temps.sec / 3600.000   if type == "t.to_f"
    end
    return mydata 
  end  

  def all_case(type)  #même principe que all_inclusive mais avec le case #frime
    mydata = []
    @course.reverse_each do |item|
      
      case type
        when "date"    then mydata << item.date.to_s
        when "temps"   then mydata << item.temps
        when "t.to_f"  then mydata << item.temps.min / 60.000 + item.temps.sec / 3600.000
        when "dist"    then mydata << item.dist
        when "vitesse" then mydata << item.vitesse.strftime("%-M:%S")
        when "v.to_f"  then mydata << item.vitesse.min / 60.000 + item.vitesse.sec / 3600.000
      end

    end
    return mydata
  end

  def all_data (marathon)
    mydata = { run: 0, duree: 0, str_duree: "" , dist: 0 }
    
    @course.reverse_each do |item|
      mydata[:run]  += 1
      mydata[:duree] += item.temps.min * 60 + item.temps.sec
      mydata[:dist]  += item.dist
      break if mydata[:dist] >= 42.195 unless marathon
   end

    tmp = sec_to_hour(mydata[:duree])
    mydata[:str_duree] = "#{tmp[:hh]} heures #{tmp[:mm]}"
    
    return mydata
  end

  def sec_to_hour (secondes)
    #Conversion sec => heures
    myhour = { hh: 0, mm: 0, ss:0 }
    myhour[:mm], myhour[:ss] = secondes.divmod(60)
    myhour[:hh], myhour[:mm] = myhour[:mm].divmod(60)
    
    return myhour
  end

  # WORK IN PROGRESS MOYENNE HEBDO
  def data_hebdo (ww, type)
    mydata = { sum: 0, nb: 0 }
    
    ww, aa = ww.to_s.split(".")
    
    @course.each do |item|
      if ww.to_i == item.date.strftime("%W").to_i && item.date.year == aa.to_i then

        case type
          when "dist"   then mydata[:sum] += item.dist
          when "t.to_f" then mydata[:sum] += item.temps.min / 60.000 + item.temps.sec / 3600.000
        end
        mydata[:nb] += 1
      end
    end
    
    return mydata[:nb] != 0 ? mydata[:sum].round(3) : Float::NAN 
    
  end
end

class Array
  def cumulative_sum
    sum = 0
    self.map{|x| sum += x}
  end
end
