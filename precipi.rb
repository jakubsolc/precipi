##
##  pred spustenim:
##
##  export PATH=$PATH:/home/alena/Dropbox/seleni/geckodriver
##
##  pozor, do clipboardu se vejde jen prvnich 224 radku

## TODO: udelat to jen pomoci open-uri
# # open('image.png', 'wb') do |file|
# #   file << open('http://example.com/image.png').read
# # end


## sudo gem install nokogiri
## sudo gem install activesupport

require 'active_support/core_ext/hash'
require 'open-uri'
require 'nokogiri'

ur = 'http://hydro.chmi.cz/hpps/hpps_srzstationdyn.php?day_offset=0&seq=307489&x=13'

if ARGV.length < 1
  dayidx = 3 .to_s;
else
  dayidx = ARGV[0];
end
x = open(ur);
#x = open(ur).read
#n = Hash.from_xml(a.gsub('&','(ET)').gsub('\n','(NL)'))
n = Nokogiri::XML(x);

#dat = n.xpath('//xmlns:table/*[3]//*').each {|q| p q.text}
#dats = n.xpath('//xmlns:table/*[3]//*');
dats = n.xpath('//xmlns:table/*['+dayidx+']//*');
if dayidx.to_i>=5 
    dat = dats[0].text;
  else
    dat = dats[2].text;
end


acc = [];
#n.xpath('//xmlns:table/*[5]/*[@class="e_0"]').each {|q| puts q.text}
#n.xpath('//xmlns:table/*[3]/*[@class="e_0"]').each {|q| acc.push(q.text)};
#n.xpath('//xmlns:table/*[3]/*[@class="e_1"]').each {|q| acc.push(q.text)};
n.xpath('//xmlns:table/*[' + dayidx + ']/*[@class="e_0"]').each {|q| acc.push(q.text)};
n.xpath('//xmlns:table/*[' + dayidx + ']/*[@class="e_1"]').each {|q| acc.push(q.text)};
arr = acc.map { |q| (q.to_f*10).to_i };
ars = arr.map {|q| "%2d " % q } .join

suum = [];
n.xpath('//xmlns:table/*[' + dayidx + ']/*[@class="sdt"]').each {|q| suum.push(q.text)};
suumi = suum.map { |q| (q.to_f) };
sums = suumi.map {|q| "  %5.1f " % q } .join


#p arr

# p dat
# p ars
puts dat + "    " + ars + " " + sums;