class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
  end
  def sample_plan
    courses = Course.joins(:department).select('courses.units, courses.id, courses.number, courses.name, courses.description, departments.acronym').all
    quarters = Array.new()
    (0 .. 15).each do |i|
      quarters.push([courses.sample,
                    courses.sample,
                    courses.sample,
                    courses.sample])
    end
    render :json => quarters
  end

  def print
    html = params[:data]
    kit = PDFKit.new(html, :page_size => 'Letter')
    kit.stylesheets << 'app/assets/stylesheets/courseprophet.css'
    kit.stylesheets << 'app/assets/stylesheets/bootstrap.css'
    filename = Time.now.to_i.to_s + '.pdf'
    kit.to_file(filename)
    render :json => {:filename => filename}
  end
end
