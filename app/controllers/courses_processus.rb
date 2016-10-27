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

  #Pour l'instant, je vais sortir toutes les variables séparément
  def all_date
    dates = []
    @course.reverse_each do |item|
      dates << item.date.to_s
    end
    return dates
  end

  #Génération du HTML
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

  def html_slider
    bool = true
    @course.reverse_each do |item|
      
      if bool == true 
        printf '  <div class="frame dragscroll">'+"\n"
        bool = false
      end
        printf '    <div class="silder">'+"\n"
        printf "      <h2>%s</h2>\n", item.date.strftime("%-d %b %Y")
        printf '      <img src="img/'+ item.date.to_s + '.png" alt="image">'+"\n"
        printf "      <p>%s</p><p>%2.1f km</p><p>%s /km</p>\n",item.temps.strftime("%M'%S"), item.dist, item.vitesse.strftime("%-M:%S")
        printf "    </div>\n"
    end
    printf "  </div>\n"
  end  

end
