require 'date'
require 'time'

class Courses
  attr_reader :date, :temps, :dist, :vitesse

  def initialize (date, temps, dist, vitesse)
    @date = Date.strptime(date, "%Y%m%d")
    @temps = Time.strptime(temps, "%H:%M:%S") #
    @dist = dist.to_f
    @vitesse = Time.strptime(vitesse, "%M:%S") #.strftime "%M:%S /km"
  end
  def to_s
    @temps = @temps.strftime "%M:%S"
    @vitesse = @vitesse.strftime "%M:%S /km"
    "#@date\t#@temps\t#@dist km\t#@vitesse"
  end
end
