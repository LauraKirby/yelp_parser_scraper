require 'nokogiri'
require 'pry'
# gem install nokogiri and pry
# pry allows REPL
# nokogiri turns html into an object
# when this file is run using ruby in terminal (e.g. 'ruby yelp_parser.rb'), 
# the binding.pry (at bottom of script) will open a pry shell
# and allow us to have access the script data (i.e. variables)


# REFACTOR
class Parser 

	def initialize (file, contents, doc)
		@file = file
		@contents = contents 
		@doc = Nokogiri::HTML(@contents)
	end 

	def title
		title3 = @doc.css('h1').text
	end

	def price_range
		price_range = @doc.css('div.iconed-list-avatar span').text
	end 

	def address 
		address = @doc.css('li.address').text
	end

	def hours #should turn this into a function, ruby nicely returns the result of hours 3
		hours = @doc.css('div div div.column.column-beta.sidebar div.bordered-rail div.ywidget.biz-hours').text
		hours2 = hours.gsub(/\n/,'')
		hours3 = hours2.gsub('   ','')
	end

end #end class 


file = File.open("fat-angel-san-francisco.html")
contents = file.read 
doc = Nokogiri::HTML(contents)

p1 = Parser.new(file,contents,doc)

#Create Nokogiri Object
# doc = Nokogiri::HTML(contents)


# the root of every html is 'document'

# CSS PATH - HEADER CSS PATH 
# wrap > div.biz-country-us > div > div.top-shelf > div > div.biz-page-header.clearfix > div.biz-page-header-left > h1


# THIS WORKS
# p title = doc.css('div.biz-country-us').css('div').css('div.top-shelf').css('div').css('div.biz-page-header.clearfix').css('div.biz-page-header-left').css('h1').text


# CALL .CSS FEWER TIMES -- COMBINE THE EMBEDED DIV'S & CLASSES
# p title = doc.css('div.biz-country-us div div.top-shelf div div.biz-page-header.clearfix div.biz-page-header-left h1').text
# p title2 = doc.css('div.biz-page-header-left').css('h1').text


# # YOU DO NOT HAVE TO LIST THE ENTIRE PATH?!
# # COOL - BUT... IF MORE THAN ONE ON THE PAGE YOU MIGHT NOT BE SELECTING THE CORRECT INSTANCE.
# p title3 = doc.css('h1').text


# # CSS PATH - PRICE RANGE 
# # super-container > div > div > div.column.column-beta.sidebar > div.open-rail.clearfix > div.island.summary > ul > li:nth-child(2) > div.iconed-list-avatar > span
# p price_range = doc.css('div.iconed-list-avatar span').text

# # CSS PATH - BUSINESS ADDRESS
# # #wrap > div.biz-country-us > div > div.top-shelf > div > div.biz-page-subheader > div.mapbox-container > div > div.mapbox-text > ul > li.address
# p address = doc.css('li.address').text


# # CSS PATH - HOURS FOR WEEK
# # #super-container > div > div > div.column.column-beta.sidebar > div.bordered-rail > div.ywidget.biz-hours
# hours = doc.css('div div div.column.column-beta.sidebar div.bordered-rail div.ywidget.biz-hours').text
# hours2 = hours.gsub(/\n/,'')
# p hours3 = hours2.gsub('   ','')
# # puts doc.serialize( save_with: 0 )


binding.pry

puts "done"

# # NEXT STEP:
# # CREATE AN ARRAY CLASS TO STORE REIVEW DATA
# # MEET AT 2PM TO DISCUSS 'REVIEW CLASS'