require 'rubygems'
require 'CSV'
require 'JSON'
require 'pp'
#require 'UTMconvert'

class CoordPoint
  attr_reader :lat, :long, :uncertainty
  def initialize(lat, long,uncertainty)
    @lat=lat
    @long=long
    @uncertainty=uncertainty
  end
end

class Format
  attr_reader :name, :re, :conversion
  def initialize(name, re, conversion)
    @name=name
    @re=re
    @conversion=conversion
  end

  def try(str)

    if md=re.match(str)
#     puts str + ': '+ name + re.to_s + conversion.to_s

      p=case conversion
      when 1 then ## Decimal degrees Lat-Long
        CoordPoint.new((md[1]+'.'+md[2]).to_f, ( -1*(md[3]+'.'+md[4]).to_f),1000)
      when 2 then ## Degree-Minutes Lat-Long
        CoordPoint.new(md[1].to_f+md[2].to_f/60, -1*(md[3].to_f+md[4].to_f/60),1500)
      when 3 then ## Degree-Decimal Minutes Lat-Long
        CoordPoint.new(md[1].to_f+(md[2]+'.'+md[3]).to_f/60, -1*(md[4].to_f+(md[5]+'.'+md[6]).to_f/60),100)
      when 4 then ## Degree-Minutes-Seconds Lat-Long
        CoordPoint.new(md[1].to_f+md[2].to_f/60+md[3].to_f/3600, -1*(md[4].to_f+md[5].to_f/60+md[6].to_f/3600),50 )
      when 5 then ## Degree-Minutes-Decimal Seconds Lat-Long
        CoordPoint.new(md[1].to_f+md[2].to_f/60+(md[3]+'.'+md[4]).to_f/3600, -1*(md[5].to_f+md[6].to_f/60+(md[7]+'.'+md[8]).to_f/3600),100)
      when 9 then
        latlon = Array.new(2)
 #       UTMXYToLatLon(md[2].to_f, md[1].to_f, 32, false, latlon)
        CoordPoint.new(RadToDeg(latlon[0]),RadToDeg(latlon[1]), 100)
      else nil
      end
      return p
    end
  end
end


Formats= [
 Format.new("DecDegreesNW",/(\d+)\.(\d+)°N,(\d+)\.(\d+)°W/,1) ,
# Format.new("DecDegrees1" , /N(\d+)°(\d+)E(\d+)°(\d+)/,1) ,
# Format.new("DecDegrees2" , /N(\d+)\.(\d+)E(\d+)\.(\d+)/,1) ,
# Format.new("DecDegrees3" , /N(\d+)\.(\d+)°?E(\d+)\.(\d+)°?/,1) ,
# Format.new("DecDegrees4" , /N(\d+)\.(\d+)E(\d+)°(\d+)/,1) ,
# Format.new("DecDegrees5" , /N(\d+)°(\d+)E(\d+)\.(\d+)/,1) ,
  Format.new("Degrees-MinutesNW" , /(\d+)°(\d+)’N,(\d+)°(\d+)’W/, 2) ,
# Format.new("Degrees-MinutesPre" , /N(\d+)°(\d+)'?E(\d+)°(\d+)'?/, 2) ,
  Format.new("Degrees-DecMinutesNW" , /(\d+)°(\d+)\.(\d+)’?N,(\d+)°(\d+)\.(\d+)’?W/, 3),
# Format.new("Degrees-DecMinutesPre" , /N(\d+)°(\d+)\.(\d+)'?E(\d+)°(\d+)\.(\d+)'?/, 3),
# Format.new("Degrees-Minutes-SecondesNW" , /(\d+)°(\d+)’(\d+)’’N,(\d+)°(\d+)’(\d+)’’W/, 4),
 
 
 Format.new("Degrees-Minutes-SecondesNW" , /(\d+)°(\d+)'(\d+)N,(\d+)°(\d+)'(\d+)W/, 4),

# Format.new("Degrees-Minutes-SecondesPre" , /N(\d+)°(\d+)'(\d+)''E(\d+)°(\d+)'(\d+)''/, 4),
 Format.new("Degrees-Minutes-DecSecondesNW" , /(\d+)°(\d+)’(\d+)\.(\d+)’’N,(\d+)°(\d+)’(\d+)\.(\d+)’’W/, 5),
# Format.new("Degrees-Minutes-Secondes" , /(\d+)°(\d+)'(\d+\.\d+)"E(\d+)°(\d+)'(\d+\.\d+)"N/, 5),
# Format.new("Degrees-DecMinutesPost" , /(\d+)°(\d+)\.(\d+)'?E(\d+)°(\d+)\.(\d+)'?N/, 6),
# Format.new("UTM" , /UTMNg(\d+)Eg(\d+)/, 7),

]


def convertCoordinates(args)
  p=nil
  
  coordText=args.gsub(/ /, '');
#  coordText=args.gsub(/,/,'.');
#  coordText=args.gsub(/ /,'');
#  coordText=coordText.gsub(/[\)º]/u,'°');
  
  Formats.each { |f|
    if p=f.try(coordText)
      return p
    end
  } 
  return p
end



def check_data(inpath, outpath)

  count=0
  line=0
  CSV.open(outpath, "wb") do |out|
    # :headers option indicates the file has a header row
    CSV.foreach(inpath, :headers => true, :col_sep => ';') do |row|  
      line+=1
      outrow=[row['locality'], row['region'], row['coordinates']]
#      pp row
      p=convertCoordinates(row['coordinates'])
      if (p)
        count+=1
        outrow << p.lat.to_s << p.long.to_s << p.uncertainty.to_s
      else
        puts "No match for line #{line} : #{row['coordinates']}"
        outrow << ["" , ""]
      end
      out << outrow
    end
  end
  puts "Coordinates converted: #{count}  on #{line}" 

end

check_data(ARGV[0],ARGV[1])
#re=/(\d+)°(\d+)’N, (\d+)°(\d+)’W/
#if md=re.match('21°47’N, 12°07’W')
#  pp md
#end

