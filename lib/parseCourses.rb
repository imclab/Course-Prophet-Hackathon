require 'nokogiri'
require 'open-uri'

doc = Nokogiri::Slop(open('http://www.ucsd.edu/catalog/courses/CSE.html'))

data = []
count  = 0
doc.css("a").each do |a|
  if !a['id'].nil? && a['id'].index('cse') == 0
    data[count] = Hash.new
    data[count]['number'] = a['id'].split('cse')[1]
    count+= 1
  end
end
count = 0
doc.css('p').each do |p|
  if p['class'] == 'course-name'
    data[count]['name'] = p.content.dump
    data[count]['units'] = p.content[p.content.length-2].to_i
  end
  if p['class'] == 'course-descriptions'
    data[count]['description'] = p.content.dump
    count += 1
  end
end

data.each do |datum|
  string = "{name: #{datum['name']}, description: #{datum['description']}," +
          " units: #{datum['units']}, acronym: 'CSE', number: '#{datum['number']}'},"
  puts string
end