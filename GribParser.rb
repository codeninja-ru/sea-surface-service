require 'csv'

class GribParser
  def initialize(filePath)
      puts filePath
    @csvPath = filePath
  end
  def exec
    CSV.foreach(@csvPath) do |row|
      name  = row[2]
      long  = row[4]
      lat   = row[5]
      val   = temp_convert row[6].to_i
      puts "#{name} long = #{long} lat = #{lat} val = #{val}"
    end
  end
  def temp_convert(kelvin)
    kelvin-273.15
  end
end

