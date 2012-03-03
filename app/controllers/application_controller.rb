class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
  end
  def sample_plan
    quarters = Array.new()
    (0 .. 15).each do |i|
      quarters.push([Course.all.sample,
                    Course.all.sample,
                    Course.all.sample,
                    Course.all.sample])
    end
    render :json => quarters
  end
end
