class ApiController < ApplicationController

  def generate_plan
    if !params.key?(:classestaken) || !params.key?(:units)
      render :json => { :error => "NO. SIT" }
      return
    end

    list = {}

    courses = Course.all

    courses.each do |t|
      value = []
      Relation.where(:course => t[:id]).each do |a|
        value << a[:prereq]
      end
      list[t[:id]] = value
    end

    render :text => list
    return

    sorted = list.tsort

    ret = []

    while !sorted.empty?
      temp = []
      units = 0
      while units < params[:units].to_i
        classTemp = Course.find_by_id sorted.pop
        units += classTemp[:units]
        temp << classTemp
      end
      ret << temp
    end

    render :json => {:result => ret}

  end

end
