class ApiController < ApplicationController

  def top (required,plan,level,taken)
    i = 0
    Rails.logger.info("Level: #{level}")
    if ( level > 25)
      Rails.logger.info("#{plan.to_yaml} #{required.to_yaml}")
      throw Exception
    end
    while i < required.length
      relations = Relation.where("course = ?", required[i])

      if relations.count == 0
        plan.push({"id" => required[i], "level" => level})
        required.delete_at(i)
        i -= 1
        next
      end
      add_this_course = true

      relations.each do |relation|
        can_take = false
        plan.each do |taken|
          Rails.logger.info("#{relation.prereq} #{taken.to_yaml} FFFF")
          if relation.prereq == taken['id'] && taken['level'] != level
            Rails.logger.info("YAYAYAY!")
            can_take = true
            break
          else
            Rails.logger.info("BOO #{relation.prereq} #{taken['id']}")
          end
        end
        if !can_take
          taken.each do |taken|
            if relation.prereq == taken
              can_take = true
              break
            end
          end
        end

        if !can_take
          add_this_course = false
        end
      end

      if add_this_course
        plan.push({"id" => required[i], "level" => level})
        required.delete_at(i)
        i -= 1
      end
      i += 1
    end

    if required.count > 0
      Rails.logger.info("Included: #{plan.to_yaml}")
      return top(required,plan,level + 1,taken)
    else
      return plan
    end

  end

  def generate_plan
    if !params.key?(:classestaken)
      params[:classestaken] = []
    end

    if !params.key?(:units)
      params[:units] = '12'
    end
    
    db_courses = Major.where("name='Computer Science, B.S'").first.courses.all
    courses = Array.new

    db_courses.each do |course|
      skip = false
      params[:classestaken].each do |classtaken|
        Rails.logger.info("#{classtaken} #{course.id} FOO")
        if course.id == classtaken.to_i
          Rails.logger.info("#{Course.find(classtaken).name} is taken FOO")
          skip = true
          break
        end
      end
      if skip
        next
      else
        courses.push(course.id)
      end
    end
    #render :json => {:courses => db_courses}
    #return 
    list = top(courses,Array.new,0,params[:classestaken].map{|x| x.to_i})
    list.sort_by {|x| x['level']}
    quarters = Array.new
    quarters[0] = Array.new
    j = 0
    i = 1
    units_per_quarter = params[:units].to_i
    units = 0
    quarters[0].push(Course.find(list[0]['id']))
    while i < list.count
      Rails.logger.info('I: #{i}')
      if list[i]['level'] > list[i-1]['level'] && quarters[j].length > 0
        j += 1
        quarters[j] = Array.new
        units = 0
      end
      if units + Course.find(list[i]['id']).units > units_per_quarter
        Rails.logger.info("UNITS: #{units + Course.find(list[i]['id']).units}")
        j += 1
        quarters[j] = Array.new
        units = 0
      end
      quarters[j].push(Course.find(list[i]['id']))
      units += Course.find(list[i]['id']).units
      i += 1
    end

    quarters.each do |quarter|
      units = quarter.map{|c| c.units}.sum
      difference = ((units_per_quarter - units)/4).to_i
      Rails.logger.info("UNITS #{units} / #{units_per_quarter}")
      Rails.logger.info("DIFFERENCE #{difference}")
      difference.times do |i|
        quarter.push({:name => 'General Education',
                      :description => 'A general education course',
                      :units => 4})
      end
    end


    render :json => {:plan => quarters}


  end

  def list_courses
    if !params.key?(:major)
      render :json => { :error => "You need to specify a major id!" }
    end
    
    courses = Major.find_by_id(params[:major]).courses

    render :json => { :result => courses }

  end

end
