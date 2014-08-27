require 'rubygems'
require 'net/http'
require 'CSV'
require 'JSON'
require 'pp'

def check_data(inpath, outpath)
  tags= ["scientificName", "rank","family", "canonicalName", "confidence", "matchType"]

  CSV.open(outpath, "wb") do |out|
    # :headers option indicates the file has a header row
    CSV.foreach(inpath, :headers => true, :col_sep => "\t") do |row|  
      outrow=row
      origname= row['name'].split(' ')[0] + ' ' + row['name'].split(' ')[1]
#     pp origname
      url = URI.parse('http://api.gbif.org/v1/species/match?name='+origname.gsub(' ','%20'))
      res = Net::HTTP.get_response(url)
      resp= JSON.parse(res.body)
      tags.each {|t| outrow["_" + t]=resp[t] }
      out << outrow
    end
  end
end

check_data(ARGV[0],ARGV[1])




