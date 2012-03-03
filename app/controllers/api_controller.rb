class ApiController < ApplicationController

  def generate_plan
    if !params.key?(:classestaken) || !params.key?(:units)
      render :json => { :error => "NO. SIT" }
      return
    end

    list = {}

    courses = Major.find_by_id(2).courses

    courses.each do |t|
      value = []
      Relation.where(:course => t[:id]).each do |a|
        value << a[:prereq]
        if courses.find_by_id(a[:prereq]) == nil
          courses << Course.find_by_id(a[:prereq])
        end
      end
      list[t[:id]] = value
    end

    sorted = list.tsort

    ret = []
    temp = []

    while !sorted.empty?
      units = 0
      while units <= params[:units].to_i
        course = Course.find_by_id sorted.pop if course == nil
        if course == nil
          break
        end
        if units + course[:units] > params[:units].to_i
          break
        end
        units += course[:units]
        temp << course[:name]
        course = nil
      end
      ret << temp
      temp = []
    end

    render :json => {:result => ret}

  end

  def list_courses
    if !params.key?(:major)
      render :json => { :error => "You need to specify a major id!" }
    end
    
    courses = Major.find_by_id(params[:major]).courses

    render :json => { :result => courses }

  end

end
