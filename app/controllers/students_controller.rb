class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    students = Student.where(school_id: params[:school_id], class_id: params[:class_id])
    render json: { data: students }
  end

  def create
    student = Student.new(student_params)

    if student.save
      secret_salt = "uchi_secret_2024"
      token = Digest::SHA256.hexdigest("#{student.id}#{secret_salt}")
      student.update(auth_token: token)

      response.set_header("X-Auth-Token", token)
      render json: student, status: :created
    else
      render json: { error: "Invalid input" }, status: :method_not_allowed
    end
  end

  def destroy
    student = Student.find(params[:user_id])

    auth_header = request.headers["Authorization"]
    token = auth_header&.split(" ")&.last

    if token.present? && student.auth_token == token
      student.destroy
      head :no_content
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Некорректный id студента" }, status: :bad_request
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :class_id, :school_id)
  end
end
