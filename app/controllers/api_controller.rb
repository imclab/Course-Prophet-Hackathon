class ApiController < ApplicationController

  def generate_plan
    if !params.key? :taken || !params.key? :major || !params.key? :units
      render :json => { :error => "Invalid parameters"}
    end

    list = {}

    if params.key? :college
      courses = Course.find_by

  end

end
