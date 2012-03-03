class ParseCourses

  def self.getPrerequisites()
    doc = Nokogiri::Slop(open("http://www.cs.ucsd.edu/node/2012"))
    count = -1
    doc.css("tr").each do |row|
      if ( count == -1)
        count += 1
        next
      end
      course_number = row.td[0].content.split('CSE ')[1]
      if course_number.nil?
        next
      end

      if Course.where('number = ?',course_number).count == 0
        next
      end

      course_id = Course.where('number = ?',course_number).first.id
      tokens = row.td[2].content.sub(',',' ').sub('.',' ').split(' ')

      if tokens.length < 2
        count += 1
        next
      end

      i = 0
      while ( i < tokens.length - 1)
        course = tokens[i]
        number = tokens[i+1]
        if course == 'CSE' || course == 'Math'

          if Course.where('number = ?',number).count == 0
            i+=1
            next
          end
          prereq_id = Course.where('number = ?',number).first.id
          Relation.create(course: course_id, prereq: prereq_id)
          if tokens.length > i + 3 && tokens[i+2] == 'or' && (tokens[i+3] == 'CSE' ||
             tokens[i+3] == 'Math')
            if Course.where('number = ?',tokens[i+4]).count == 0
              i +=4
              next
            end
            equiv_id = Course.where('number = ?',tokens[i+4]).first.id
            #Course.find(equiv_id).update_attribute(:provides,prereq_id)
            i += 4
          end
        end
        i+=1
      end
      count+= 1
    end
  end

  def self.getCourses(acronym)

    upper = acronym.upcase
    lower = acronym.downcase

    doc = Nokogiri::Slop(open("http://www.ucsd.edu/catalog/courses/#{upper}.html"))
    data = []
    count  = 0
    doc.css("a").each do |a|
      if !a['id'].nil? && a['id'].index(lower) == 0
        data[count] = Hash.new
        data[count]['number'] = a['id'].split(lower)[1].upcase
        count+= 1
      end
    end
    count = 0
    doc.css('p').each do |p|
      if p['class'] == 'course-name'
        data[count]['name'] = p.content
        data[count]['units'] = p.content[p.content.length-2].to_i
      end
      if p['class'] == 'course-descriptions'
        data[count]['description'] = p.content
        count += 1
      end
    end

    data.each do |datum|
      Course.create({name: datum['name'], description: datum['description'],
                     units: datum['units'], acronym: upper, number: datum['number']})
    end
  end
end