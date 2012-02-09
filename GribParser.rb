require 'csv'
require 'mongo'
#db.sea.ensureIndex({ loc: "2d"}, { bits: 26, unique: true});

class GribParser
  def initialize(filePath)
    @csvPath = filePath
    @conn = Mongo::Connection.new("localhost", 27017)
    @mongo_db = @conn.db("weather")
    @collection = @mongo_db.collection("sea")
  end
  def exec
    CSV.foreach(@csvPath) do |row|
      name  = row[2]
      long  = row[4].to_f
      lat   = row[5].to_f
      val   = temp_convert row[6].to_i
      self.add_to_db(name, long, lat, val)
    end
  end

  def add_to_db(name, long, lat, temp)
    record = { "loc" => [long, lat], "temp" => temp, "val" => 1 }
    item = @collection.find_one({"loc" => [long, lat]});
    if item.nil? 
      @collection.insert(record) 
    else
      item["temp"] = temp
      item["val1"] = 1
      @collection.save(item)
    end
    puts "#{name} long = #{long} lat = #{lat} val = #{temp}"
  end

  def temp_convert(kelvin)
    kelvin-273.15
  end
end

