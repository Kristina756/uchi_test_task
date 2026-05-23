class ClassesController < ApplicationController
  def index
    classes = SchoolClass.where(school_id: params[:school_id])
    data = classes.map do |c|
      {
        id: c.id,
        number: c.number,
        letter: c.letter,
        students_count: Student.where(class_id: c.id).count
      }
    end

    render json: { data: data }
  end
end
