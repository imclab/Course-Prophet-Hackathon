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
      return
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
    quarters[0].push(Course.find(list[i]['id']))
    while i < list.count
      Rails.logger.info('I: #{i}')
      if ( quarters[j].length > 3 )
        j+= 1
        quarters[j] = Array.new
      end
      if list[i]['level'] > list[i-1]['level'] && quarters[j].length > 0
        j += 1
        quarters[j] = Array.new
      end
      quarters[j].push(Course.find(list[i]['id']))
      i += 1
    end

    quarters.each do |quarter|
      difference = 4 - quarter.count
      difference.times do |i|
        quarter.push({:name => 'General Education',
                      :description => 'A general education course',
                      :units => 4})
      end
    end


    render :json => {:plan => quarters}

    # courses.each do |t|
    #   value = []
    #   Relation.where(:course => t[:id]).each do |a|
    #     value << a[:prereq]
    #     if courses.find_by_id(a[:prereq]) == nil
    #       courses << Course.find_by_id(a[:prereq])
    #     end
    #   end
    #   list[t[:id]] = value
    # end

    # sorted = list.tsort

    # ret = []
    # temp = []

    # while !sorted.empty?
    #   units = 0
    #   while units <= params[:units].to_i
    #     course = Course.find_by_id sorted.pop if course == nil
    #     if course == nil
    #       break
    #     end
    #     if units + course[:units] > params[:units].to_i
    #       break
    #     end
    #     units += course[:units]
    #     temp << course[:name]
    #     course = nil
    #   end
    #   ret << temp
    #   temp = []
    # end

    # render :json => {:result => ret}

  end

  def list_courses
    if !params.key?(:major)
      render :json => { :error => "You need to specify a major id!" }
    end
    
    courses = Major.find_by_id(params[:major]).courses

    render :json => { :result => courses }

  end

end
