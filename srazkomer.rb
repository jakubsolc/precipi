##
##  prekonana verze, viz precipi
##    zde selenium, precipi parsuje pomoci nokogiri
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

#require 'active_support/core_ext/hash'
#require 'open-uri'
#

## ur = 'http://hydro.chmi.cz/hpps/hpps_srzstationdyn.php?day_offset=0&seq=307489&x=13'
## a = open(ur).read
## Hash.from_xml(a.gsub('&','(ET)').gsub('\n','(NL)'))

require 'selenium-webdriver'
require 'open-uri'

d = Selenium::WebDriver.for :firefox
d.navigate.to "http://hydro.chmi.cz/hpps/hpps_srzstationdyn.php?day_offset=0&seq=307489&x=13"

d.execute_script("hideSrzData('0', 'e');");
e = d.find_element(:class, 'tsrz');
f = e.find_elements(:tag_name, 'tr');
g = f[1];
##print g.text
h1 = g.text;

d.execute_script("hideSrzData('1', 'e');");
e = d.find_element(:class, 'tsrz');
f = e.find_elements(:tag_name, 'tr');
g = f[1];
##print g.text
h2 = g.text;
print h1 + " --- " + h2 + "\n"