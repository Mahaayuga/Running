require 'csv'
require 'date'
require 'time'

class Courses

  def initialize
    @course = []
  end

  def mise_en_memoire(csv_file_name)
    CSV.foreach(csv_file_name) do |row|
      @course << CSVReader.new(row[0], row[1], row[2], row[3])
    end
  end

  # SLIDER
  def catalogue(type)
    mydata = []

   @course.reverse_each do |item|
      mydata << item.date.to_s  if type == "date"
      mydata << item.temps      if type == "temps"
      mydata << item.dist       if type == "dist"
      mydata << item.vitesse    if type == "vitesse"
      mydata << to_hour_float(item.vitesse) if type == "v.to_f"
      mydata << to_hour_float(item.temps)   if type == "t.to_f"
    end

    return mydata
  end

  def all_data (borne)
    mydata = { run: 0, duree: 0, str_duree: "" , dist: 0, allure: "" }

    @course.reverse_each do |item|
      mydata[:run]   += 1
      mydata[:duree] += to_seconde(item.temps)
      mydata[:dist]  += item.dist

      break if borne.is_a?(Date) and item.date <= borne
      break if mydata[:dist] >= 42.195 && borne == "marathon"

    end

    tmp = sec_to_hour(mydata[:duree])
    mydata[:str_duree] = "#{tmp[:hh]} heures #{tmp[:mm] unless tmp[:mm] == 0}"
    mydata[:allure]    = to_allure( mydata[:dist], mydata[:duree] )

    return mydata
  end

  def hall_of_fame
    return @course.sort_by(&:dist).last
  end

  def premier
    return @course.first.date
  end


# --------- Methode Conversion horaire ---------------

  def to_seconde(durée)
    durée.hour * 3600 + durée.min * 60 + durée.sec
  end

  def to_hour_float(durée)
    durée.hour + durée.min / 60.000 + durée.sec / 3600.000
  end

  def sec_to_hour (secondes)
    #Conversion sec => heures
    myhour = { hh: 0, mm: 0, ss: 0 }
    myhour[:mm], myhour[:ss] = secondes.divmod(60)
    myhour[:hh], myhour[:mm] = myhour[:mm].divmod(60)

    return myhour
  end

# --------- Conversion vitesse -----
  def to_allure (dist, durée)
    myallure = { mm: 0, ss: 0 }
    tmp = durée / 60 / dist

    #premier calcul
    myallure[:mm] = tmp.to_i
    myallure[:ss] = ( (tmp - myallure[:mm]) *60 ).round

    #check pour éviter un 5min60sec
    if myallure[:ss] == 60 then
      myallure[:mm] += 1
      myallure[:ss]  = 0
    end

    return myallure
  end

  # WORK IN PROGRESS MOYENNE HEBDO
  def data_hebdo (ww, aa, type)
    mydata = { sum: 0, nb: 0 }

    @course.each do |item|
      if ww.to_i == item.date.strftime("%W").to_i && item.date.year == aa.to_i then

        case type
          when "dist"   then mydata[:sum] += item.dist
          when "t.to_f" then mydata[:sum] += to_hour_float(item.temps)
        end
        mydata[:nb] += 1
      end
    end

    return mydata[:nb] != 0 ? mydata[:sum].round(3) : Float::NAN
  end
  # --------------------------------------------------------------------------
  # --------------------------------------------------------------------------
  def data_hebdo_test (ww, aa, type)
    mydata = { dist: 0, tps:0, nb: 0 }

    @course.each do |item|
      if ww.to_i == item.date.strftime("%W").to_i && item.date.year == aa.to_i then
        mydata[:dist] += item.dist
        mydata[:tps] += to_hour_float(item.temps)
        mydata[:nb] += 1
      end
    end

    case type
      when "dist"  then return mydata[:nb] != 0 ? mydata[:dist].round(3) : Float::NAN
      when "rythm" then return mydata[:nb] != 0 ? (mydata[:dist] / mydata[:tps]).round(1) : Float::NAN
    end
  end
# --------------------------------------------------------------------------
# --------------------------------------------------------------------------
  def rythme_mensuel (mois)
    mydata = { dist: 0, duree_sec: 0, allure: '' }

    mois, aa = mois.to_s.split(".")

    @course.each do |item|
      if mois.to_i == item.date.strftime("%-m").to_i && item.date.year == aa.to_i then
        mydata[:dist]      += item.dist
        mydata[:duree_sec] += to_seconde(item.temps)
      end
    end

    return to_allure(mydata[:dist], mydata[:duree_sec] )

  end
end


# --------- Extraction .CSV  ---------------
class CSVReader

  attr_reader :date, :temps, :dist, :vitesse

  def initialize (date, temps, dist, vitesse)
    @date = Date.strptime(date, "%Y%m%d")
    @temps = Time.strptime(temps, "%H:%M:%S")
    @dist = dist.to_f
    @vitesse = Time.strptime(vitesse, "%M:%S")
  end

  def to_s
    @temps = @temps.strftime "%l:%M:%S"
    @vitesse = @vitesse.strftime "%-M:%S /km"
    "#@date\t#@temps\t#@dist km\t#@vitesse"
  end
end


class Array
  def cumulative_sum
    sum = 0
    self.map{|x| sum += x}
  end
end
